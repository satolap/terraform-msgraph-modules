# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"       = (var.additional_information == null ? null : [for item0 in var.additional_information : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "correlationId"               = var.correlation_id
    "eventDateTime"               = var.event_date_time
    "eventName"                   = var.event_name
    "@odata.type"                 = var.odata_type
    "troubleshootingErrorDetails" = var.troubleshooting_error_details
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/troubleshootingEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
