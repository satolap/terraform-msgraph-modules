# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"                        = var.created_date_time
    "delegatedAdministrationRoleAssignments" = (var.delegated_administration_role_assignments == null ? null : [for item0 in var.delegated_administration_role_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "group" = item0["group"], "groupDisplayName" = item0["groupDisplayName"], "roleTemplates" = (item0["roleTemplates"] == null ? null : [for item2 in item0["roleTemplates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "id" = item2["id"], "name" = item2["name"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                            = var.description
    "displayName"                            = var.display_name
    "governedTenantCanTerminate"             = var.governed_tenant_can_terminate
    "version"                                = var.graph_version
    "lastModifiedDateTime"                   = var.last_modified_date_time
    "multiTenantApplicationsToProvision"     = (var.multi_tenant_applications_to_provision == null ? null : [for item0 in var.multi_tenant_applications_to_provision : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appId" = item0["appId"], "displayName" = item0["displayName"], "objectId" = item0["objectId"], "requiredResourceAccesses" = (item0["requiredResourceAccesses"] == null ? null : [for item2 in item0["requiredResourceAccesses"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "permissions" = (item2["permissions"] == null ? null : [for item4 in item2["permissions"] : item4 if item4 != null]), "resourceAppId" = item2["resourceAppId"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/tenantGovernance/governancePolicyTemplates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
