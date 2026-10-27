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
# msgraph_resource_action.remove below, with an adminRemove request.
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
    ignore_changes       = all
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
  depends_on      = [msgraph_resource_action.assign, msgraph_resource_action.remove]
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

# Verify the exact created request, not a possibly absent future schedule or
# another schedule found by tuple. Only completed creation permits registration.
data "msgraph_resource" "verify_request" {
  count = var.enable_destroy_cleanup ? 1 : 0

  url                    = "${msgraph_resource_action.assign.resource_url}/${coalesce(try(msgraph_resource_action.assign.output.request_id, null), "missing-created-request-id")}"
  api_version            = var.api_version
  response_export_values = { request = "@" }
  retry = {
    error_message_regex = ["(?i)\"error\"\\s*:\\s*\\{[^}]*\"code\"\\s*:\\s*\"(404|NotFound|Request_ResourceNotFound)\"", "(?i)^(HTTP|status|statuscode)\\s*[:=]?\\s*404\\b"]
  }
  timeouts {
    read = "2m"
  }

  lifecycle {
    precondition {
      condition = alltrue([
        can(regex("^[A-Za-z0-9_-]{1,512}$", try(msgraph_resource_action.assign.output.request_id, ""))),
        var.api_version == null ? false : contains(["v1.0", "beta"], var.api_version),
      ])
      error_message = "Refusing request verification: a safe captured request ID and API version are required."
    }
    postcondition {
      condition = try(alltrue([
        self.output.request.id == msgraph_resource_action.assign.output.request_id,
        self.output.request.action == "adminAssign",
        lower(self.output.request.principalId) == lower(msgraph_resource_action.assign.body.principalId),
        lower(self.output.request.roleDefinitionId) == lower(msgraph_resource_action.assign.body.roleDefinitionId),
        lower(self.output.request.directoryScopeId) == lower(msgraph_resource_action.assign.body.directoryScopeId),
        try(self.output.request.appScopeId, null) == null,
        self.output.request.isValidationOnly == false,
        self.output.request.status == null ? false : contains(["Provisioned", "ScheduleCreated", "Granted"], self.output.request.status),
      ]), false)
      error_message = "Independent GET must verify the created adminAssign request, identity and completed status before removal registration. Preserve the request and retry unchanged apply; never replay POST or destroy to recover verification."
    }
  }
}

# Keep legacy triggers and address without the shell provisioner. Register the
# counter-request before the later schedule read/gate can fail.
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

  depends_on = [data.msgraph_resource.verify_request]

  lifecycle {
    replace_triggered_by = [msgraph_resource_action.assign]
  }
}

resource "msgraph_resource_action" "remove" {
  count = var.enable_destroy_cleanup ? 1 : 0

  resource_url = null_resource.remove_on_destroy[0].triggers.assignment_type == "eligible" ? "roleManagement/directory/roleEligibilityScheduleRequests" : "roleManagement/directory/roleAssignmentScheduleRequests"
  api_version  = null_resource.remove_on_destroy[0].triggers.api_version
  method       = "POST"
  when         = "destroy"
  body = {
    action           = "adminRemove"
    principalId      = null_resource.remove_on_destroy[0].triggers.principal_id
    roleDefinitionId = null_resource.remove_on_destroy[0].triggers.role_definition_id
    directoryScopeId = null_resource.remove_on_destroy[0].triggers.directory_scope_id
  }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [null_resource.remove_on_destroy]

    precondition {
      condition = alltrue([
        can(regex("(?i)^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", null_resource.remove_on_destroy[0].triggers.principal_id)),
        can(regex("(?i)^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", null_resource.remove_on_destroy[0].triggers.role_definition_id)),
        can(regex("(?i)^/((administrativeUnits/)?[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12})?$", null_resource.remove_on_destroy[0].triggers.directory_scope_id)),
        null_resource.remove_on_destroy[0].triggers.assignment_type == null ? false : contains(["eligible", "active"], null_resource.remove_on_destroy[0].triggers.assignment_type),
        null_resource.remove_on_destroy[0].triggers.api_version == null ? false : contains(["v1.0", "beta"], null_resource.remove_on_destroy[0].triggers.api_version),
        null_resource.remove_on_destroy[0].triggers.principal_id == msgraph_resource_action.assign.body.principalId,
        null_resource.remove_on_destroy[0].triggers.role_definition_id == msgraph_resource_action.assign.body.roleDefinitionId,
        null_resource.remove_on_destroy[0].triggers.directory_scope_id == msgraph_resource_action.assign.body.directoryScopeId,
      ])
      error_message = "Refusing removal registration: saved type, API and assignment identity must be safe and match the independently verified request."
    }
  }
}
