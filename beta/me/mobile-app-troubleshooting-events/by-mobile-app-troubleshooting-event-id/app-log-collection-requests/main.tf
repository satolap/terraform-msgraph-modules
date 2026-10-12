# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completedDateTime" = var.completed_date_time
    "customLogFolders"  = (var.custom_log_folders == null ? null : [for item0 in var.custom_log_folders : item0 if item0 != null])
    "errorMessage"      = var.error_message
    "@odata.type"       = var.odata_type
    "status"            = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/mobileAppTroubleshootingEvents/${urlencode(var.mobile_app_troubleshooting_event_id)}/appLogCollectionRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
