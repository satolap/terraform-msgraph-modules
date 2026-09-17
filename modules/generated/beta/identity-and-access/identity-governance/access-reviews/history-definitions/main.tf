# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                        = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "displayName" = var.created_by["displayName"], "id" = var.created_by["id"], "ipAddress" = var.created_by["ipAddress"], "userPrincipalName" = var.created_by["userPrincipalName"] } : key0 => value0 if value0 != null })
    "createdDateTime"                  = var.created_date_time
    "decisions"                        = (var.decisions == null ? null : [for item0 in var.decisions : item0 if item0 != null])
    "displayName"                      = var.display_name
    "downloadUri"                      = var.download_uri
    "fulfilledDateTime"                = var.fulfilled_date_time
    "instances"                        = (var.instances == null ? null : [for item0 in var.instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "downloadUri" = item0["downloadUri"], "expirationDateTime" = item0["expirationDateTime"], "fulfilledDateTime" = item0["fulfilledDateTime"], "reviewHistoryPeriodEndDateTime" = item0["reviewHistoryPeriodEndDateTime"], "reviewHistoryPeriodStartDateTime" = item0["reviewHistoryPeriodStartDateTime"], "runDateTime" = item0["runDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                      = var.odata_type
    "reviewHistoryPeriodEndDateTime"   = var.review_history_period_end_date_time
    "reviewHistoryPeriodStartDateTime" = var.review_history_period_start_date_time
    "scheduleSettings"                 = var.schedule_settings
    "scopes"                           = (var.scopes == null ? null : [for item0 in var.scopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                           = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/historyDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
