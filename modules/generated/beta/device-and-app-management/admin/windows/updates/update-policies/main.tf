# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audience"              = var.audience
    "complianceChangeRules" = (var.compliance_change_rules == null ? null : [for item0 in var.compliance_change_rules : item0 if item0 != null])
    "complianceChanges"     = (var.compliance_changes == null ? null : [for item0 in var.compliance_changes : item0 if item0 != null])
    "createdDateTime"       = var.created_date_time
    "deploymentSettings"    = (var.deployment_settings == null ? null : { for key0, value0 in { "@odata.type" = var.deployment_settings["odata_type"], "contentApplicability" = (var.deployment_settings["contentApplicability"] == null ? null : { for key1, value1 in { "@odata.type" = var.deployment_settings["contentApplicability"]["odata_type"], "offerWhileRecommendedBy" = (var.deployment_settings["contentApplicability"]["offerWhileRecommendedBy"] == null ? null : [for item2 in var.deployment_settings["contentApplicability"]["offerWhileRecommendedBy"] : item2 if item2 != null]), "safeguard" = (var.deployment_settings["contentApplicability"]["safeguard"] == null ? null : { for key2, value2 in { "@odata.type" = var.deployment_settings["contentApplicability"]["safeguard"]["odata_type"], "disabledSafeguardProfiles" = (var.deployment_settings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] == null ? null : [for item3 in var.deployment_settings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "category" = item3["category"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "expedite" = (var.deployment_settings["expedite"] == null ? null : { for key1, value1 in { "@odata.type" = var.deployment_settings["expedite"]["odata_type"], "isExpedited" = var.deployment_settings["expedite"]["isExpedited"], "isReadinessTest" = var.deployment_settings["expedite"]["isReadinessTest"] } : key1 => value1 if value1 != null }), "monitoring" = (var.deployment_settings["monitoring"] == null ? null : { for key1, value1 in { "@odata.type" = var.deployment_settings["monitoring"]["odata_type"], "monitoringRules" = (var.deployment_settings["monitoring"]["monitoringRules"] == null ? null : [for item2 in var.deployment_settings["monitoring"]["monitoringRules"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "action" = item2["action"], "signal" = item2["signal"], "threshold" = item2["threshold"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }), "schedule" = (var.deployment_settings["schedule"] == null ? null : { for key1, value1 in { "@odata.type" = var.deployment_settings["schedule"]["odata_type"], "gradualRollout" = var.deployment_settings["schedule"]["gradualRollout"], "startDateTime" = var.deployment_settings["schedule"]["startDateTime"] } : key1 => value1 if value1 != null }), "userExperience" = (var.deployment_settings["userExperience"] == null ? null : { for key1, value1 in { "@odata.type" = var.deployment_settings["userExperience"]["odata_type"], "daysUntilForcedReboot" = var.deployment_settings["userExperience"]["daysUntilForcedReboot"], "isHotpatchEnabled" = var.deployment_settings["userExperience"]["isHotpatchEnabled"], "offerAsOptional" = var.deployment_settings["userExperience"]["offerAsOptional"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "@odata.type"           = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/updatePolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
