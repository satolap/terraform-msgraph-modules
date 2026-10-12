# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "enableConnection" = var.enable_connection
    "lastSyncDateTime" = var.last_sync_date_time
    "@odata.type"      = var.odata_type
    "partnerId"        = var.partner_id
    "status"           = var.status
    "statusDetails"    = var.status_details
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/externalPartnerSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
