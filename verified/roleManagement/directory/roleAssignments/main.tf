locals {
  by_lookup = var.roleDefinitionId == null
  # The list API documents filtering displayName, but not templateId. Template
  # selection therefore filters the returned definitions locally.
  lookup_name = var.role_display_name == null ? "" : var.role_display_name
}

data "msgraph_resource" "roles" {
  count       = local.by_lookup ? 1 : 0
  url         = "roleManagement/directory/roleDefinitions"
  api_version = "v1.0"
  query_parameters = var.role_display_name == null ? {} : {
    "$filter" = ["displayName eq '${replace(local.lookup_name, "'", "''")}'"]
  }
  response_export_values = { roles = "value", next_link = "\"@odata.nextLink\"" }
}

locals {
  roles = local.by_lookup ? try(concat(data.msgraph_resource.roles[0].output.roles, []), []) : []
  matches = [for role in local.roles : role if(
    var.template_id != null ? try(lower(role.templateId) == lower(var.template_id), false) :
    try(role.displayName == var.role_display_name, false)
  )]
  selected_id = local.by_lookup ? try(lower(one(local.matches).id), null) : lower(var.roleDefinitionId)
  role_id     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", local.selected_id)) ? local.selected_id : null
}

data "msgraph_resource" "role" {
  # A harmless collection URL on invalid lookup lets the explicit guard report
  # the refusal, rather than interpolating null into an item URL.
  url         = local.role_id == null ? "roleManagement/directory/roleDefinitions" : "roleManagement/directory/roleDefinitions/${local.role_id}"
  api_version = "v1.0"
  response_export_values = {
    id         = "id"
    isBuiltIn  = "isBuiltIn"
    isEnabled  = "isEnabled"
    templateId = "templateId"
  }
}

locals {
  body = {
    principalId      = lower(var.principalId)
    roleDefinitionId = local.role_id
    directoryScopeId = lower(var.directoryScopeId)
  }
  # Keep the Graph path component's documented casing, normalizing only GUIDs.
  directory_scope_id = replace(local.body.directoryScopeId, "administrativeunits", "administrativeUnits")
  request_body       = merge(local.body, { directoryScopeId = local.directory_scope_id })
  actual_scope_type  = var.directoryScopeId == "/" ? "tenant" : (startswith(var.directoryScopeId, "/administrativeUnits/") ? "administrative_unit" : "application")
}

# A create-time, read-only duplicate check. Its replacement orders removal of
# the old assignment before checking/creating the new one. The script follows
# every page and never adopts an existing assignment. Graph still arbitrates
# concurrent creates; an API refusal is surfaced by the provider unchanged.
resource "terraform_data" "preflight" {
  input = {
    body       = local.request_body
    tenant_id  = lower(var.tenant_id)
    script     = local.assignment_guard
    role_type  = var.role_type
    scope_type = var.scope_type
    selectors  = [var.roleDefinitionId == null ? null : lower(var.roleDefinitionId), var.template_id == null ? null : lower(var.template_id), var.role_display_name]
  }
  triggers_replace = [lower(var.tenant_id), local.request_body, var.role_type, var.scope_type, var.roleDefinitionId == null ? null : lower(var.roleDefinitionId), var.template_id == null ? null : lower(var.template_id), var.role_display_name]

  provisioner "local-exec" {
    command     = "duplicate"
    interpreter = ["python", "-c", self.input.script]
    environment = {
      GRAPH_ASSIGNMENT = jsonencode(self.input.body)
      GRAPH_TENANT_ID  = self.input.tenant_id
    }
  }

  lifecycle {
    precondition {
      condition     = var.template_id == null ? true : try(lower(data.msgraph_resource.role.output.templateId) == lower(var.template_id), false)
      error_message = "The role readback must identify the selected template."
    }
    precondition {
      condition     = length([for selector in [var.roleDefinitionId, var.template_id, var.role_display_name] : selector if selector != null]) == 1
      error_message = "Set exactly one of roleDefinitionId, template_id and role_display_name."
    }
    precondition {
      condition     = local.by_lookup ? try(length(local.matches) == 1, false) : true
      error_message = "The read-only role lookup must match exactly one definition; zero or several matches are refused."
    }
    precondition {
      condition     = local.by_lookup ? try(data.msgraph_resource.roles[0].output.next_link, null) == null : true
      error_message = "The role lookup returned an incomplete collection; refusing to choose a role."
    }
    precondition {
      condition     = try(lower(data.msgraph_resource.role.output.id) == local.role_id, false)
      error_message = "The role readback must identify the selected definition."
    }
    precondition {
      condition     = try(data.msgraph_resource.role.output.isBuiltIn == (var.role_type == "built_in"), false)
      error_message = "role_type must agree with the selected definition's isBuiltIn property."
    }
    precondition {
      condition     = try(data.msgraph_resource.role.output.isEnabled == true, false)
      error_message = "The selected role definition must be enabled."
    }
    precondition {
      condition     = var.scope_type == local.actual_scope_type
      error_message = "scope_type must agree with directoryScopeId."
    }
  }
}

# Direct permanent assignments have create/get/delete operations. There is no
# supported in-place reassignment: every assignment input replaces the object.
# Ignore every provider change so neither configuration nor readback can cause
# an unsupported update. GUID casing alone does not replace it.
resource "msgraph_resource" "assignment" {
  depends_on             = [terraform_data.preflight]
  url                    = "roleManagement/directory/roleAssignments"
  api_version            = "v1.0"
  body                   = local.request_body
  response_export_values = { assignment = "@" }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.preflight]
  }
}

# Persist cleanup before the fallible verification gate. This dependent is
# destroyed BEFORE the provider deletes the assignment, including replacement.
# It checks the captured ID and tuple with the CLI identity in ARM_TENANT_ID;
# failure blocks provider DELETE. No lookup-by-tuple removal is permitted.
resource "terraform_data" "ownership" {
  input = {
    id        = msgraph_resource.assignment.id
    body      = local.request_body
    tenant_id = lower(var.tenant_id)
    script    = local.assignment_guard
  }
  triggers_replace = [msgraph_resource.assignment.id]

  provisioner "local-exec" {
    when        = destroy
    command     = "owned"
    interpreter = ["python", "-c", self.input.script]
    environment = {
      GRAPH_ASSIGNMENT    = jsonencode(self.input.body)
      GRAPH_ASSIGNMENT_ID = self.input.id
      GRAPH_TENANT_ID     = self.input.tenant_id
    }
  }

  lifecycle {
    replace_triggered_by = [msgraph_resource.assignment]
  }
}

resource "terraform_data" "verification" {
  input      = msgraph_resource.assignment.id
  depends_on = [terraform_data.ownership]

  lifecycle {
    precondition {
      condition = alltrue([
        try(msgraph_resource.assignment.output.assignment.id == msgraph_resource.assignment.id, false),
        try(lower(msgraph_resource.assignment.output.assignment.principalId) == local.request_body.principalId, false),
        try(lower(msgraph_resource.assignment.output.assignment.roleDefinitionId) == local.role_id, false),
        try(lower(msgraph_resource.assignment.output.assignment.directoryScopeId) == lower(local.directory_scope_id), false),
        try(msgraph_resource.assignment.output.assignment.appScopeId == null, true),
      ])
      error_message = "The assignment readback must match its captured ID, principal, role and directory scope, with no appScopeId. Cleanup has been recorded; reconcile mismatched state before retrying."
    }
  }
}
