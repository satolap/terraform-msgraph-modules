# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                = var.created_by
    "createdDateTime"          = var.created_date_time
    "description"              = var.description
    "displayName"              = var.display_name
    "eventPropagationResults"  = (var.event_propagation_results == null ? null : [for item0 in var.event_propagation_results : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "location" = item0["location"], "serviceName" = item0["serviceName"], "status" = item0["status"], "statusInformation" = item0["statusInformation"] } : key1 => value1 if value1 != null }) if item0 != null])
    "eventQueries"             = (var.event_queries == null ? null : [for item0 in var.event_queries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "query" = item0["query"], "queryType" = item0["queryType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "eventStatus"              = (var.event_status == null ? null : { for key0, value0 in { "@odata.type" = var.event_status["odata_type"], "error" = (var.event_status["error"] == null ? null : { for key1, value1 in { "@odata.type" = var.event_status["error"]["odata_type"], "code" = var.event_status["error"]["code"], "details" = (var.event_status["error"]["details"] == null ? null : [for item2 in var.event_status["error"]["details"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "code" = item2["code"], "message" = item2["message"], "target" = item2["target"] } : key3 => value3 if value3 != null }) if item2 != null]), "innerError" = (var.event_status["error"]["innerError"] == null ? null : { for key2, value2 in { "@odata.type" = var.event_status["error"]["innerError"]["odata_type"], "code" = var.event_status["error"]["innerError"]["code"], "details" = (var.event_status["error"]["innerError"]["details"] == null ? null : [for item3 in var.event_status["error"]["innerError"]["details"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "code" = item3["code"], "message" = item3["message"], "target" = item3["target"] } : key4 => value4 if value4 != null }) if item3 != null]), "message" = var.event_status["error"]["innerError"]["message"], "target" = var.event_status["error"]["innerError"]["target"] } : key2 => value2 if value2 != null }), "message" = var.event_status["error"]["message"], "target" = var.event_status["error"]["target"] } : key1 => value1 if value1 != null }), "status" = var.event_status["status"] } : key0 => value0 if value0 != null })
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
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
