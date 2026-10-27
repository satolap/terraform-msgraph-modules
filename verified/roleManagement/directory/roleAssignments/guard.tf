# Embedded so the guard is included in the published Terraform archive.
# It performs read-only checks; msgraph_resource remains the sole writer.
locals {
  assignment_guard = <<-PYTHON
    """Read-only guards for direct role assignments; never creates or deletes an object.

    The provider performs POST/DELETE. This guard refuses duplicate creates and blocks
    destroy unless the captured assignment identity agrees with its original tuple.
    Only the public-cloud Graph endpoint is supported by this module's CLI guards.
    """

    from __future__ import annotations

    import json
    import os
    import re
    import shutil
    import subprocess
    import sys
    from urllib.error import HTTPError
    from urllib.parse import quote, urlencode, urlsplit
    from urllib.request import HTTPRedirectHandler, Request, build_opener

    BASE = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments"
    GUID = re.compile(r"[0-9a-fA-F]{8}(?:-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}")
    ASSIGNMENT_ID = re.compile(r"[A-Za-z0-9_-]{1,512}")
    SCOPE = re.compile(r"/((administrativeUnits/)?[0-9a-fA-F]{8}(?:-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12})?")


    class Refusal(RuntimeError):
        """A guard cannot establish that an operation is safe."""


    class NoRedirect(HTTPRedirectHandler):
        def redirect_request(self, req, fp, code, msg, headers, newurl):
            raise Refusal("Graph redirect refused.")


    def cli(*args):
        executable = shutil.which("az")
        if not executable:
            raise Refusal("Azure CLI is required for assignment guards.")
        result = subprocess.run(
            [executable, *args, "-o", "tsv", "--only-show-errors"],
            capture_output=True, text=True, check=False, timeout=120,
        )
        if result.returncode:
            # Do not print CLI stderr, tokens, tenant identifiers or Graph responses.
            raise Refusal("Azure CLI authentication failed.")
        return result.stdout.strip()


    def graph_reader(tenant_id):
        expected = os.environ.get("ARM_TENANT_ID", "").lower()
        if expected != tenant_id or not GUID.fullmatch(tenant_id):
            raise Refusal("ARM_TENANT_ID must match the captured provider tenant_id.")
        if cli("account", "show", "--query", "tenantId").lower() != tenant_id:
            raise Refusal("Azure CLI tenant differs from the captured provider tenant_id.")
        token = cli(
            "account", "get-access-token", "--tenant", tenant_id,
            "--resource", "https://graph.microsoft.com", "--query", "accessToken",
        )
        if not re.fullmatch(r"[A-Za-z0-9._~+/=-]+", token):
            raise Refusal("Azure CLI returned no usable Graph access token.")
        opener = build_opener(NoRedirect())

        def read(url):
            parsed = urlsplit(url)
            if (parsed.scheme, parsed.netloc, parsed.path) != (
                "https", "graph.microsoft.com", urlsplit(BASE).path
            ) and not url.startswith(BASE + "/"):
                raise Refusal("Unexpected Graph URL refused.")
            request = Request(url, headers={"Authorization": "Bearer " + token})
            try:
                with opener.open(request, timeout=120) as response:
                    return json.load(response)
            except HTTPError as error:
                if error.code == 404:
                    return None
                raise Refusal(f"Graph read failed (HTTP {error.code}); no write authorized.") from None

        return read


    def validate_body(body):
        if not isinstance(body, dict) or set(body) != {
            "principalId", "roleDefinitionId", "directoryScopeId"
        }:
            raise Refusal("The captured assignment tuple is incomplete.")
        for key in ("principalId", "roleDefinitionId"):
            if not isinstance(body[key], str) or not GUID.fullmatch(body[key]):
                raise Refusal("The captured assignment tuple has an invalid identifier.")
        if not isinstance(body["directoryScopeId"], str) or not SCOPE.fullmatch(body["directoryScopeId"]):
            raise Refusal("The captured assignment tuple has an invalid scope.")


    def same_tuple(assignment, body):
        if not isinstance(assignment, dict):
            raise Refusal("Malformed Graph assignment response.")
        for key in body:
            if not isinstance(assignment.get(key), str):
                raise Refusal("Graph assignment response is missing identity fields.")
        return all(assignment[key].lower() == value.lower() for key, value in body.items())


    def check_duplicates(body, read):
        url = BASE + "?" + urlencode({"$filter": "principalId eq '" + body["principalId"] + "'"})
        seen = set()
        while url:
            parsed = urlsplit(url)
            if (parsed.scheme, parsed.netloc, parsed.path) != (
                "https", "graph.microsoft.com", urlsplit(BASE).path
            ) or parsed.fragment:
                raise Refusal("Unexpected pagination URL refused.")
            if url in seen or len(seen) >= 1000:
                raise Refusal("Incomplete or cyclic assignment pagination refused.")
            seen.add(url)
            response = read(url)
            if not isinstance(response, dict) or not isinstance(response.get("value"), list):
                raise Refusal("Could not establish assignment collection absence.")
            for assignment in response["value"]:
                if same_tuple(assignment, body):
                    raise Refusal("An assignment already exists for this principal, role and scope; no adoption.")
            url = response.get("@odata.nextLink")
            if url is not None and (not isinstance(url, str) or not url):
                raise Refusal("Malformed pagination refused.")


    def check_owned(assignment_id, body, read):
        if not isinstance(assignment_id, str) or not ASSIGNMENT_ID.fullmatch(assignment_id):
            raise Refusal("No valid captured assignment ID; provider deletion is blocked.")
        assignment = read(BASE + "/" + quote(assignment_id, safe=""))
        if assignment is None:  # An actual 404 at this exact ID is already absent.
            return
        if not same_tuple(assignment, body):
            raise Refusal("Assignment identity differs; provider deletion is blocked.")
        if assignment.get("id") != assignment_id or assignment.get("appScopeId") is not None:
            raise Refusal("Assignment ID or scope namespace differs; provider deletion is blocked.")


    def main():
        try:
            body = json.loads(os.environ.get("GRAPH_ASSIGNMENT", "null"))
            validate_body(body)
            if len(sys.argv) != 2 or sys.argv[1] not in ("duplicate", "owned"):
                raise Refusal("Expected duplicate or owned guard mode.")
            read = graph_reader(os.environ.get("GRAPH_TENANT_ID", "").lower())
            if sys.argv[1] == "duplicate":
                check_duplicates(body, read)
            else:
                check_owned(os.environ.get("GRAPH_ASSIGNMENT_ID"), body, read)
        except (Refusal, ValueError, OSError, subprocess.SubprocessError):
            # No raw response, token or tenant data in Terraform logs.
            print("Directory role assignment guard refused; verify tenant, identity and captured state.", file=sys.stderr)
            return 1
        return 0


    if __name__ == "__main__":
        sys.exit(main())
  PYTHON
}
