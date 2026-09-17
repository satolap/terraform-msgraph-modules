# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alert"              = var.alert
    "createdByUserId"    = var.created_by_user_id
    "createdDateTime"    = var.created_date_time
    "isAcknowledged"     = var.is_acknowledged
    "lastActionByUserId" = var.last_action_by_user_id
    "lastActionDateTime" = var.last_action_date_time
    "message"            = var.message
    "@odata.type"        = var.odata_type
    "title"              = var.title
    "userId"             = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managedTenantApiNotifications"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
