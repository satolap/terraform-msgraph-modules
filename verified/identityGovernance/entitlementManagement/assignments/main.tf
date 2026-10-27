locals {
  # Only v1.0 is admitted: its request states and assignment states are the
  # vocabulary this module classifies. The beta pages spell and enumerate them
  # differently (PascalCase, "Canceled" without a lowercase form, no adminUpdate
  # in the requestType enum), so beta is not a supported target.
  api_version      = "v1.0"
  requests_path    = "identityGovernance/entitlementManagement/assignmentRequests"
  assignments_path = "identityGovernance/entitlementManagement/assignments"

  adopting = var.adopt_assignment_id != null

  # An assignment this module granted is always revoked on destroy. One it only
  # adopted is revoked only on request.
  revoke_on_destroy = !local.adopting || var.revoke_adopted_assignment_on_destroy

  # A request ID that Graph did not return must fail the read loudly instead of
  # turning the read into a listing of the whole collection.
  missing_request_id = "request-id-not-returned"

  # accessPackageAssignmentRequest.state (v1.0) bucketed into phases. The bucketing
  # is this module's, not Graph's. Anything outside the v1.0 enum, including the
  # beta spellings, is "unknown" and is never read as delivered.
  phase_by_state = {
    submitted          = "pending"
    pendingApproval    = "pending"
    scheduled          = "pending"
    delivering         = "pending"
    delivered          = "delivered"
    denied             = "denied"
    canceled           = "canceled"
    deliveryFailed     = "failed"
    partiallyDelivered = "partial"
  }
  failed_phases = ["denied", "canceled", "failed", "partial"]

  add_schedule = var.schedule == null ? {} : {
    schedule = merge(
      var.schedule.start_date_time != null ? { startDateTime = var.schedule.start_date_time } : {},
      var.schedule.expiration != null ? {
        expiration = merge(
          { type = var.schedule.expiration.type },
          var.schedule.expiration.end_date_time != null ? { endDateTime = var.schedule.expiration.end_date_time } : {},
          var.schedule.expiration.duration != null ? { duration = var.schedule.expiration.duration } : {},
        )
      } : {},
    )
  }

  add_body = merge(
    {
      requestType = "adminAdd"
      assignment = {
        targetId           = var.target_id
        assignmentPolicyId = var.assignment_policy_id
        accessPackageId    = var.access_package_id
      }
      justification = var.justification
    },
    local.add_schedule,
  )

  request_id = try(msgraph_resource_action.add[0].output.request_id, null)
}

# Every input that decides which assignment this module owns. A change replaces
# the request and the destroy hook, so the old assignment is revoked before the
# new one is requested. The schedule and the justification are deliberately not
# here: they are captured when the request is sent and never re-sent.
resource "terraform_data" "identity" {
  input = {
    target_id            = var.target_id
    access_package_id    = var.access_package_id
    assignment_policy_id = var.assignment_policy_id
    adopt_assignment_id  = var.adopt_assignment_id
    replacement_token    = var.replacement_token
    api_version          = local.api_version
  }
}

# Submits the adminAdd request. An accepted request is not a delivered assignment:
# it can wait for approval, be denied, canceled or fail, and Graph returns no
# assignment ID with it. The request object supports no PATCH, and this action is
# forgotten on destroy, so the hook below revokes the assignment instead.
#
# The action runs once. Plans and applies that follow never send it again, so a
# request that was accepted but is not delivered yet is recovered by a later apply
# that re-reads it, not by a second adminAdd. Never add create_before_destroy: the
# new adminAdd would meet the old assignment, and the destroy-time revoke would
# then remove the new one. With adopt_assignment_id set, no request is sent.
resource "msgraph_resource_action" "add" {
  count = local.adopting ? 0 : 1

  resource_url = local.requests_path
  method       = "POST"
  api_version  = local.api_version
  body         = local.add_body

  response_export_values = {
    request_id = "id"
    state      = "state"
    status     = "status"
  }

  lifecycle {
    # The body is captured at creation; see terraform_data.identity.
    ignore_changes       = all
    replace_triggered_by = [terraform_data.identity]
  }
}

# One bounded wait for approval-free delivery and for Graph to list the assignment.
resource "time_sleep" "wait_for_delivery" {
  depends_on      = [msgraph_resource_action.add, null_resource.remove_on_destroy]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.identity]
  }
}

# Reads the request back. The state decides whether the access was delivered, is
# still pending (for example, waiting for an approver), or was refused.
data "msgraph_resource" "request" {
  count = local.adopting ? 0 : 1

  url         = "${local.requests_path}/${coalesce(local.request_id, local.missing_request_id)}"
  api_version = local.api_version

  response_export_values = {
    state  = "state"
    status = "status"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

# Lists the assignments for the package and the subject, expanded so that the
# match below can re-check the subject, the policy and the package. The filter
# only narrows the list; the match decides. The first page is read: an
# unexpected number of matches is refused, never guessed.
data "msgraph_resource" "assignments" {
  url         = local.assignments_path
  api_version = local.api_version

  query_parameters = {
    "$filter" = ["accessPackage/id eq '${var.access_package_id}' and target/objectId eq '${var.target_id}'"]
    "$expand" = ["target,assignmentPolicy,accessPackage"]
  }

  response_export_values = {
    assignments = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

locals {
  request_state = local.adopting ? null : try(data.msgraph_resource.request[0].output.state, null)
  request_phase = local.adopting ? "adopted" : lookup(local.phase_by_state, local.request_state_text, "unknown")

  # Assignments of exactly this subject, policy and package. When adopting, also
  # exactly the adopted ID.
  matched = [
    for a in try(data.msgraph_resource.assignments.output.assignments, []) : a
    if lower(try(a.target.objectId, "")) == lower(var.target_id)
    && lower(try(a.assignmentPolicy.id, "")) == lower(var.assignment_policy_id)
    && lower(try(a.accessPackage.id, "")) == lower(var.access_package_id)
    && (!local.adopting || lower(try(a.id, "")) == lower(coalesce(var.adopt_assignment_id, "x")))
  ]

  # An expired assignment is history: a new grant for the same subject creates a
  # new assignment. A live one (any other state) is the candidate. One live match
  # is the assignment; none live and one expired reports the expired one; any
  # other count is ambiguous and resolves to nothing.
  live    = [for a in local.matched : a if try(a.state, "") != "expired"]
  expired = [for a in local.matched : a if try(a.state, "") == "expired"]

  ambiguous = length(local.live) > 1 || (length(local.live) == 0 && length(local.expired) > 1)

  assignment_id = (
    length(local.live) == 1 ? try(local.live[0].id, null) :
    length(local.live) == 0 && length(local.expired) == 1 ? try(local.expired[0].id, null) :
    null
  )
  assignment_state = (
    length(local.live) == 1 ? try(local.live[0].state, null) :
    length(local.live) == 0 && length(local.expired) == 1 ? "expired" :
    null
  )
  assignment_schedule_json = local.assignment_id == null ? null : try(jsonencode([for a in local.matched : a.schedule if a.id == local.assignment_id][0]), null)

  # Delivered means the request was delivered (or the assignment adopted) and the
  # one matching assignment reports delivered. It is Graph's report about the
  # assignment, not a measurement of what the subject can reach.
  delivered = (
    contains(["delivered", "adopted"], local.request_phase)
    && !local.ambiguous
    && local.assignment_id != null
    && local.assignment_state == "delivered"
  )

  request_id_text    = local.request_id != null ? local.request_id : "none"
  request_state_text = local.request_state != null ? local.request_state : ""
  assignment_id_text = local.assignment_id != null ? local.assignment_id : ""
}

# Fails apply, with a message that separates a refused request, a pending one,
# an ambiguous match and an expired assignment from a delivered one. Applies
# that fail here leave the request in state; the next apply re-reads it.
resource "terraform_data" "verification_gate" {
  input = local.delivered

  lifecycle {
    precondition {
      condition     = !contains(local.failed_phases, local.request_phase)
      error_message = "The adminAdd request ${local.request_id_text} ended as ${local.request_state_text} (status: ${coalesce(try(data.msgraph_resource.request[0].output.status, null), "unknown")}), so no access was delivered. A denied or canceled request is a decision, not a fault: a new request needs a new replacement_token. A failed or partially delivered one needs the cause fixed first; see the request in the My Access portal or in Graph."
    }

    precondition {
      condition     = local.request_phase != "unknown" || !var.require_delivery
      error_message = "The adminAdd request ${local.request_id_text} reports state '${local.request_state_text}', which is not in the v1.0 state list this module classifies (submitted, pendingApproval, scheduled, delivering, delivered, denied, canceled, deliveryFailed, partiallyDelivered). It is not treated as delivered. Set require_delivery = false to track it."
    }

    precondition {
      condition     = local.request_phase != "pending" || !var.require_delivery
      error_message = "The adminAdd request ${local.request_id_text} is still ${local.request_state_text} after ${var.verification_delay_seconds}s. This module never approves a request: wait for the approver or the policy, then apply again to re-read it without sending a second request, or set require_delivery = false to track a pending request."
    }

    precondition {
      condition     = !local.ambiguous
      error_message = "Found ${length(local.live)} live and ${length(local.expired)} expired assignments for subject '${var.target_id}', policy '${var.assignment_policy_id}' and package '${var.access_package_id}'; expected exactly one. The module refuses to guess which one it owns. Remove the extra assignments, or name the one to keep with adopt_assignment_id."
    }

    precondition {
      condition     = !(contains(["delivered", "adopted"], local.request_phase) && local.assignment_state == "expired")
      error_message = "The assignment ${local.assignment_id_text} for subject '${var.target_id}' has expired. Change replacement_token to revoke it and request access again, or remove this module."
    }

    precondition {
      condition     = local.delivered || !var.require_delivery || local.request_phase == "pending" || local.request_phase == "unknown"
      error_message = "The request ${local.request_id_text} is ${local.request_phase == "adopted" ? "an adoption" : "delivered"}, but ${length(local.live)} live assignments match subject '${var.target_id}', policy '${var.assignment_policy_id}' and package '${var.access_package_id}' (assignment state: ${coalesce(local.assignment_state, "none")}); expected exactly one in state delivered. Graph may not have listed it yet: apply again, or raise verification_delay_seconds. With adopt_assignment_id, check that the ID belongs to those three identities."
    }
  }

  depends_on = [data.msgraph_resource.request, data.msgraph_resource.assignments]
}

locals {
  update_schedule = var.schedule_update == null ? {} : {
    schedule = merge(
      var.schedule_update.start_date_time != null ? { startDateTime = var.schedule_update.start_date_time } : {},
      var.schedule_update.expiration != null ? {
        expiration = merge(
          { type = var.schedule_update.expiration.type },
          var.schedule_update.expiration.end_date_time != null ? { endDateTime = var.schedule_update.expiration.end_date_time } : {},
          var.schedule_update.expiration.duration != null ? { duration = var.schedule_update.expiration.duration } : {},
        )
      } : {},
    )
  }

  update_body = merge(
    {
      requestType   = "adminUpdate"
      assignment    = { id = local.assignment_id }
      justification = var.justification
    },
    local.update_schedule,
  )

  update_request_id         = try(msgraph_resource_action.update[0].output.request_id, null)
  update_request_state      = var.schedule_update == null ? null : try(data.msgraph_resource.update_request[0].output.state, null)
  update_request_state_text = local.update_request_state != null ? local.update_request_state : ""
  update_request_phase      = var.schedule_update == null ? null : lookup(local.phase_by_state, local.update_request_state_text, "unknown")
}

# Changing schedule_update sends a new adminUpdate; the old one is not undone.
resource "terraform_data" "update_input" {
  input = var.schedule_update
}

# Sends adminUpdate for the resolved assignment, after the gate confirmed it.
# The assignment ID comes from the read-back, never from a request ID.
resource "msgraph_resource_action" "update" {
  count = var.schedule_update != null ? 1 : 0

  resource_url = local.requests_path
  method       = "POST"
  api_version  = local.api_version
  body         = local.update_body

  response_export_values = {
    request_id = "id"
    state      = "state"
  }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.update_input, terraform_data.identity]

    precondition {
      condition     = local.delivered
      error_message = "adminUpdate needs a delivered assignment resolved from the read-back (request phase ${local.request_phase}, assignment state ${coalesce(local.assignment_state, "none")}); it never targets an unresolved or pending one."
    }
  }

  depends_on = [terraform_data.verification_gate]
}

resource "time_sleep" "wait_for_update" {
  count = var.schedule_update != null ? 1 : 0

  depends_on      = [msgraph_resource_action.update]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.update_input, terraform_data.identity]
  }
}

data "msgraph_resource" "update_request" {
  count = var.schedule_update != null ? 1 : 0

  url         = "${local.requests_path}/${coalesce(local.update_request_id, local.missing_request_id)}"
  api_version = local.api_version

  response_export_values = {
    state  = "state"
    status = "status"
  }

  depends_on = [time_sleep.wait_for_update]
}

resource "terraform_data" "update_gate" {
  count = var.schedule_update != null ? 1 : 0

  input = local.update_request_phase

  lifecycle {
    precondition {
      condition     = !contains(local.failed_phases, coalesce(local.update_request_phase, "unknown"))
      error_message = "The adminUpdate request ${coalesce(local.update_request_id, "none")} ended as ${local.update_request_state_text}; the schedule was not changed."
    }

    precondition {
      condition     = !var.require_delivery || coalesce(local.update_request_phase, "unknown") == "delivered"
      error_message = "The adminUpdate request ${coalesce(local.update_request_id, "none")} is ${coalesce(local.update_request_phase, "unknown")} (state '${local.update_request_state_text}'), not delivered. This module never approves a request: apply again after the approval, or set require_delivery = false to track it."
    }
  }

  depends_on = [data.msgraph_resource.update_request]
}

# Removal on destroy. The request object cannot be deleted, so this hook cancels a
# request that still waits, or submits adminRemove for the delivered assignment,
# with the ambient Azure CLI session. Before requesting a token it requires
# ARM_TENANT_ID (the tenant variable the msgraph provider reads) to match
# `az account show`, so nothing can go to another tenant. curl reads the
# Authorization header from a config on stdin, so the token never appears in a
# process argv. Values are passed as environment variables, never interpolated
# into shell code.
#
# It removes only an assignment this module created or explicitly adopted. A request
# that is waiting (submitted, pendingApproval or scheduled, with a status v1.0 lists
# as cancelable) is canceled. A request that is delivering stops the destroy. A
# denied or canceled one needs nothing. A request that failed, was partially
# delivered, no longer exists or reports an unknown state is NOT tied to any
# assignment, so the hook refuses and prints the evidence instead of removing
# whichever assignment happens to match. Only a delivered request leads on: the
# assignment is then taken from a listing of the exact subject, policy and package
# (or from the adopted ID), parsed strictly from the top-level value array, and
# only when exactly one non-expired assignment matches. Before any adminRemove the
# hook reads that assignment itself, expanded, and requires its subject, policy and
# package to equal the module's inputs; a wrong adopted ID is never revoked. The hook
# then polls until the assignment reports expired or is gone, and fails when it
# does not, so a revoked grant is confirmed, not assumed. Every stop prints the
# non-secret ownership evidence (subject, package, policy, request) and keeps the
# hook in state, so a later destroy retries. Learn documents no error code for an
# assignment that is already gone; 404 and the words "not found" and "does not
# exist" count as removed. 409, 429 and 5xx answers are retried for about two minutes.
#
# The hook can only revoke the assignment of the identity captured when the
# resource was created; deleting the module block from the configuration does not
# run it. Run a targeted destroy of the module while its block is still present.
# Keep `triggers` complete: a change to any identity input replaces this resource,
# which revokes the old assignment before the new one is requested.
resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0

  triggers = {
    target_id             = var.target_id
    access_package_id     = var.access_package_id
    assignment_policy_id  = var.assignment_policy_id
    adopted_assignment_id = var.adopt_assignment_id != null ? var.adopt_assignment_id : ""
    revoke                = tostring(local.revoke_on_destroy)
    replacement_token     = var.replacement_token != null ? var.replacement_token : ""
    request_id            = local.request_id != null ? local.request_id : ""
    api_version           = local.api_version
  }

  # Record the hook after the request was accepted, before any fallible read-back.
  # Do not register removal for a request that Graph rejected.
  depends_on = [msgraph_resource_action.add]

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["bash", "-c"]
    environment = {
      GRAPH_TARGET_ID          = self.triggers.target_id
      GRAPH_ACCESS_PACKAGE_ID  = self.triggers.access_package_id
      GRAPH_POLICY_ID          = self.triggers.assignment_policy_id
      GRAPH_ADOPTED_ASSIGNMENT = self.triggers.adopted_assignment_id
      GRAPH_REVOKE             = self.triggers.revoke
      GRAPH_REQUEST_ID         = self.triggers.request_id
      GRAPH_API_VERSION        = self.triggers.api_version
    }
    command = <<-EOT
      set -euo pipefail
      set +ax
      test -n "$GRAPH_TARGET_ID" && test -n "$GRAPH_ACCESS_PACKAGE_ID" && test -n "$GRAPH_POLICY_ID" || { echo "ERROR: the subject, access package or policy was not captured; revoke the assignment in Entitlement Management before destroying." >&2; exit 1; }
      if test "$GRAPH_REVOKE" != true; then
        echo "The assignment $GRAPH_ADOPTED_ASSIGNMENT for subject $GRAPH_TARGET_ID was adopted, not granted by this module, and revoke_adopted_assignment_on_destroy is false; leaving it in place."
        exit 0
      fi
      expected_tenant=$(printf '%s' "$${ARM_TENANT_ID:-}" | tr '[:upper:]' '[:lower:]')
      test -n "$expected_tenant" || { echo "ERROR: ARM_TENANT_ID is not set. Set it to the tenant ID the msgraph provider uses; destroy cleanup refuses to guess the tenant." >&2; exit 1; }
      cli_tenant=$(az account show --query tenantId -o tsv | tr '[:upper:]' '[:lower:]')
      test "$cli_tenant" = "$expected_tenant" || { echo "ERROR: the Azure CLI tenant ($cli_tenant) does not match ARM_TENANT_ID ($expected_tenant). Run 'az login --tenant $expected_tenant' or correct ARM_TENANT_ID, then retry destroy." >&2; exit 1; }
      unset TOKEN
      TOKEN=$(az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv)
      case "$TOKEN" in "" | *[!A-Za-z0-9._~+/=-]*) echo "ERROR: the Azure CLI returned no usable Microsoft Graph access token." >&2; exit 1 ;; esac
      base="https://graph.microsoft.com/$GRAPH_API_VERSION/identityGovernance/entitlementManagement"
      evidence="subject $GRAPH_TARGET_ID, access package $GRAPH_ACCESS_PACKAGE_ID, assignment policy $GRAPH_POLICY_ID, request $${GRAPH_REQUEST_ID:-none}"
      fail() {
        echo "ERROR: $1" >&2
        echo "Ownership evidence for recovery (no secrets): $evidence. Resolve it in Entitlement Management, then retry destroy." >&2
        exit 1
      }
      clean() { printf '%s' "$${1:0:2000}" | tr -c '[:print:]' ' '; }
      lower() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]'; }
      # Flattens a JSON document into "path<TAB>value" lines for its string values. Paths join object keys
      # and array indexes with dots (value.0.id), so a nested id (value.0.customExtensionCalloutInstances.0.id)
      # can never be mistaken for a top-level one. Strings are tracked, so braces inside them are inert.
      flatten() {
        awk '
          { buf = buf $0 "\n" }
          END {
            n = length(buf); depth = 0; instr = 0; esc = 0; after = 0
            for (i = 1; i <= n; i++) {
              c = substr(buf, i, 1)
              if (instr) {
                if (esc) { tok = tok c; esc = 0 }
                else if (c == "\\") { tok = tok c; esc = 1 }
                else if (c == "\"") {
                  instr = 0
                  if (kind[depth] == "a" || after) {
                    path = cur[1]
                    for (j = 2; j <= depth; j++) path = path "." cur[j]
                    print path "\t" tok
                    after = 0
                  } else cur[depth] = tok
                } else tok = tok c
                continue
              }
              if (c == "\"") { instr = 1; tok = ""; continue }
              if (c == "{" || c == "[") {
                depth++; kind[depth] = (c == "{") ? "o" : "a"; cur[depth] = (c == "[") ? 0 : ""; after = 0
                if (c == "[" && depth >= 2) {
                  path = cur[1]
                  for (j = 2; j < depth; j++) path = path "." cur[j]
                  print path "\t<array>"
                }
                continue
              }
              if (c == "}" || c == "]") { depth--; after = 0; continue }
              if (c == ":") { after = 1; continue }
              if (c == ",") { after = 0; if (kind[depth] == "a") cur[depth]++; continue }
            }
            print "@complete\t" ((depth == 0 && !instr) ? "yes" : "no")
          }'
      }
      field() { printf '%s\n' "$1" | awk -F'\t' -v p="$2" '$1 == p { print $2; exit }'; }
      guid='^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
      call() {
        method=$1
        url=$2
        shift 2
        response=$(printf 'header = "Authorization: Bearer %s"\n' "$TOKEN" | curl --config - --silent --show-error --connect-timeout 30 --max-time 120 \
          -w '\n%%{http_code}' -X "$method" "$url" "$@")
        status=$${response##*$'\n'}
        body=$${response%$'\n'*}
      }
      if test -n "$GRAPH_REQUEST_ID"; then
        call GET "$base/assignmentRequests/$GRAPH_REQUEST_ID"
        case "$status" in
          2??) fields=$(printf '%s' "$body" | flatten); request_state=$(field "$fields" state); request_status=$(field "$fields" status) ;;
          404) fail "The request $GRAPH_REQUEST_ID no longer exists, so the assignment cannot be tied to this module. Refusing to remove an assignment by guesswork." ;;
          *) fail "Graph answered HTTP $status when reading the request: $(clean "$body")" ;;
        esac
        case "$request_state" in
          submitted | pendingApproval | scheduled)
            case "$request_status" in
              accepted | pendingApproval | pendingNotBefore | pendingApprovalEscalated)
                call POST "$base/assignmentRequests/$GRAPH_REQUEST_ID/cancel" -H "Content-Type: application/json"
                case "$status" in
                  2??) echo "Canceled request $GRAPH_REQUEST_ID, which was $request_state ($request_status), for subject $GRAPH_TARGET_ID; no assignment was delivered."; exit 0 ;;
                esac
                fail "Graph answered HTTP $status to the cancel of request $GRAPH_REQUEST_ID ($request_state): $(clean "$body")"
                ;;
            esac
            fail "The request $GRAPH_REQUEST_ID is $request_state with status '$request_status', which v1.0 does not list as cancelable. Retry destroy after it settles."
            ;;
          delivering)
            fail "The request $GRAPH_REQUEST_ID is still delivering and can be neither canceled nor removed yet. Retry destroy after it settles."
            ;;
          denied | canceled)
            echo "The request $GRAPH_REQUEST_ID ended as $request_state; no assignment was delivered, nothing to remove."
            exit 0
            ;;
          delivered) ;;
          *)
            fail "The request $GRAPH_REQUEST_ID ended as '$request_state'. Only a delivered request of this module ties an assignment to it, so nothing is removed; check what was delivered in Entitlement Management and revoke it by hand."
            ;;
        esac
      fi
      if test -n "$GRAPH_ADOPTED_ASSIGNMENT"; then
        assignment_id=$GRAPH_ADOPTED_ASSIGNMENT
      else
        filter="accessPackage/id eq '$GRAPH_ACCESS_PACKAGE_ID' and target/objectId eq '$GRAPH_TARGET_ID' and assignmentPolicy/id eq '$GRAPH_POLICY_ID'"
        # A delivered request is listed once its assignment exists, and the listing is eventually
        # consistent, so an empty listing right after delivery proves nothing: wait and list again,
        # then refuse. An expired assignment is still listed, so a removed one never looks empty.
        listings=6
        listing_attempt=1
        while :; do
          call GET "$base/assignments" -G --data-urlencode '$filter='"$filter" --data-urlencode '$select=id,state'
          case "$status" in 2??) ;; *) fail "Graph answered HTTP $status when listing the assignments: $(clean "$body")" ;; esac
          fields=$(printf '%s' "$body" | flatten)
          # Only positive evidence of a complete listing counts: an empty value array is the one
          # way to "nothing to remove". Unparseable, truncated or paged answers are refused.
          test "$(field "$fields" @complete)" = yes && test "$(field "$fields" value)" = "<array>" \
            || fail "The assignments listing is not complete JSON with a value array; refusing to read it as empty: $(clean "$body")"
          test -z "$(field "$fields" @odata.nextLink)" \
            || fail "The assignments listing is paged (@odata.nextLink present); refusing to guess from its first page."
          listed_total=$(printf '%s\n' "$fields" | awk -F'\t' '$1 ~ /^value\.[0-9]+\.id$/' | grep -c . || true)
          if test "$listed_total" != 0 || test -z "$GRAPH_REQUEST_ID"; then break; fi
          test "$listing_attempt" -lt "$listings" || fail "Request $GRAPH_REQUEST_ID was delivered, but its assignment is still not listed after $listings attempts. It may appear later, so removing this resource now could leave the access in place. Check Entitlement Management and revoke any assignment for this subject. If the assignment is long gone and never lists again, retrying fails the same way: once you have verified that nothing is left, run terraform state rm on this module's null_resource.remove_on_destroy[0] (see the README, A destroy that stays blocked) and destroy again."
          echo "Request $GRAPH_REQUEST_ID was delivered but no assignment is listed yet (attempt $listing_attempt of $listings); listing again." >&2
          listing_attempt=$((listing_attempt + 1))
          sleep 20
        done
        ids=""
        for path in $(printf '%s\n' "$fields" | awk -F'\t' '$1 ~ /^value\.[0-9]+\.id$/ { print $1 }'); do
          index=$${path#value.}
          index=$${index%.id}
          if test "$(field "$fields" "value.$index.state")" != expired; then
            listed=$(field "$fields" "$path")
            printf '%s' "$listed" | grep -Eq "$guid" || fail "A listed assignment id ('$(clean "$listed")') is not a GUID; refusing to use it in a request."
            ids="$ids$listed"$'\n'
          fi
        done
        count=$(printf '%s' "$ids" | grep -c . || true)
        if test "$count" = 0; then
          echo "No live assignment exists for $evidence; nothing to remove."
          exit 0
        fi
        test "$count" = 1 || fail "$count live assignments match; refusing to guess which one this module owns: $(printf '%s' "$ids" | tr '\n' ' ')"
        assignment_id=$(printf '%s' "$ids" | head -n 1)
      fi
      printf '%s' "$assignment_id" | grep -Eq "$guid" || fail "The assignment id '$(clean "$assignment_id")' is not a GUID; refusing to use it in a request."
      # Never trust the listing filter or a pasted ID alone: read the assignment itself and require the
      # subject, the policy and the package to equal this module's inputs before anything is removed.
      call GET "$base/assignments/$assignment_id" -G --data-urlencode '$expand=target,assignmentPolicy,accessPackage'
      case "$status" in
        2??) ;;
        404) echo "The assignment $assignment_id no longer exists; nothing to remove."; exit 0 ;;
        *) fail "Graph answered HTTP $status when reading assignment $assignment_id: $(clean "$body")" ;;
      esac
      fields=$(printf '%s' "$body" | flatten)
      found_target=$(lower "$(field "$fields" target.objectId)")
      found_policy=$(lower "$(field "$fields" assignmentPolicy.id)")
      found_package=$(lower "$(field "$fields" accessPackage.id)")
      test "$found_target" = "$(lower "$GRAPH_TARGET_ID")" && test "$found_policy" = "$(lower "$GRAPH_POLICY_ID")" && test "$found_package" = "$(lower "$GRAPH_ACCESS_PACKAGE_ID")" \
        || fail "The assignment $assignment_id belongs to subject '$found_target', policy '$found_policy' and package '$found_package', not to this module's subject, policy and package. It is not removed."
      if test "$(field "$fields" state)" = expired; then
        echo "The assignment $assignment_id has already expired; nothing to remove."
        exit 0
      fi
      remove_body=$(printf '{"requestType":"adminRemove","assignment":{"id":"%s"}}' "$assignment_id")
      attempts=6
      attempt=1
      absent=0
      while :; do
        call POST "$base/assignmentRequests" -H "Content-Type: application/json" --data "$remove_body"
        case "$status" in 2??) break ;; esac
        echo "Graph answered HTTP $status to adminRemove for assignment $assignment_id (attempt $attempt of $attempts): $(clean "$body")" >&2
        lowered=$(lower "$body")
        case "$status:$lowered" in
          404:* | 400:*doesnotexist* | 400:*"does not exist"* | 400:*notfound* | 400:*"not found"*) absent=1; break ;;
        esac
        case "$status" in 409 | 429 | 5??) ;; *) fail "adminRemove for assignment $assignment_id was refused with HTTP $status." ;; esac
        test "$attempt" -lt "$attempts" || fail "adminRemove for assignment $assignment_id still fails after $attempts attempts."
        attempt=$((attempt + 1))
        sleep 20
      done
      if test "$absent" = 1; then
        echo "The assignment $assignment_id no longer exists; nothing to remove."
        exit 0
      fi
      checks=10
      check=1
      confirmed=0
      assignment_state=unknown
      while :; do
        call GET "$base/assignments/$assignment_id"
        case "$status" in
          404) confirmed=1; break ;;
          2??)
            assignment_state=$(field "$(printf '%s' "$body" | flatten)" state)
            if test "$assignment_state" = expired; then confirmed=1; break; fi
            ;;
        esac
        test "$check" -lt "$checks" || break
        check=$((check + 1))
        sleep 15
      done
      test "$confirmed" = 1 || fail "adminRemove for assignment $assignment_id was accepted, but the assignment still reports state '$assignment_state' after $checks checks. Do not assume the access is gone."
      echo "Revoked assignment $assignment_id: $evidence. Graph confirms it is no longer live; effective access to the package's resources can lag, so verify the resources if it matters."
    EOT
  }
}
