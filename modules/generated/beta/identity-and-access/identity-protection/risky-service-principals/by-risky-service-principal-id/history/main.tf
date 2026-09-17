# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountEnabled"          = var.account_enabled
    "activity"                = var.activity
    "appId"                   = var.app_id
    "displayName"             = var.display_name
    "history"                 = (var.history == null ? null : [for item0 in var.history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accountEnabled" = item0["accountEnabled"], "activity" = item0["activity"], "appId" = item0["appId"], "displayName" = item0["displayName"], "history" = (item0["history"] == null ? null : [for item2 in item0["history"] : item2 if item2 != null]), "initiatedBy" = item0["initiatedBy"], "isEnabled" = item0["isEnabled"], "isProcessing" = item0["isProcessing"], "riskDetail" = item0["riskDetail"], "riskLastUpdatedDateTime" = item0["riskLastUpdatedDateTime"], "riskLevel" = item0["riskLevel"], "riskState" = item0["riskState"], "servicePrincipalId" = item0["servicePrincipalId"], "servicePrincipalType" = item0["servicePrincipalType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "initiatedBy"             = var.initiated_by
    "isEnabled"               = var.is_enabled
    "isProcessing"            = var.is_processing
    "@odata.type"             = var.odata_type
    "riskDetail"              = var.risk_detail
    "riskLastUpdatedDateTime" = var.risk_last_updated_date_time
    "riskLevel"               = var.risk_level
    "riskState"               = var.risk_state
    "servicePrincipalId"      = var.service_principal_id
    "servicePrincipalType"    = var.service_principal_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityProtection/riskyServicePrincipals/${urlencode(var.risky_service_principal_id)}/history"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
