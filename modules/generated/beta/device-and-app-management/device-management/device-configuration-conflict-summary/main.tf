# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "conflictingDeviceConfigurations" = (var.conflicting_device_configurations == null ? null : [for item0 in var.conflicting_device_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "id" = item0["id"], "sourceType" = item0["sourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "contributingSettings"            = (var.contributing_settings == null ? null : [for item0 in var.contributing_settings : item0 if item0 != null])
    "deviceCheckinsImpacted"          = var.device_checkins_impacted
    "@odata.type"                     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurationConflictSummary"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
