# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"                = var.activity
    "history"                 = (var.history == null ? null : [for item0 in var.history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "activity" = item0["activity"], "history" = (item0["history"] == null ? null : [for item2 in item0["history"] : item2 if item2 != null]), "initiatedBy" = item0["initiatedBy"], "isDeleted" = item0["isDeleted"], "isProcessing" = item0["isProcessing"], "riskDetail" = item0["riskDetail"], "riskLastUpdatedDateTime" = item0["riskLastUpdatedDateTime"], "riskLevel" = item0["riskLevel"], "riskState" = item0["riskState"], "userDisplayName" = item0["userDisplayName"], "userId" = item0["userId"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "initiatedBy"             = var.initiated_by
    "isDeleted"               = var.is_deleted
    "isProcessing"            = var.is_processing
    "@odata.type"             = var.odata_type
    "riskDetail"              = var.risk_detail
    "riskLastUpdatedDateTime" = var.risk_last_updated_date_time
    "riskLevel"               = var.risk_level
    "riskState"               = var.risk_state
    "userDisplayName"         = var.user_display_name
    "userId"                  = var.user_id
    "userPrincipalName"       = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityProtection/riskyUsers/${urlencode(var.risky_user_id)}/history"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
