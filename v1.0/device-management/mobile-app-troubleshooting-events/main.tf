# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appLogCollectionRequests" = (var.app_log_collection_requests == null ? null : [for item0 in var.app_log_collection_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "completedDateTime" = item0["completedDateTime"], "customLogFolders" = (item0["customLogFolders"] == null ? null : [for item2 in item0["customLogFolders"] : item2 if item2 != null]), "errorMessage" = item0["errorMessage"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"              = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/mobileAppTroubleshootingEvents"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
