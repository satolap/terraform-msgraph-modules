# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdByUserId"     = var.created_by_user_id
    "createdDateTime"     = var.created_date_time
    "description"         = var.description
    "displayName"         = var.display_name
    "lastActionByUserId"  = var.last_action_by_user_id
    "lastActionDateTime"  = var.last_action_date_time
    "managementTemplates" = (var.management_templates == null ? null : [for item0 in var.management_templates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "informationLinks" = (item0["informationLinks"] == null ? null : [for item2 in item0["informationLinks"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "url" = item2["url"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "managementTemplateCollections" = (item0["managementTemplateCollections"] == null ? null : [for item2 in item0["managementTemplateCollections"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "description" = item2["description"], "displayName" = item2["displayName"], "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "managementTemplates" = (item2["managementTemplates"] == null ? null : [for item4 in item2["managementTemplates"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "managementTemplateSteps" = (item0["managementTemplateSteps"] == null ? null : [for item2 in item0["managementTemplateSteps"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "acceptedVersion" = item2["acceptedVersion"], "category" = item2["category"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "description" = item2["description"], "displayName" = item2["displayName"], "informationLinks" = (item2["informationLinks"] == null ? null : [for item4 in item2["informationLinks"] : item4 if item4 != null]), "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "managementTemplate" = item2["managementTemplate"], "portalLink" = item2["portalLink"], "priority" = item2["priority"], "userImpact" = item2["userImpact"], "versions" = (item2["versions"] == null ? null : [for item4 in item2["versions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "priority" = item0["priority"], "provider" = item0["provider"], "userImpact" = item0["userImpact"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"         = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplateCollections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
