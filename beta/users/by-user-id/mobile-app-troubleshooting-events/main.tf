# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"       = (var.additional_information == null ? null : [for item0 in var.additional_information : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appLogCollectionRequests"    = (var.app_log_collection_requests == null ? null : [for item0 in var.app_log_collection_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "completedDateTime" = item0["completedDateTime"], "customLogFolders" = (item0["customLogFolders"] == null ? null : [for item2 in item0["customLogFolders"] : item2 if item2 != null]), "errorMessage" = item0["errorMessage"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "applicationId"               = var.application_id
    "correlationId"               = var.correlation_id
    "deviceId"                    = var.device_id
    "eventDateTime"               = var.event_date_time
    "eventName"                   = var.event_name
    "history"                     = (var.history == null ? null : [for item0 in var.history : item0 if item0 != null])
    "managedDeviceIdentifier"     = var.managed_device_identifier
    "@odata.type"                 = var.odata_type
    "troubleshootingErrorDetails" = (var.troubleshooting_error_details == null ? null : { for key0, value0 in { "@odata.type" = var.troubleshooting_error_details["odata_type"], "context" = var.troubleshooting_error_details["context"], "failure" = var.troubleshooting_error_details["failure"], "failureDetails" = var.troubleshooting_error_details["failureDetails"], "remediation" = var.troubleshooting_error_details["remediation"], "resources" = (var.troubleshooting_error_details["resources"] == null ? null : [for item1 in var.troubleshooting_error_details["resources"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "link" = item1["link"], "text" = item1["text"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "userId"                      = var.user_id_2
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/mobileAppTroubleshootingEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
