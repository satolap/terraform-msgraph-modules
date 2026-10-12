# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "anonymizeMachineData"     = var.anonymize_machine_data
    "anonymizeUserData"        = var.anonymize_user_data
    "createdDateTime"          = var.created_date_time
    "description"              = var.description
    "displayName"              = var.display_name
    "isSnapshotReport"         = var.is_snapshot_report
    "lastDataReceivedDateTime" = var.last_data_received_date_time
    "lastModifiedDateTime"     = var.last_modified_date_time
    "logDataProvider"          = var.log_data_provider
    "logFileCount"             = var.log_file_count
    "@odata.type"              = var.odata_type
    "receiverProtocol"         = var.receiver_protocol
    "supportedEntityTypes"     = (var.supported_entity_types == null ? null : [for item0 in var.supported_entity_types : item0 if item0 != null])
    "supportedTrafficTypes"    = (var.supported_traffic_types == null ? null : [for item0 in var.supported_traffic_types : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/dataDiscovery/cloudAppDiscovery/uploadedStreams"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
