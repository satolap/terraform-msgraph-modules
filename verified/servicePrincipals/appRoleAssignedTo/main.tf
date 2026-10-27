data "msgraph_resource" "resource" {
  count = var.appRoleValue != null ? 1 : (local.explicit_default_role ? 1 : 0)

  url         = "servicePrincipals/${lower(var.resourceId)}"
  api_version = "v1.0"

  query_parameters = {
    "$select" = ["id,appRoles"]
  }

  response_export_values = {
    resource = "@"
  }
}

locals {
  explicit_default_role = var.appRoleId == null ? false : lower(var.appRoleId) == "00000000-0000-0000-0000-000000000000"

  # Read the role definitions, never assignments, and never write the service principal.
  # Count every exact value match before checking enablement so duplicates fail closed.
  matched_roles = var.appRoleValue == null ? [] : try([
    for role in data.msgraph_resource.resource[0].output.resource.appRoles : role
    if try(role.value == var.appRoleValue, false)
  ], [])
  app_role_id = var.appRoleId != null ? lower(var.appRoleId) : try(lower(local.matched_roles[0].id), null)
  body = {
    resourceId  = lower(var.resourceId)
    principalId = lower(var.principalId)
    appRoleId   = local.app_role_id
  }
}

# No PATCH is documented. Replace destroy-first for every identity or selector change;
# GUID letter case alone is not an identity change (GB-directory-objects-501).
resource "terraform_data" "immutable" {
  input = {
    resourceId   = lower(var.resourceId)
    principalId  = lower(var.principalId)
    appRoleId    = local.app_role_id
    appRoleValue = var.appRoleValue
  }
}

resource "msgraph_resource_action" "assignment" {
  resource_url = "servicePrincipals/${lower(var.resourceId)}/appRoleAssignedTo"
  api_version  = "v1.0"
  body         = local.body

  method = "POST"
  response_export_values = {
    assignment = "@"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]
    ignore_changes       = all

    precondition {
      condition     = (var.appRoleId == null) != (var.appRoleValue == null)
      error_message = "Set exactly one of appRoleId or appRoleValue. The default role requires an explicit all-zero appRoleId."
    }

    precondition {
      condition = var.appRoleValue == null ? true : alltrue([
        length(local.matched_roles) == 1,
        try(lower(data.msgraph_resource.resource[0].output.resource.id) == lower(var.resourceId), false),
        try(local.matched_roles[0].isEnabled == true, false),
        can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", local.app_role_id)),
      ])
      error_message = "appRoleValue must match exactly one enabled role with a GUID on the requested resource service principal. Missing, ambiguous or malformed lookup results are refused."
    }

    precondition {
      condition = local.app_role_id == "00000000-0000-0000-0000-000000000000" ? try(alltrue([
        lower(data.msgraph_resource.resource[0].output.resource.id) == lower(var.resourceId),
        jsonencode(data.msgraph_resource.resource[0].output.resource.appRoles) == jsonencode([]),
      ]), false) : true
      error_message = "The all-zero default appRoleId requires a read of the requested resource service principal proving appRoles is an empty collection. Declared roles or missing identity/role evidence are refused."
    }

    postcondition {
      condition = try(alltrue([
        can(regex("^[A-Za-z0-9_-]{1,256}$", self.output.assignment.id)),
        lower(self.output.assignment.resourceId) == local.body.resourceId,
        lower(self.output.assignment.principalId) == local.body.principalId,
        lower(self.output.assignment.appRoleId) == local.body.appRoleId,
      ]), false)
      error_message = "Graph did not return this assignment's ID, resourceId, principalId and appRoleId. Refusing to adopt a different assignment or incomplete identity."
    }
  }

  # The POST action is forgotten on destroy; removal is registered below only
  # after an independent GET proves the created identity.
}

# Independently read the exact created item before recording ownership or
# registering deletion. Missing or mismatched identity fails closed.
data "msgraph_resource" "verify" {
  url                    = "${msgraph_resource_action.assignment.resource_url}/${msgraph_resource_action.assignment.output.assignment.id}"
  api_version            = "v1.0"
  response_export_values = { assignment = "@" }

  # A just-created item may not be visible on the read replica yet. Retry only
  # this GET, never POST or DELETE; the explicit timeout bounds replication wait.
  retry = {
    error_message_regex = ["(?i)\"error\"\\s*:\\s*\\{[^}]*\"code\"\\s*:\\s*\"(404|NotFound|Request_ResourceNotFound)\"", "(?i)^(HTTP|status|statuscode)\\s*[:=]?\\s*404\\b"]
  }
  timeouts {
    read = "2m"
  }

  lifecycle {
    postcondition {
      condition = try(alltrue([
        self.output.assignment.id == msgraph_resource_action.assignment.output.assignment.id,
        lower(self.output.assignment.resourceId) == lower(msgraph_resource_action.assignment.output.assignment.resourceId),
        lower(self.output.assignment.principalId) == lower(msgraph_resource_action.assignment.output.assignment.principalId),
        lower(self.output.assignment.appRoleId) == lower(msgraph_resource_action.assignment.output.assignment.appRoleId),
      ]), false)
      error_message = "The independent GET did not verify the created assignment ID and immutable identity. Deletion registration fails closed; reconcile the captured POST response before retrying."
    }
  }
}

# Capture ownership only after the independent GET succeeds. This record and
# the destroy-only action retain the old identity during replacement.
resource "terraform_data" "owned" {
  input = {
    assignmentId = try(msgraph_resource_action.assignment.output.assignment.id, "")
    resourceId   = local.body.resourceId
    principalId  = local.body.principalId
    appRoleId    = local.body.appRoleId
  }

  depends_on = [data.msgraph_resource.verify]

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [msgraph_resource_action.assignment]
  }
}

# Registration sends no request. Destroy/replacement deletes only this saved ID
# using the provider credentials; it does not re-read identity or prove absence.
resource "msgraph_resource_action" "remove" {
  resource_url = "servicePrincipals/${terraform_data.owned.input.resourceId}/appRoleAssignedTo/${terraform_data.owned.input.assignmentId}"
  api_version  = "v1.0"
  method       = "DELETE"
  when         = "destroy"

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.owned]

    precondition {
      condition = alltrue([
        can(regex("^[A-Za-z0-9_-]{1,256}$", terraform_data.owned.input.assignmentId)),
        can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", terraform_data.owned.input.resourceId)),
      ])
      error_message = "Refusing deletion registration: the saved item ID must be URL-safe and resourceId must be a normalized GUID. Reconcile ownership state without widening the DELETE URL."
    }
  }
}
