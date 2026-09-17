# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                = var.created_by
    "createdDateTime"          = var.created_date_time
    "description"              = var.description
    "displayName"              = var.display_name
    "eventPropagationResults"  = (var.event_propagation_results == null ? null : [for item0 in var.event_propagation_results : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "location" = item0["location"], "serviceName" = item0["serviceName"], "status" = item0["status"], "statusInformation" = item0["statusInformation"] } : key1 => value1 if value1 != null }) if item0 != null])
    "eventQueries"             = (var.event_queries == null ? null : [for item0 in var.event_queries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "query" = item0["query"], "queryType" = item0["queryType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "eventStatus"              = var.event_status
    "eventTriggerDateTime"     = var.event_trigger_date_time
    "lastModifiedBy"           = var.last_modified_by
    "lastModifiedDateTime"     = var.last_modified_date_time
    "lastStatusUpdateDateTime" = var.last_status_update_date_time
    "@odata.type"              = var.odata_type
    "retentionEventType"       = var.retention_event_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/triggers/retentionEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
