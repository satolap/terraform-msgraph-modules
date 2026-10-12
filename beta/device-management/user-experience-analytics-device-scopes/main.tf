# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"      = var.created_date_time
    "deviceScopeName"      = var.device_scope_name
    "enabled"              = var.enabled
    "isBuiltIn"            = var.is_built_in
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "operator"             = var.operator
    "ownerId"              = var.owner_id
    "parameter"            = var.parameter
    "status"               = var.status
    "value"                = var.value
    "valueObjectId"        = var.value_object_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsDeviceScopes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
