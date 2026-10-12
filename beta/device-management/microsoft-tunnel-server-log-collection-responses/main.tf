# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "endDateTime"     = var.end_date_time
    "expiryDateTime"  = var.expiry_date_time
    "@odata.type"     = var.odata_type
    "requestDateTime" = var.request_date_time
    "serverId"        = var.server_id
    "sizeInBytes"     = var.size_in_bytes
    "startDateTime"   = var.start_date_time
    "status"          = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/microsoftTunnelServerLogCollectionResponses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
