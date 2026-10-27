locals {
  body = merge(
    {
      displayName     = var.displayName
      isEnabled       = var.isEnabled
      rolePermissions = var.rolePermissions
    },
    var.description != null ? { description = var.description } : {},
    var.templateId != null ? { templateId = var.templateId } : {},
  )
}

# Treat the cross-directory template identifier as identity in this module.
# This is a conservative module policy, not a claim that Graph cannot update it.
resource "terraform_data" "immutable" {
  input = { templateId = var.templateId == null ? null : lower(var.templateId) }
}

resource "msgraph_resource" "roleDefinition" {
  url         = "roleManagement/directory/roleDefinitions"
  api_version = "v1.0"
  body        = local.body

  response_export_values = {
    isBuiltIn  = "isBuiltIn"
    templateId = "templateId"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]
    ignore_changes       = [body.templateId]

    postcondition {
      condition     = try(self.output.isBuiltIn == false, false)
      error_message = "Only custom role definitions may be managed. Built-in roles are read-only references; do not import them into this module."
    }

    # ignore_changes hides a template that changed remotely, so compare the value
    # Graph returns with the configured one. An omitted templateId is server-assigned
    # and stays unmanaged. A missing or null readback fails closed, as does a
    # readback that cannot be compared; the case of the GUID does not matter.
    postcondition {
      condition     = var.templateId == null ? true : try(lower(self.output.templateId) == lower(var.templateId), false)
      error_message = "Microsoft Graph returned a templateId that differs from the configured templateId, or none. The module does not adopt the returned value. Find out why the definition changed before acting; changing templateId replaces the definition and removing it from state leaves the remote definition in place."
    }

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }
  }
}
