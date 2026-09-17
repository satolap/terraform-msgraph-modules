# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "categorySummaries"     = (var.category_summaries == null ? null : [for item0 in var.category_summaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceId" = item0["deviceId"], "displayName" = item0["displayName"], "failedUpdateCount" = item0["failedUpdateCount"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "successfulUpdateCount" = item0["successfulUpdateCount"], "totalUpdateCount" = item0["totalUpdateCount"], "updateCategory" = item0["updateCategory"], "updateStateSummaries" = (item0["updateStateSummaries"] == null ? null : [for item2 in item0["updateStateSummaries"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "lastUpdatedDateTime" = item2["lastUpdatedDateTime"], "productKey" = item2["productKey"], "state" = item2["state"], "updateCategory" = item2["updateCategory"], "updateVersion" = item2["updateVersion"] } : key3 => value3 if value3 != null }) if item2 != null]), "userId" = item0["userId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceId"              = var.device_id
    "deviceName"            = var.device_name
    "displayName"           = var.display_name
    "failedUpdateCount"     = var.failed_update_count
    "lastUpdatedDateTime"   = var.last_updated_date_time
    "@odata.type"           = var.odata_type
    "osVersion"             = var.os_version
    "successfulUpdateCount" = var.successful_update_count
    "totalUpdateCount"      = var.total_update_count
    "userId"                = var.user_id
    "userPrincipalName"     = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/macOSSoftwareUpdateAccountSummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
