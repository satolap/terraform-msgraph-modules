locals {
  is_eligible = var.assignment_type == "eligible"

  # The two assignment kinds share one request shape and differ only in the
  # collection that receives it and the schedule collection that shows the result.
  requests_path  = local.is_eligible ? "roleManagement/directory/roleEligibilityScheduleRequests" : "roleManagement/directory/roleAssignmentScheduleRequests"
  schedules_path = local.is_eligible ? "roleManagement/directory/roleEligibilitySchedules" : "roleManagement/directory/roleAssignmentSchedules"

  by_display_name = var.role_display_name != null

  # null renders as an empty string in messages and filters.
  role_display_name_text = var.role_display_name != null ? var.role_display_name : ""
}

# Resolves role_display_name to a role definition ID. Read-only.
data "msgraph_resource" "role" {
  count = local.by_display_name ? 1 : 0

  url         = "roleManagement/directory/roleDefinitions"
  api_version = var.api_version

  query_parameters = {
    "$filter" = ["displayName eq '${replace(local.role_display_name_text, "'", "''")}'"]
  }

  response_export_values = {
    roles = "value"
  }
}

locals {
  matched_roles      = local.by_display_name ? try(data.msgraph_resource.role[0].output.roles, []) : []
  role_definition_id = local.by_display_name ? try(local.matched_roles[0].id, null) : var.role_definition_id

  role_definition_id_text = local.role_definition_id != null ? local.role_definition_id : ""

  expiration = merge(
    { type = var.expiration_type },
    var.expiration_type == "afterDateTime" ? { endDateTime = var.end_date_time } : {},
    var.expiration_type == "afterDuration" ? { duration = var.duration } : {},
  )

  assign_body = {
    action           = "adminAssign"
    principalId      = var.principal_id
    roleDefinitionId = local.role_definition_id
    directoryScopeId = var.directory_scope_id
    justification    = var.justification
    scheduleInfo = merge(
      var.start_date_time != null ? { startDateTime = var.start_date_time } : {},
      { expiration = local.expiration },
    )
  }
}

# Submits the adminAssign request via the PIM schedule request API. A schedule
# request supports neither PATCH nor DELETE, so managing it as a CRUD resource
# would make the destroy fail on DELETE. msgraph_resource_action posts once at
# create and is forgotten on destroy; the assignment is removed by
# null_resource.remove_on_destroy below, with an adminRemove request.
#
# PIM role settings (the rules of the role's management policy, such as a
# maximum eligibility duration, required justification or a ban on permanent
# assignments) can reject the request. Graph's error is surfaced unchanged.
resource "msgraph_resource_action" "assign" {
  resource_url = local.requests_path
  method       = "POST"
  api_version  = var.api_version
  body         = local.assign_body

  response_export_values = {
    request_id = "id"
    status     = "status"
  }

  # A principal, role and scope can hold one assignment of a kind, so adminAssign
  # of an existing one fails. Any input change therefore removes the old
  # assignment first (destroy hook, then this action) and assigns again.
  # Never add create_before_destroy: the new adminAssign would fail, and the
  # destroy-time adminRemove would then remove the new assignment.
  lifecycle {
    replace_triggered_by = [terraform_data.assignment]

    precondition {
      condition     = (var.role_definition_id != null) != (var.role_display_name != null)
      error_message = "Set exactly one of role_definition_id and role_display_name."
    }

    precondition {
      condition     = !local.by_display_name || length(local.matched_roles) == 1
      error_message = "role_display_name '${local.role_display_name_text}' matched ${length(local.matched_roles)} role definitions; it must match exactly one. Use role_definition_id to name the role."
    }

    precondition {
      condition     = (var.expiration_type == "afterDateTime") == (var.end_date_time != null)
      error_message = "end_date_time is required when expiration_type is \"afterDateTime\" and refused otherwise."
    }

    precondition {
      condition     = (var.expiration_type == "afterDuration") == (var.duration != null)
      error_message = "duration is required when expiration_type is \"afterDuration\" and refused otherwise."
    }
  }
}

# Every input that shapes the request. A change replaces the action and the
# sleep, and (through the hook's request trigger) the destroy hook, so the old
# assignment is removed before the new one is requested.
resource "terraform_data" "assignment" {
  input = {
    assignment_type    = var.assignment_type
    principal_id       = var.principal_id
    role_definition_id = local.role_definition_id
    directory_scope_id = var.directory_scope_id
    justification      = var.justification
    start_date_time    = var.start_date_time
    expiration_type    = var.expiration_type
    end_date_time      = var.end_date_time
    duration           = var.duration
    api_version        = var.api_version
  }
}

# PIM provisions the schedule asynchronously; wait before reading it back. A new
# request waits again (and reads at apply time rather than plan time).
resource "time_sleep" "wait_for_delivery" {
  depends_on      = [msgraph_resource_action.assign, null_resource.remove_on_destroy]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.assignment]
  }
}

# Reads the schedule back. principalId, roleDefinitionId and directoryScopeId
# all support $filter (eq) on both schedule collections; the match below
# re-checks them case-insensitively and leaves out schedules that this module
# did not create: an eligibility activated by the principal (assignmentType
# "Activated") and a schedule inherited through a group (memberType).
data "msgraph_resource" "verify" {
  url         = local.schedules_path
  api_version = var.api_version

  query_parameters = {
    "$filter" = ["principalId eq '${replace(var.principal_id, "'", "''")}' and roleDefinitionId eq '${replace(local.role_definition_id_text, "'", "''")}' and directoryScopeId eq '${replace(var.directory_scope_id, "'", "''")}'"]
  }

  response_export_values = {
    schedules = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

locals {
  matched_schedules = [
    for s in try(data.msgraph_resource.verify.output.schedules, []) : s
    if lower(try(s.principalId, "")) == lower(var.principal_id)
    && lower(try(s.roleDefinitionId, "")) == lower(local.role_definition_id_text)
    && lower(try(s.directoryScopeId, "")) == lower(var.directory_scope_id)
    && try(s.memberType, "Direct") == "Direct"
    && try(s.assignmentType, "Assigned") == "Assigned"
  ]
  matched_schedule_id = length(local.matched_schedules) == 1 ? try(local.matched_schedules[0].id, null) : null
  verified            = length(local.matched_schedules) == 1

  # A schedule that starts later may not be listed yet; do not fail on it. The
  # timestamp is read only by the gate's precondition and is never stored.
  starts_later = var.start_date_time != null && timecmp(timestamp(), coalesce(var.start_date_time, "1970-01-01T00:00:00Z")) < 0
}

# Hard-fails apply when fail_on_verification_mismatch is true and no schedule
# was found, unless the assignment starts in the future.
resource "terraform_data" "verification_gate" {
  input = local.verified

  lifecycle {
    precondition {
      condition     = local.verified || !var.fail_on_verification_mismatch || local.starts_later
      error_message = "Found ${length(local.matched_schedules)} ${var.assignment_type} schedules for principal '${var.principal_id}', role '${local.role_definition_id_text}' and scope '${var.directory_scope_id}' after ${var.verification_delay_seconds}s (request status: ${coalesce(try(msgraph_resource_action.assign.output.status, null), "unknown")}); expected exactly one. The request may still be provisioning or awaiting approval; increase verification_delay_seconds and re-apply, or set fail_on_verification_mismatch = false."
    }
  }

  depends_on = [data.msgraph_resource.verify]
}

# Removal on destroy: a schedule request cannot be deleted, only countered by an
# adminRemove request. This uses the ambient Azure CLI session to submit it when
# the assignment is destroyed. Before requesting a token it requires
# ARM_TENANT_ID (the tenant variable the msgraph provider reads) to match
# `az account show`, so the request cannot go to another tenant. curl reads the
# Authorization header from a config on stdin, so the token never appears in a
# process argv. Values are passed as environment variables, never interpolated
# into shell code.
# An assignment that has expired or was removed already makes Graph answer that
# it does not exist (HTTP 404, or HTTP 400 with a DoesNotExist or NotFound
# error); that counts as removed. Learn documents no error code for this, so the
# match is on the words. 409, 429 and 5xx answers are retried for about two
# minutes; other refusals, such as a role setting that blocks the removal, stop
# the destroy. Each refusal prints Graph's error body, with control characters
# removed.
# Keep `triggers` complete: a change to any request input replaces this resource,
# which removes the old assignment before the new one is requested.
resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0

  triggers = {
    assignment_type    = var.assignment_type
    principal_id       = var.principal_id
    role_definition_id = local.role_definition_id != null ? local.role_definition_id : ""
    directory_scope_id = var.directory_scope_id
    api_version        = var.api_version
    request            = sha256(jsonencode(local.assign_body))
  }

  # Record the hook after a confirmed assignment, before any fallible read-back.
  # Do not register removal for a request that Graph rejected.
  depends_on = [msgraph_resource_action.assign]

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["bash", "-c"]
    environment = {
      GRAPH_PRINCIPAL_ID        = self.triggers.principal_id
      GRAPH_ROLE_DEFINITION_ID  = self.triggers.role_definition_id
      GRAPH_DIRECTORY_SCOPE_ID  = self.triggers.directory_scope_id
      GRAPH_API_VERSION         = self.triggers.api_version
      GRAPH_REQUESTS_COLLECTION = self.triggers.assignment_type == "eligible" ? "roleEligibilityScheduleRequests" : "roleAssignmentScheduleRequests"
      GRAPH_REMOVE_BODY = jsonencode({
        action           = "adminRemove"
        principalId      = self.triggers.principal_id
        roleDefinitionId = self.triggers.role_definition_id
        directoryScopeId = self.triggers.directory_scope_id
      })
    }
    command = <<-EOT
      set -euo pipefail
      set +ax
      test -n "$GRAPH_PRINCIPAL_ID" && test -n "$GRAPH_ROLE_DEFINITION_ID" && test -n "$GRAPH_DIRECTORY_SCOPE_ID" || { echo "ERROR: the principal, role definition or scope was not captured; remove the assignment in PIM before destroying." >&2; exit 1; }
      expected_tenant=$(printf '%s' "$${ARM_TENANT_ID:-}" | tr '[:upper:]' '[:lower:]')
      test -n "$expected_tenant" || { echo "ERROR: ARM_TENANT_ID is not set. Set it to the tenant ID the msgraph provider uses; destroy cleanup refuses to guess the tenant." >&2; exit 1; }
      cli_tenant=$(az account show --query tenantId -o tsv | tr '[:upper:]' '[:lower:]')
      test "$cli_tenant" = "$expected_tenant" || { echo "ERROR: the Azure CLI tenant ($cli_tenant) does not match ARM_TENANT_ID ($expected_tenant). Run 'az login --tenant $expected_tenant' or correct ARM_TENANT_ID, then retry destroy." >&2; exit 1; }
      unset TOKEN
      TOKEN=$(az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv)
      case "$TOKEN" in "" | *[!A-Za-z0-9._~+/=-]*) echo "ERROR: the Azure CLI returned no usable Microsoft Graph access token." >&2; exit 1 ;; esac
      attempts=6
      attempt=1
      absent=0
      while :; do
        response=$(printf 'header = "Authorization: Bearer %s"\n' "$TOKEN" | curl --config - --silent --show-error --connect-timeout 30 --max-time 120 \
          -w '\n%%{http_code}' \
          -X POST "https://graph.microsoft.com/$GRAPH_API_VERSION/roleManagement/directory/$GRAPH_REQUESTS_COLLECTION" \
          -H "Content-Type: application/json" \
          --data "$GRAPH_REMOVE_BODY")
        status=$${response##*$'\n'}
        case "$status" in 2??) break ;; esac
        body=$${response%$'\n'*}
        body=$(printf '%s' "$${body:0:2000}" | tr -c '[:print:]' ' ')
        echo "Graph answered HTTP $status to adminRemove for principal $GRAPH_PRINCIPAL_ID, role $GRAPH_ROLE_DEFINITION_ID, scope $GRAPH_DIRECTORY_SCOPE_ID (attempt $attempt of $attempts): $body" >&2
        lowered=$(printf '%s' "$body" | tr '[:upper:]' '[:lower:]')
        case "$status:$lowered" in
          404:* | 400:*doesnotexist* | 400:*"does not exist"* | 400:*notfound* | 400:*"not found"*) absent=1; break ;;
        esac
        case "$status" in 409 | 429 | 5??) ;; *) exit 1 ;; esac
        test "$attempt" -lt "$attempts" || { echo "ERROR: adminRemove still fails after $attempts attempts. Remove the assignment in PIM, then retry destroy." >&2; exit 1; }
        attempt=$((attempt + 1))
        sleep 20
      done
      if test "$absent" = 1; then
        echo "The assignment of role $GRAPH_ROLE_DEFINITION_ID to $GRAPH_PRINCIPAL_ID at $GRAPH_DIRECTORY_SCOPE_ID no longer exists; nothing to remove."
      else
        echo "Submitted adminRemove for principal $GRAPH_PRINCIPAL_ID, role $GRAPH_ROLE_DEFINITION_ID, scope $GRAPH_DIRECTORY_SCOPE_ID. Verify removal in Privileged Identity Management."
      fi
    EOT
  }
}
