# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "expirationDateTime"  = var.expiration_date_time
    "filter"              = var.filter
    "lastRefreshDateTime" = var.last_refresh_date_time
    "metadata"            = var.metadata
    "@odata.type"         = var.odata_type
    "orderBy"             = (var.order_by == null ? null : [for item0 in var.order_by : item0 if item0 != null])
    "reportName"          = var.report_name
    "select"              = (var.select == null ? null : [for item0 in var.select : item0 if item0 != null])
    "status"              = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/reports/cachedReportConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
