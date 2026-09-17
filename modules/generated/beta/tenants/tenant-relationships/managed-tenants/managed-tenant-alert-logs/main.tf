# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alert"              = var.alert
    "content"            = var.content
    "createdByUserId"    = var.created_by_user_id
    "createdDateTime"    = var.created_date_time
    "lastActionByUserId" = var.last_action_by_user_id
    "lastActionDateTime" = var.last_action_date_time
    "@odata.type"        = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managedTenantAlertLogs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
