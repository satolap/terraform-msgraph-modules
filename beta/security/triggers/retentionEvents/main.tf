# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                = var.createdBy
    "createdDateTime"          = var.createdDateTime
    "description"              = var.description
    "displayName"              = var.displayName
    "eventPropagationResults"  = (var.eventPropagationResults == null ? null : [for item0 in var.eventPropagationResults : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "location" = item0["location"], "serviceName" = item0["serviceName"], "status" = item0["status"], "statusInformation" = item0["statusInformation"] } : key1 => value1 if value1 != null }) if item0 != null])
    "eventQueries"             = (var.eventQueries == null ? null : [for item0 in var.eventQueries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "query" = item0["query"], "queryType" = item0["queryType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "eventStatus"              = (var.eventStatus == null ? null : { for key0, value0 in { "@odata.type" = var.eventStatus["odata_type"], "error" = (var.eventStatus["error"] == null ? null : { for key1, value1 in { "@odata.type" = var.eventStatus["error"]["odata_type"], "code" = var.eventStatus["error"]["code"], "details" = (var.eventStatus["error"]["details"] == null ? null : [for item2 in var.eventStatus["error"]["details"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "code" = item2["code"], "message" = item2["message"], "target" = item2["target"] } : key3 => value3 if value3 != null }) if item2 != null]), "innerError" = (var.eventStatus["error"]["innerError"] == null ? null : { for key2, value2 in { "@odata.type" = var.eventStatus["error"]["innerError"]["odata_type"], "code" = var.eventStatus["error"]["innerError"]["code"], "details" = (var.eventStatus["error"]["innerError"]["details"] == null ? null : [for item3 in var.eventStatus["error"]["innerError"]["details"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "code" = item3["code"], "message" = item3["message"], "target" = item3["target"] } : key4 => value4 if value4 != null }) if item3 != null]), "message" = var.eventStatus["error"]["innerError"]["message"], "target" = var.eventStatus["error"]["innerError"]["target"] } : key2 => value2 if value2 != null }), "message" = var.eventStatus["error"]["message"], "target" = var.eventStatus["error"]["target"] } : key1 => value1 if value1 != null }), "status" = var.eventStatus["status"] } : key0 => value0 if value0 != null })
    "eventTriggerDateTime"     = var.eventTriggerDateTime
    "lastModifiedBy"           = var.lastModifiedBy
    "lastModifiedDateTime"     = var.lastModifiedDateTime
    "lastStatusUpdateDateTime" = var.lastStatusUpdateDateTime
    "@odata.type"              = var.odata_type
    "retentionEventType"       = var.retentionEventType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "security/triggers/retentionEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["retentionEventType"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
