# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "agentSetting"     = var.agent_setting
    "connectionStatus" = var.connection_status
    "enableConnection" = var.enable_connection
    "lastSyncDateTime" = var.last_sync_date_time
    "@odata.type"      = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/externalPartners"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
