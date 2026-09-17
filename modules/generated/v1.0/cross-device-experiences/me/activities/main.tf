# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activationUrl"        = var.activation_url
    "activitySourceHost"   = var.activity_source_host
    "appActivityId"        = var.app_activity_id
    "appDisplayName"       = var.app_display_name
    "contentInfo"          = var.content_info
    "contentUrl"           = var.content_url
    "createdDateTime"      = var.created_date_time
    "expirationDateTime"   = var.expiration_date_time
    "fallbackUrl"          = var.fallback_url
    "historyItems"         = (var.history_items == null ? null : [for item0 in var.history_items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "activeDurationSeconds" = item0["activeDurationSeconds"], "activity" = (item0["activity"] == null ? null : { for key2, value2 in { "@odata.type" = item0["activity"]["odata_type"], "activationUrl" = item0["activity"]["activationUrl"], "activitySourceHost" = item0["activity"]["activitySourceHost"], "appActivityId" = item0["activity"]["appActivityId"], "appDisplayName" = item0["activity"]["appDisplayName"], "contentInfo" = item0["activity"]["contentInfo"], "contentUrl" = item0["activity"]["contentUrl"], "createdDateTime" = item0["activity"]["createdDateTime"], "expirationDateTime" = item0["activity"]["expirationDateTime"], "fallbackUrl" = item0["activity"]["fallbackUrl"], "historyItems" = (item0["activity"]["historyItems"] == null ? null : [for item3 in item0["activity"]["historyItems"] : item3 if item3 != null]), "lastModifiedDateTime" = item0["activity"]["lastModifiedDateTime"], "status" = item0["activity"]["status"], "userTimezone" = item0["activity"]["userTimezone"], "visualElements" = (item0["activity"]["visualElements"] == null ? null : { for key3, value3 in { "@odata.type" = item0["activity"]["visualElements"]["odata_type"], "attribution" = item0["activity"]["visualElements"]["attribution"], "backgroundColor" = item0["activity"]["visualElements"]["backgroundColor"], "content" = item0["activity"]["visualElements"]["content"], "description" = item0["activity"]["visualElements"]["description"], "displayText" = item0["activity"]["visualElements"]["displayText"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }), "createdDateTime" = item0["createdDateTime"], "expirationDateTime" = item0["expirationDateTime"], "lastActiveDateTime" = item0["lastActiveDateTime"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "startedDateTime" = item0["startedDateTime"], "status" = item0["status"], "userTimezone" = item0["userTimezone"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "status"               = var.status
    "userTimezone"         = var.user_timezone
    "visualElements"       = (var.visual_elements == null ? null : { for key0, value0 in { "@odata.type" = var.visual_elements["odata_type"], "attribution" = var.visual_elements["attribution"], "backgroundColor" = var.visual_elements["backgroundColor"], "content" = var.visual_elements["content"], "description" = var.visual_elements["description"], "displayText" = var.visual_elements["displayText"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/activities"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
