# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionSummary"                    = var.action_summary
    "cloudPcIds"                       = (var.cloud_pc_ids == null ? null : [for item0 in var.cloud_pc_ids : item0 if item0 != null])
    "createdDateTime"                  = var.created_date_time
    "displayName"                      = var.display_name
    "@odata.type"                      = var.odata_type
    "scheduledDuringMaintenanceWindow" = var.scheduled_during_maintenance_window
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/bulkActions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
