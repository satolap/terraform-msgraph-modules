# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "categorySummaries"     = (var.categorySummaries == null ? null : [for item0 in var.categorySummaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceId" = item0["deviceId"], "displayName" = item0["displayName"], "failedUpdateCount" = item0["failedUpdateCount"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "successfulUpdateCount" = item0["successfulUpdateCount"], "totalUpdateCount" = item0["totalUpdateCount"], "updateCategory" = item0["updateCategory"], "updateStateSummaries" = (item0["updateStateSummaries"] == null ? null : [for item2 in item0["updateStateSummaries"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "lastUpdatedDateTime" = item2["lastUpdatedDateTime"], "productKey" = item2["productKey"], "state" = item2["state"], "updateCategory" = item2["updateCategory"], "updateVersion" = item2["updateVersion"] } : key3 => value3 if value3 != null }) if item2 != null]), "userId" = item0["userId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceId"              = var.deviceId
    "deviceName"            = var.deviceName
    "displayName"           = var.displayName
    "failedUpdateCount"     = var.failedUpdateCount
    "lastUpdatedDateTime"   = var.lastUpdatedDateTime
    "@odata.type"           = var.odata_type
    "osVersion"             = var.osVersion
    "successfulUpdateCount" = var.successfulUpdateCount
    "totalUpdateCount"      = var.totalUpdateCount
    "userId"                = var.userId
    "userPrincipalName"     = var.userPrincipalName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/macOSSoftwareUpdateAccountSummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["categorySummaries"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
