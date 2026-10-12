# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "devicesCount"         = var.devices_count
    "lastReportedDateTime" = var.last_reported_date_time
    "@odata.type"          = var.odata_type
    "status"               = var.status
    "userDisplayName"      = var.user_display_name
    "userPrincipalName"    = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurations/${urlencode(var.device_configuration_id)}/userStatuses"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
