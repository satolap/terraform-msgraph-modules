# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityType"  = var.activity_type
    "error"         = var.error
    "eventDateTime" = var.event_date_time
    "@odata.type"   = var.odata_type
    "performedBy"   = var.performed_by
    "resultStatus"  = var.result_status
    "serviceType"   = var.service_type
    "severity"      = var.severity
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/activityLogs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
