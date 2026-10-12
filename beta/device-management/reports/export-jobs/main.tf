# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "expirationDateTime" = var.expiration_date_time
    "filter"             = var.filter
    "format"             = var.format
    "localizationType"   = var.localization_type
    "@odata.type"        = var.odata_type
    "reportName"         = var.report_name
    "requestDateTime"    = var.request_date_time
    "search"             = var.search
    "select"             = (var.select == null ? null : [for item0 in var.select : item0 if item0 != null])
    "snapshotId"         = var.snapshot_id
    "status"             = var.status
    "url"                = var.url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/reports/exportJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
