# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceId"         = var.device_id
    "deviceName"       = var.device_name
    "errorCode"        = var.error_code
    "installState"     = var.install_state
    "lastSyncDateTime" = var.last_sync_date_time
    "@odata.type"      = var.odata_type
    "osDescription"    = var.os_description
    "osVersion"        = var.os_version
    "userName"         = var.user_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedEBooks/${urlencode(var.managed_e_book_id)}/userStateSummary/${urlencode(var.user_install_state_summary_id)}/deviceStates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
