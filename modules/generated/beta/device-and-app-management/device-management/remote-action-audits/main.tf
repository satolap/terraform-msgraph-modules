# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"                       = var.action
    "actionState"                  = var.action_state
    "bulkDeviceActionId"           = var.bulk_device_action_id
    "deviceActionCategory"         = var.device_action_category
    "deviceDisplayName"            = var.device_display_name
    "deviceIMEI"                   = var.device_imei
    "deviceOwnerUserPrincipalName" = var.device_owner_user_principal_name
    "initiatedByUserPrincipalName" = var.initiated_by_user_principal_name
    "managedDeviceId"              = var.managed_device_id
    "@odata.type"                  = var.odata_type
    "requestDateTime"              = var.request_date_time
    "userName"                     = var.user_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/remoteActionAudits"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
