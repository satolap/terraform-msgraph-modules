# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdByUserId"               = var.created_by_user_id
    "createdDateTime"               = var.created_date_time
    "provider"                      = var.graph_provider
    "version"                       = var.graph_version
    "informationLinks"              = (var.information_links == null ? null : [for item0 in var.information_links : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastActionByUserId"            = var.last_action_by_user_id
    "lastActionDateTime"            = var.last_action_date_time
    "managementTemplateCollections" = (var.management_template_collections == null ? null : [for item0 in var.management_template_collections : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "managementTemplates" = (item0["managementTemplates"] == null ? null : [for item2 in item0["managementTemplates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "informationLinks" = (item2["informationLinks"] == null ? null : [for item4 in item2["informationLinks"] : item4 if item4 != null]), "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "managementTemplateCollections" = (item2["managementTemplateCollections"] == null ? null : [for item4 in item2["managementTemplateCollections"] : item4 if item4 != null]), "managementTemplateSteps" = (item2["managementTemplateSteps"] == null ? null : [for item4 in item2["managementTemplateSteps"] : item4 if item4 != null]), "priority" = item2["priority"], "provider" = item2["provider"], "userImpact" = item2["userImpact"], "version" = item2["version"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "managementTemplateSteps"       = (var.management_template_steps == null ? null : [for item0 in var.management_template_steps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "acceptedVersion" = item0["acceptedVersion"], "category" = item0["category"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "informationLinks" = (item0["informationLinks"] == null ? null : [for item2 in item0["informationLinks"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "url" = item2["url"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "managementTemplate" = item0["managementTemplate"], "portalLink" = item0["portalLink"], "priority" = item0["priority"], "userImpact" = item0["userImpact"], "versions" = (item0["versions"] == null ? null : [for item2 in item0["versions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "acceptedFor" = item2["acceptedFor"], "contentMarkdown" = item2["contentMarkdown"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "deployments" = (item2["deployments"] == null ? null : [for item4 in item2["deployments"] : item4 if item4 != null]), "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "name" = item2["name"], "templateStep" = item2["templateStep"], "version" = item2["version"], "versionInformation" = item2["versionInformation"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "priority"                      = var.priority
    "userImpact"                    = var.user_impact
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
