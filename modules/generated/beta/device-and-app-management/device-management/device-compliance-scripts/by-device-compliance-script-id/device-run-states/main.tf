# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "detectionState"              = var.detection_state
    "expectedStateUpdateDateTime" = var.expected_state_update_date_time
    "lastStateUpdateDateTime"     = var.last_state_update_date_time
    "lastSyncDateTime"            = var.last_sync_date_time
    "managedDevice"               = var.managed_device
    "@odata.type"                 = var.odata_type
    "scriptError"                 = var.script_error
    "scriptOutput"                = var.script_output
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceComplianceScripts/${urlencode(var.device_compliance_script_id)}/deviceRunStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
