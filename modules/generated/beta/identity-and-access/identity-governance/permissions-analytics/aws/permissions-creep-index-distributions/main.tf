# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authorizationSystem" = (var.authorization_system == null ? null : { for key0, value0 in { "@odata.type" = var.authorization_system["odata_type"], "authorizationSystemId" = var.authorization_system["authorizationSystemId"], "authorizationSystemName" = var.authorization_system["authorizationSystemName"], "authorizationSystemType" = var.authorization_system["authorizationSystemType"], "dataCollectionInfo" = var.authorization_system["dataCollectionInfo"] } : key0 => value0 if value0 != null })
    "createdDateTime"     = var.created_date_time
    "highRiskProfile"     = (var.high_risk_profile == null ? null : { for key0, value0 in { "@odata.type" = var.high_risk_profile["odata_type"], "humanCount" = var.high_risk_profile["humanCount"], "nonHumanCount" = var.high_risk_profile["nonHumanCount"] } : key0 => value0 if value0 != null })
    "lowRiskProfile"      = (var.low_risk_profile == null ? null : { for key0, value0 in { "@odata.type" = var.low_risk_profile["odata_type"], "humanCount" = var.low_risk_profile["humanCount"], "nonHumanCount" = var.low_risk_profile["nonHumanCount"] } : key0 => value0 if value0 != null })
    "mediumRiskProfile"   = (var.medium_risk_profile == null ? null : { for key0, value0 in { "@odata.type" = var.medium_risk_profile["odata_type"], "humanCount" = var.medium_risk_profile["humanCount"], "nonHumanCount" = var.medium_risk_profile["nonHumanCount"] } : key0 => value0 if value0 != null })
    "@odata.type"         = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/permissionsAnalytics/aws/permissionsCreepIndexDistributions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
