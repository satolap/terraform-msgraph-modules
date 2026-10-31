# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audience"              = var.audience
    "complianceChangeRules" = (var.complianceChangeRules == null ? null : [for item0 in var.complianceChangeRules : item0 if item0 != null])
    "complianceChanges"     = (var.complianceChanges == null ? null : [for item0 in var.complianceChanges : item0 if item0 != null])
    "createdDateTime"       = var.createdDateTime
    "deploymentSettings"    = (var.deploymentSettings == null ? null : { for key0, value0 in { "@odata.type" = var.deploymentSettings["odata_type"], "contentApplicability" = (var.deploymentSettings["contentApplicability"] == null ? null : { for key1, value1 in { "@odata.type" = var.deploymentSettings["contentApplicability"]["odata_type"], "offerWhileRecommendedBy" = (var.deploymentSettings["contentApplicability"]["offerWhileRecommendedBy"] == null ? null : [for item2 in var.deploymentSettings["contentApplicability"]["offerWhileRecommendedBy"] : item2 if item2 != null]), "safeguard" = (var.deploymentSettings["contentApplicability"]["safeguard"] == null ? null : { for key2, value2 in { "@odata.type" = var.deploymentSettings["contentApplicability"]["safeguard"]["odata_type"], "disabledSafeguardProfiles" = (var.deploymentSettings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] == null ? null : [for item3 in var.deploymentSettings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "category" = item3["category"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "expedite" = (var.deploymentSettings["expedite"] == null ? null : { for key1, value1 in { "@odata.type" = var.deploymentSettings["expedite"]["odata_type"], "isExpedited" = var.deploymentSettings["expedite"]["isExpedited"], "isReadinessTest" = var.deploymentSettings["expedite"]["isReadinessTest"] } : key1 => value1 if value1 != null }), "monitoring" = (var.deploymentSettings["monitoring"] == null ? null : { for key1, value1 in { "@odata.type" = var.deploymentSettings["monitoring"]["odata_type"], "monitoringRules" = (var.deploymentSettings["monitoring"]["monitoringRules"] == null ? null : [for item2 in var.deploymentSettings["monitoring"]["monitoringRules"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "action" = item2["action"], "signal" = item2["signal"], "threshold" = item2["threshold"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }), "schedule" = (var.deploymentSettings["schedule"] == null ? null : { for key1, value1 in { "@odata.type" = var.deploymentSettings["schedule"]["odata_type"], "gradualRollout" = var.deploymentSettings["schedule"]["gradualRollout"], "startDateTime" = var.deploymentSettings["schedule"]["startDateTime"] } : key1 => value1 if value1 != null }), "userExperience" = (var.deploymentSettings["userExperience"] == null ? null : { for key1, value1 in { "@odata.type" = var.deploymentSettings["userExperience"]["odata_type"], "daysUntilForcedReboot" = var.deploymentSettings["userExperience"]["daysUntilForcedReboot"], "isHotpatchEnabled" = var.deploymentSettings["userExperience"]["isHotpatchEnabled"], "offerAsOptional" = var.deploymentSettings["userExperience"]["offerAsOptional"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "@odata.type"           = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/updatePolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["audience", "complianceChanges"], name)])]))))] } : null

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
