# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audience"    = var.audience
    "content"     = var.content
    "@odata.type" = var.odata_type
    "settings"    = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "contentApplicability" = (var.settings["contentApplicability"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["contentApplicability"]["odata_type"], "offerWhileRecommendedBy" = (var.settings["contentApplicability"]["offerWhileRecommendedBy"] == null ? null : [for item2 in var.settings["contentApplicability"]["offerWhileRecommendedBy"] : item2 if item2 != null]), "safeguard" = (var.settings["contentApplicability"]["safeguard"] == null ? null : { for key2, value2 in { "@odata.type" = var.settings["contentApplicability"]["safeguard"]["odata_type"], "disabledSafeguardProfiles" = (var.settings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] == null ? null : [for item3 in var.settings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "category" = item3["category"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "expedite" = (var.settings["expedite"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["expedite"]["odata_type"], "isExpedited" = var.settings["expedite"]["isExpedited"], "isReadinessTest" = var.settings["expedite"]["isReadinessTest"] } : key1 => value1 if value1 != null }), "monitoring" = (var.settings["monitoring"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["monitoring"]["odata_type"], "monitoringRules" = (var.settings["monitoring"]["monitoringRules"] == null ? null : [for item2 in var.settings["monitoring"]["monitoringRules"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "action" = item2["action"], "signal" = item2["signal"], "threshold" = item2["threshold"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }), "schedule" = (var.settings["schedule"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["schedule"]["odata_type"], "gradualRollout" = var.settings["schedule"]["gradualRollout"], "startDateTime" = var.settings["schedule"]["startDateTime"] } : key1 => value1 if value1 != null }), "userExperience" = (var.settings["userExperience"] == null ? null : { for key1, value1 in { "@odata.type" = var.settings["userExperience"]["odata_type"], "daysUntilForcedReboot" = var.settings["userExperience"]["daysUntilForcedReboot"], "isHotpatchEnabled" = var.settings["userExperience"]["isHotpatchEnabled"], "offerAsOptional" = var.settings["userExperience"]["offerAsOptional"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "state"       = (var.state == null ? null : { for key0, value0 in { "@odata.type" = var.state["odata_type"], "effectiveValue" = var.state["effectiveValue"], "requestedValue" = var.state["requestedValue"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/deployments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
