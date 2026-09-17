# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"             = var.activity
    "activityState"        = var.activity_state
    "companyAssetTag"      = var.company_asset_tag
    "configuration"        = var.configuration
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "currentUser"          = var.current_user
    "deviceType"           = var.device_type
    "hardwareDetail"       = (var.hardware_detail == null ? null : { for key0, value0 in { "@odata.type" = var.hardware_detail["odata_type"], "macAddresses" = (var.hardware_detail["macAddresses"] == null ? null : [for item1 in var.hardware_detail["macAddresses"] : item1 if item1 != null]), "manufacturer" = var.hardware_detail["manufacturer"], "model" = var.hardware_detail["model"], "serialNumber" = var.hardware_detail["serialNumber"], "uniqueId" = var.hardware_detail["uniqueId"] } : key0 => value0 if value0 != null })
    "health"               = var.health
    "healthStatus"         = var.health_status
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "notes"                = var.notes
    "@odata.type"          = var.odata_type
    "operations"           = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "completedDateTime" = item0["completedDateTime"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "error" = item0["error"], "lastActionBy" = item0["lastActionBy"], "lastActionDateTime" = item0["lastActionDateTime"], "operationType" = item0["operationType"], "startedDateTime" = item0["startedDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/devices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
