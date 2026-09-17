# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acceptedVersion"    = var.accepted_version
    "category"           = var.category
    "createdByUserId"    = var.created_by_user_id
    "createdDateTime"    = var.created_date_time
    "description"        = var.description
    "displayName"        = var.display_name
    "informationLinks"   = (var.information_links == null ? null : [for item0 in var.information_links : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastActionByUserId" = var.last_action_by_user_id
    "lastActionDateTime" = var.last_action_date_time
    "managementTemplate" = var.management_template
    "@odata.type"        = var.odata_type
    "portalLink"         = var.portal_link
    "priority"           = var.priority
    "userImpact"         = var.user_impact
    "versions"           = (var.versions == null ? null : [for item0 in var.versions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "acceptedFor" = item0["acceptedFor"], "contentMarkdown" = item0["contentMarkdown"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "deployments" = (item0["deployments"] == null ? null : [for item2 in item0["deployments"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "error" = item2["error"], "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "status" = item2["status"], "templateStepVersion" = item2["templateStepVersion"], "tenantId" = item2["tenantId"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "name" = item0["name"], "templateStep" = item0["templateStep"], "version" = item0["version"], "versionInformation" = item0["versionInformation"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementTemplateSteps"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
