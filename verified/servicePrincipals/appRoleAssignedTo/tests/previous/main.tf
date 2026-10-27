# Legacy state-shape fixture from 6a537b36 (the cleanup provisioner is inert here).
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

  # The action is forgotten on destroy; only the identity-checked cleanup below
  # is permitted to delete. This also keeps a tainted action from bypassing a guard.
}

# Capture the created item identity once, before any optional external verification.
# This dependency orders cleanup before the old action is forgotten/replaced.
resource "terraform_data" "owned" {
  input = {
    assignmentId = var.saved_id == null ? try(msgraph_resource_action.assignment.output.assignment.id, "") : var.saved_id
    resourceId   = var.saved_resource_id == null ? local.body.resourceId : var.saved_resource_id
    principalId  = local.body.principalId
    appRoleId    = local.body.appRoleId
  }

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [msgraph_resource_action.assignment]
  }

  # Legacy provisioner omitted: state shape is unchanged; no external cleanup can run offline.
}
