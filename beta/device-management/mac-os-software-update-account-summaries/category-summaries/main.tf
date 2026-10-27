# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceId"              = var.device_id
    "displayName"           = var.display_name
    "failedUpdateCount"     = var.failed_update_count
    "lastUpdatedDateTime"   = var.last_updated_date_time
    "@odata.type"           = var.odata_type
    "successfulUpdateCount" = var.successful_update_count
    "totalUpdateCount"      = var.total_update_count
    "updateCategory"        = var.update_category
    "updateStateSummaries"  = (var.update_state_summaries == null ? null : [for item0 in var.update_state_summaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "productKey" = item0["productKey"], "state" = item0["state"], "updateCategory" = item0["updateCategory"], "updateVersion" = item0["updateVersion"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userId"                = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/macOSSoftwareUpdateAccountSummaries/${urlencode(var.mac_os_software_update_account_summary_id)}/categorySummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["updateStateSummaries"], name)])]))))] } : null

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
