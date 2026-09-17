# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activatedUsing"           = var.activated_using
    "appScopeId"               = var.app_scope_id
    "assignmentType"           = var.assignment_type
    "directoryScopeId"         = var.directory_scope_id
    "endDateTime"              = var.end_date_time
    "memberType"               = var.member_type
    "@odata.type"              = var.odata_type
    "principal"                = var.principal
    "principalId"              = var.principal_id
    "roleAssignmentOriginId"   = var.role_assignment_origin_id
    "roleAssignmentScheduleId" = var.role_assignment_schedule_id
    "roleDefinition"           = var.role_definition
    "roleDefinitionId"         = var.role_definition_id
    "startDateTime"            = var.start_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/enterpriseApps/${urlencode(var.rbac_application_id)}/roleAssignmentScheduleInstances"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
