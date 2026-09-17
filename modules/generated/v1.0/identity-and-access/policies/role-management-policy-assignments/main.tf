# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"      = var.odata_type
    "policy"           = var.policy
    "policyId"         = var.policy_id
    "roleDefinitionId" = var.role_definition_id
    "scopeId"          = var.scope_id
    "scopeType"        = var.scope_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/roleManagementPolicyAssignments"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
