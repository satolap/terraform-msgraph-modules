# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appScopeId"       = var.app_scope_id
    "createdDateTime"  = var.created_date_time
    "createdUsing"     = var.created_using
    "directoryScopeId" = var.directory_scope_id
    "memberType"       = var.member_type
    "modifiedDateTime" = var.modified_date_time
    "@odata.type"      = var.odata_type
    "principal"        = var.principal
    "principalId"      = var.principal_id
    "roleDefinition"   = var.role_definition
    "roleDefinitionId" = var.role_definition_id
    "scheduleInfo"     = var.schedule_info
    "status"           = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/entitlementManagement/roleEligibilitySchedules"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
