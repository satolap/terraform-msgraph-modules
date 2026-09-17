# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeDurationSeconds" = var.active_duration_seconds
    "activity"              = (var.activity == null ? null : { for key0, value0 in { "@odata.type" = var.activity["odata_type"], "activationUrl" = var.activity["activationUrl"], "activitySourceHost" = var.activity["activitySourceHost"], "appActivityId" = var.activity["appActivityId"], "appDisplayName" = var.activity["appDisplayName"], "contentInfo" = var.activity["contentInfo"], "contentUrl" = var.activity["contentUrl"], "createdDateTime" = var.activity["createdDateTime"], "expirationDateTime" = var.activity["expirationDateTime"], "fallbackUrl" = var.activity["fallbackUrl"], "historyItems" = (var.activity["historyItems"] == null ? null : [for item1 in var.activity["historyItems"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "activeDurationSeconds" = item1["activeDurationSeconds"], "activity" = item1["activity"], "createdDateTime" = item1["createdDateTime"], "expirationDateTime" = item1["expirationDateTime"], "lastActiveDateTime" = item1["lastActiveDateTime"], "lastModifiedDateTime" = item1["lastModifiedDateTime"], "startedDateTime" = item1["startedDateTime"], "status" = item1["status"], "userTimezone" = item1["userTimezone"] } : key2 => value2 if value2 != null }) if item1 != null]), "lastModifiedDateTime" = var.activity["lastModifiedDateTime"], "status" = var.activity["status"], "userTimezone" = var.activity["userTimezone"], "visualElements" = (var.activity["visualElements"] == null ? null : { for key1, value1 in { "@odata.type" = var.activity["visualElements"]["odata_type"], "attribution" = var.activity["visualElements"]["attribution"], "backgroundColor" = var.activity["visualElements"]["backgroundColor"], "content" = var.activity["visualElements"]["content"], "description" = var.activity["visualElements"]["description"], "displayText" = var.activity["visualElements"]["displayText"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "createdDateTime"       = var.created_date_time
    "expirationDateTime"    = var.expiration_date_time
    "lastActiveDateTime"    = var.last_active_date_time
    "lastModifiedDateTime"  = var.last_modified_date_time
    "@odata.type"           = var.odata_type
    "startedDateTime"       = var.started_date_time
    "status"                = var.status
    "userTimezone"          = var.user_timezone
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/activities/${urlencode(var.user_activity_id)}/historyItems"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
