# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activationCodeCount" = var.activation_code_count
    "activationCodes"     = (var.activation_codes == null ? null : [for item0 in var.activation_codes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "integratedCircuitCardIdentifier" = item0["integratedCircuitCardIdentifier"], "matchingIdentifier" = item0["matchingIdentifier"], "smdpPlusServerAddress" = item0["smdpPlusServerAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"         = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = (item0["target"] == null ? null : { for key2, value2 in { "@odata.type" = item0["target"]["odata_type"], "deviceAndAppManagementAssignmentFilterId" = item0["target"]["deviceAndAppManagementAssignmentFilterId"], "deviceAndAppManagementAssignmentFilterType" = item0["target"]["deviceAndAppManagementAssignmentFilterType"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"     = var.created_date_time
    "deviceStates"        = (var.device_states == null ? null : [for item0 in var.device_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "deviceName" = item0["deviceName"], "lastSyncDateTime" = item0["lastSyncDateTime"], "modifiedDateTime" = item0["modifiedDateTime"], "state" = item0["state"], "stateDetails" = item0["stateDetails"], "universalIntegratedCircuitCardIdentifier" = item0["universalIntegratedCircuitCardIdentifier"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"         = var.display_name
    "modifiedDateTime"    = var.modified_date_time
    "@odata.type"         = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/embeddedSIMActivationCodePools"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
