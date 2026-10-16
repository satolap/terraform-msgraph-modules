# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "enrolledByUser"               = var.enrolled_by_user
    "expirationDateTimeUTC"        = var.expiration_date_time_utc
    "initiatedByUserPrincipalName" = var.initiated_by_user_principal_name
    "managedDeviceId"              = var.managed_device_id_2
    "@odata.type"                  = var.odata_type
    "receivedDateTimeUTC"          = var.received_date_time_utc
    "requestedDateTimeUTC"         = var.requested_date_time_utc
    "sizeInKB"                     = var.size_in_kb
    "status"                       = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/managedDevices/${urlencode(var.managed_device_id)}/logCollectionRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
