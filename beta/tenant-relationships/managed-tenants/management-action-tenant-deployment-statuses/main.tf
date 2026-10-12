# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
    "statuses"    = (var.statuses == null ? null : [for item0 in var.statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "managementTemplateVersion" = item0["managementTemplateVersion"], "status" = item0["status"], "workloadActionDeploymentStatuses" = (item0["workloadActionDeploymentStatuses"] == null ? null : [for item2 in item0["workloadActionDeploymentStatuses"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "error" = item2["error"], "excludeGroups" = (item2["excludeGroups"] == null ? null : [for item4 in item2["excludeGroups"] : item4 if item4 != null]), "includeAllUsers" = item2["includeAllUsers"], "includeGroups" = (item2["includeGroups"] == null ? null : [for item4 in item2["includeGroups"] : item4 if item4 != null]), "lastDeploymentDateTime" = item2["lastDeploymentDateTime"], "status" = item2["status"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managementActionTenantDeploymentStatuses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
