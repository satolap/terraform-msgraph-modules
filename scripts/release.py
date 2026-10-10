"""Reconstruct and verify release assets from a GraphModules publication."""

from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import json
import os
import re
import subprocess
import tarfile
import tempfile
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen


def git(*args: str) -> str:
    return subprocess.run(
        ["git", *args], check=True, capture_output=True, text=True, encoding="utf-8"
    ).stdout.strip()


def archive(path: Path, files: dict[str, bytes]) -> None:
    with path.open("wb") as destination:
        with gzip.GzipFile(fileobj=destination, mode="wb", filename="", mtime=0) as compressed:
            with tarfile.open(fileobj=compressed, mode="w", format=tarfile.PAX_FORMAT) as output:
                for name, content in sorted(files.items()):
                    item = tarfile.TarInfo(name)
                    item.size, item.mtime, item.uid, item.gid = len(content), 0, 0, 0
                    item.uname = item.gname = ""
                    item.mode = 0o644
                    output.addfile(item, io.BytesIO(content))


def build(tag: str, directory: Path) -> tuple[str, list[Path]]:
    if not re.fullmatch(r"graphmodules-[0-9a-f]{20}", tag):
        raise ValueError("Invalid GraphModules release tag")
    sha = git("rev-parse", f"refs/tags/{tag}^{{commit}}")
    git("merge-base", "--is-ancestor", sha, "origin/main")
    # A separate worktree avoids running scripts from the publication tag.
    checkout = directory / "publication"
    git("worktree", "add", "--detach", str(checkout), sha)
    try:
        provenance = (checkout / "modules/generated/release-manifest.json").read_bytes()
        manifest = json.loads(provenance)
        inputs = {k: v for k, v in manifest.items() if k not in {"tag", "fingerprint"}}
        canonical = json.dumps(
            inputs, sort_keys=True, separators=(",", ":"), ensure_ascii=False
        ).encode("utf-8")
        fingerprint = hashlib.sha256(canonical).hexdigest()
        if (
            manifest["tag"] != tag
            or manifest["fingerprint"] != fingerprint
            or tag != f"graphmodules-{fingerprint[:20]}"
        ):
            raise ValueError("Manifest fingerprint does not match the release tag")
        notices = {
            n: (checkout / n).read_bytes()
            for n in ("LICENSE", "NOTICE")
            if (checkout / n).is_file()
        }
        assets = []
        for api in ("v1.0", "beta", "curated"):
            root = checkout / (
                "modules/curated" if api == "curated" else f"modules/generated/{api}"
            )
            prefix = "modules/curated" if api == "curated" else f"modules/generated/{api}"
            files = {}
            for path in root.rglob("*"):
                if path.is_symlink():
                    raise ValueError("Publication contains a symlink")
                if path.is_file():
                    files[f"{prefix}/{path.relative_to(root).as_posix()}"] = path.read_bytes()
            if not any(n.endswith("/main.tf") for n in files):
                raise ValueError(f"Missing {api} module catalog")
            files.update(notices)
            files["release-manifest.json"] = provenance
            destination = directory / f"graphmodules-{api}-modules.tar.gz"
            archive(destination, files)
            assets.append(destination)
        manifest_file = directory / "release-manifest.json"
        manifest_file.write_bytes(provenance)
        assets.append(manifest_file)
        # Optional: releases published before this asset existed do not have it.
        changes = checkout / ".release/interface-changes.json"
        if changes.is_symlink():
            raise ValueError("Publication contains a symlink")
        if changes.is_file():
            changes_file = directory / changes.name
            changes_file.write_bytes(changes.read_bytes())
            assets.append(changes_file)
        elif changes.exists():
            raise ValueError("Publication .release/interface-changes.json is not a regular file")
        expected = (checkout / ".release/SHA256SUMS").read_bytes()
        actual = "".join(
            f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.name}\n" for p in sorted(assets)
        ).encode("utf-8")
        if expected.splitlines() != actual.splitlines():
            raise ValueError("Committed modules do not reproduce the tested SHA256SUMS")
        checksums = directory / "SHA256SUMS"
        checksums.write_bytes(expected)
        notes = (checkout / ".release/release-notes.md").read_text(encoding="utf-8")
        (directory / "release-notes.md").write_text(
            notes + f"\nGraphModules publication: `{sha}`.\n", encoding="utf-8"
        )
        return sha, [*assets, checksums]
    finally:
        git("worktree", "remove", str(checkout))


def request_json(repository: str, suffix: str):
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "GraphModules-release",
    }
    # Published releases of this public repository can be verified without a token.
    if os.environ.get("GH_TOKEN"):
        headers["Authorization"] = f"Bearer {os.environ['GH_TOKEN']}"
    request = Request(f"https://api.github.com/repos/{repository}/{suffix}", headers=headers)
    with urlopen(request, timeout=60) as response:
        return json.load(response)


def verify_assets(repository: str, tag: str, sha: str, assets: list[Path]) -> None:
    published = request_json(repository, f"releases/tags/{tag}")
    if published["target_commitish"] != sha:
        raise ValueError("Published release does not target the validated publication")
    expected = {p.name: f"sha256:{hashlib.sha256(p.read_bytes()).hexdigest()}" for p in assets}
    actual = {a["name"]: a.get("digest") for a in published["assets"]}
    changed = sorted(n for n in expected.keys() | actual.keys() if expected.get(n) != actual.get(n))
    if changed:
        raise ValueError(f"Published release assets differ from the rebuild: {', '.join(changed)}")


def update_latest_branch(repository: str, tag: str, sha: str) -> None:
    """Fast-forward the latest branch to a publication that is the GitHub Latest release."""
    try:
        latest = request_json(repository, "releases/latest")["tag_name"]
    except HTTPError as error:
        if error.code != 404:
            raise
        latest = None
    # A recovery run for an older tag must not move the branch backwards.
    if latest != tag:
        print(f"Leaving branch latest unchanged: {tag} is not the GitHub Latest release ({latest})")
        return
    remote = git("ls-remote", "origin", f"refs/tags/{tag}").split()
    if not remote or remote[0] != sha:
        print(f"Leaving branch latest unchanged: remote tag {tag} does not identify {sha}")
        return
    try:
        current = request_json(repository, "git/ref/heads/latest")["object"]["sha"]
    except HTTPError as error:
        if error.code != 404:
            raise
        current = None
    if current == sha:
        print(f"Branch latest already points at {sha}")
        return
    if current is None:
        target = ["--method", "POST", f"repos/{repository}/git/refs", "-f", "ref=refs/heads/latest"]
    else:
        # With force=false GitHub rejects any update that is not a fast-forward.
        path = f"repos/{repository}/git/refs/heads/latest"
        target = ["--method", "PATCH", path, "-F", "force=false"]
    result = subprocess.run(
        ["gh", "api", *target, "-f", f"sha={sha}"],
        check=False,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    error = result.stderr.strip()
    if result.returncode and current and "(HTTP 422)" in error:
        raise ValueError(
            f"GitHub rejected moving branch latest from {current} to {sha}; "
            f"it is never force-updated: {error}"
        )
    if result.returncode:
        raise ValueError(f"Could not point branch latest at {sha}: {error}")
    if json.loads(result.stdout)["object"]["sha"] != sha:
        raise ValueError("GitHub did not move branch latest to the validated publication")
    moved = "created at" if current is None else f"moved from {current} to"
    print(f"Branch latest {moved} {sha}")


def update_latest_branch_or_warn(repository: str, tag: str, sha: str) -> None:
    """Warn instead of failing the job: the release is already published at this point."""
    try:
        update_latest_branch(repository, tag, sha)
    except Exception as error:
        # Likely cause: the range changes workflow files, and GITHUB_TOKEN cannot hold the
        # workflow permission GitHub then requires. The daily verification reports the drift.
        message = (
            f"Release {tag} is published, but branch latest was not moved: {error}. "
            "An account with workflow permission can fast-forward it with "
            f"`git push origin {sha}:refs/heads/latest`, "
            "or re-run this workflow after the branch has been created."
        )
        warn(message)


# The public Terraform Registry publishes a repository named terraform-<PROVIDER>-<NAME> as
# <owner>/<NAME>/<PROVIDER>, one version per semver tag; it ignores the graphmodules-* tags.
REGISTRY_REPOSITORY = re.compile(r"([A-Za-z0-9-]+)/terraform-([a-z0-9]+)-([a-z0-9-]+)")
REGISTRY_TAG = re.compile(r"v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)")
INITIAL_REGISTRY_VERSION = (1, 0, 0)


def registry_address(repository: str) -> str | None:
    """The registry address of a repository named for the registry, otherwise None."""
    match = REGISTRY_REPOSITORY.fullmatch(repository)
    if not match:
        return None
    owner, provider, name = match.groups()
    return f"{owner}/{name}/{provider}"


def registry_tags() -> dict[tuple[int, int, int], str]:
    """Every semver tag on origin, as version -> peeled commit."""
    listed = git("ls-remote", "--tags", "origin", "refs/tags/v*")
    commits: dict[tuple[int, int, int], str] = {}
    for line in listed.splitlines():
        commit, name = line.split("\t")
        peeled = name.endswith("^{}")
        match = REGISTRY_TAG.fullmatch(name.removeprefix("refs/tags/").removesuffix("^{}"))
        # The peeled line of an annotated tag names its commit; it follows the tag object line.
        if match and (peeled or tuple(map(int, match.groups())) not in commits):
            commits[tuple(map(int, match.groups()))] = commit
    return commits


def is_ancestor(ancestor: str, commit: str) -> bool:
    result = subprocess.run(
        ["git", "merge-base", "--is-ancestor", ancestor, commit],
        check=False,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    if result.returncode not in (0, 1):
        raise ValueError(f"git merge-base {ancestor} {commit} failed: {result.stderr.strip()}")
    return result.returncode == 0


CHANGES_PATH = ".release/interface-changes.json"


def version_bump(changes: dict) -> int:
    """The semver part a publication bumps: 0 major, 1 minor, 2 patch.

    Only blocking gate findings need a release decision, so any decision is a breaking
    change. Any other finding (an added module, input or output, or a notice) is a
    compatible change. A publication without findings changed no module interface.
    """
    if not changes["comparison_supplied"] or changes["decisions"]:
        return 0
    return 1 if changes["counts"] or changes["notices"] else 2


def range_bump(tag: str, since: str, sha: str) -> int:
    """The largest bump of every publication after `since` up to `sha`.

    Each interface-changes.json compares a publication with the one before it, so a
    publication whose registry tag was never created still counts in the next version.
    """
    commits = git("log", "--format=%H", f"{since}..{sha}", "--", CHANGES_PATH).split()
    if sha not in commits:
        raise ValueError(f"{tag} does not change {CHANGES_PATH}")
    parts = []
    for commit in commits:
        changes = json.loads(git("show", f"{commit}:{CHANGES_PATH}"))
        if commit == sha and changes.get("tag") != tag:
            raise ValueError(f"{CHANGES_PATH} does not describe {tag}")
        parts.append(version_bump(changes))
    return min(parts)


def format_version(version: tuple[int, int, int]) -> str:
    return "v{}.{}.{}".format(*version)


def registry_version(tag: str, sha: str) -> tuple[str, bool] | None:
    """The registry version of a publication and whether its tag exists already.

    None when a newer publication has a registry version: a recovery run for an older tag
    must not give it a version above that one.
    """
    tags = registry_tags()
    existing = [version for version, commit in tags.items() if commit == sha]
    if existing:
        return format_version(max(existing)), True
    if not tags:
        return format_version(INITIAL_REGISTRY_VERSION), False
    newest = max(tags)
    if not is_ancestor(tags[newest], sha):
        return None
    part = range_bump(tag, tags[newest], sha)
    version = (*newest[:part], newest[part] + 1, *(0,) * (2 - part))
    return format_version(version), False


def create_registry_tag(repository: str, version: str, sha: str) -> None:
    result = subprocess.run(
        [
            "gh", "api", "--method", "POST", f"repos/{repository}/git/refs",
            "-f", f"ref=refs/tags/{version}", "-f", f"sha={sha}",
        ],
        check=False,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    if result.returncode:
        raise ValueError(f"Could not create tag {version} at {sha}: {result.stderr.strip()}")
    if json.loads(result.stdout)["object"]["sha"] != sha:
        raise ValueError(f"GitHub did not create tag {version} at the validated publication")
    print(f"Tag {version} created at {sha}")


def warn(message: str) -> None:
    annotation = message.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")
    print(f"::warning::{annotation}")
    if os.environ.get("GITHUB_STEP_SUMMARY"):
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as output:
            output.write(f"{message}\n")


def plan_registry_version(repository: str, tag: str, sha: str):
    """The registry version to tag after publishing, or None; warns instead of failing.

    The GitHub Release does not depend on the registry, so a version that cannot be chosen
    must not stop it. The daily verification reports a Latest release without a version.
    """
    address = registry_address(repository)
    if address is None:
        return None
    try:
        planned = registry_version(tag, sha)
    except Exception as error:
        warn(f"No Terraform Registry version chosen for {tag}: {error}")
        return None
    if planned is None:
        print(f"No Terraform Registry version for {tag}: a newer publication has one")
    return planned


def tag_registry_version_or_warn(repository: str, sha: str, planned) -> None:
    """Create the planned semver tag; the release is already published at this point."""
    if planned is None:
        return
    version, exists = planned
    if exists:
        print(f"Tag {version} already identifies {sha}")
        return
    try:
        create_registry_tag(repository, version, sha)
    except Exception as error:
        # Likely cause, as for branch latest: the commit changes workflow files.
        warn(
            f"Terraform Registry tag {version} was not created: {error}. "
            "An account with workflow permission can create it with "
            f"`git push origin {sha}:refs/tags/{version}`."
        )


def published_release_commits(repository: str) -> dict[str, str]:
    """Commit -> tag of every published GraphModules release."""
    published, page = set(), 1
    while True:
        releases = request_json(repository, f"releases?per_page=100&page={page}")
        published.update(r["tag_name"] for r in releases if not r["draft"])
        if len(releases) < 100:
            break
        page += 1
    tags: dict[str, str] = {}
    for line in git("ls-remote", "--tags", "origin", "refs/tags/graphmodules-*").splitlines():
        commit, name = line.split("\t")
        tag = name.removeprefix("refs/tags/").removesuffix("^{}")
        # The peeled line of an annotated tag names its commit; it follows the tag object line.
        if tag in published and (name.endswith("^{}") or tag not in tags):
            tags[tag] = commit
    return {commit: tag for tag, commit in tags.items()}


def verify_registry_tags(repository: str) -> list[str]:
    """Check that the semver tags follow the published releases; returns the failures."""
    address = registry_address(repository)
    if address is None:
        print(f"{repository} is not named terraform-<PROVIDER>-<NAME>; no registry tags expected")
        return []
    tags = registry_tags()
    releases = published_release_commits(repository)
    failures = []
    for version, commit in sorted(tags.items()):
        if commit not in releases:
            failures.append(f"{format_version(version)} at {commit} is not a published release")
    ordered = sorted(tags.items())
    for (older, before), (newer, after) in zip(ordered, ordered[1:]):
        if before == after or not is_ancestor(before, after):
            failures.append(
                f"{format_version(newer)} does not follow {format_version(older)} in history"
            )
    latest = request_json(repository, "releases/latest")["tag_name"]
    latest_commit = next((c for c, t in releases.items() if t == latest), None)
    if tags and latest_commit not in tags.values():
        failures.append(f"GitHub Latest release {latest} has no registry version tag")
    for failure in failures:
        print(f"::error::{failure}")
    if not failures:
        newest = format_version(max(tags)) if tags else "none yet"
        print(f"Registry tags of {address} verified; newest version: {newest}")
    return failures


def release(repository: str, tag: str, sha: str, assets: list[Path], directory: Path) -> None:
    def gh(*args: str):
        subprocess.run(["gh", "release", *args, "--repo", repository], check=True)

    try:
        existing = request_json(repository, f"releases/tags/{tag}")
    except HTTPError as error:
        if error.code != 404:
            raise
        existing = None
    if not existing:
        page = 1
        while True:
            releases = request_json(repository, f"releases?per_page=100&page={page}")
            existing = next((r for r in releases if r["tag_name"] == tag), None)
            if existing or len(releases) < 100:
                break
            page += 1
    refs = git("ls-remote", "origin", f"refs/tags/{tag}")
    if refs.split()[0] != sha:
        raise ValueError("Remote release tag no longer identifies the validated publication")
    planned = plan_registry_version(repository, tag, sha)
    if existing and not existing["draft"]:
        print(f"Release already published: {existing['html_url']}")
        update_latest_branch_or_warn(repository, tag, sha)
        tag_registry_version_or_warn(repository, sha, planned)
        return
    if existing and existing["target_commitish"] != sha:
        raise ValueError("Existing draft targets a different publication")
    if planned is not None:
        with (directory / "release-notes.md").open("a", encoding="utf-8") as output:
            output.write(
                f"Terraform Registry: `{registry_address(repository)}` version "
                f"`{planned[0].removeprefix('v')}`.\n"
            )
    notes = str(directory / "release-notes.md")
    if not existing:
        gh(
            "create",
            tag,
            "--draft",
            "--verify-tag",
            "--target",
            sha,
            "--title",
            f"GraphModules {tag}",
            "--notes-file",
            notes,
        )
    gh("upload", tag, *map(str, assets), "--clobber")
    if git("ls-remote", "origin", f"refs/tags/{tag}").split()[0] != sha:
        raise ValueError("Remote release tag changed during asset upload")
    # Do not make an older recovery run the newest release.
    latest = git(
        "log",
        "-1",
        "--format=%H",
        "origin/main",
        "--",
        "modules",
        ".release",
    )
    gh(
        "edit",
        tag,
        "--draft=false",
        "--latest" if latest == sha else "--latest=false",
        "--notes-file",
        notes,
    )
    update_latest_branch_or_warn(repository, tag, sha)
    tag_registry_version_or_warn(repository, sha, planned)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag")
    parser.add_argument("--repository", required=True)
    parser.add_argument("--verify-only", action="store_true")
    parser.add_argument("--verify-assets", action="store_true")
    parser.add_argument(
        "--verify-registry-tags",
        action="store_true",
        help="check the Terraform Registry semver tags against the published releases",
    )
    args = parser.parse_args()
    if args.verify_registry_tags:
        if verify_registry_tags(args.repository):
            raise SystemExit("Registry tag verification failed")
        return
    if not args.tag:
        parser.error("--tag is required")
    with tempfile.TemporaryDirectory(prefix="graphmodules-") as temporary:
        directory = Path(temporary)
        sha, assets = build(args.tag, directory)
        if args.verify_assets:
            verify_assets(args.repository, args.tag, sha, assets)
        elif not args.verify_only:
            release(args.repository, args.tag, sha, assets, directory)
        print(f"Verified {args.tag} at {sha}")


if __name__ == "__main__":
    main()
