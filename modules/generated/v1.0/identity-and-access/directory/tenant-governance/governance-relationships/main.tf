# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdType"         = var.created_type
    "creationDateTime"    = var.creation_date_time
    "governedTenantId"    = var.governed_tenant_id
    "governedTenantName"  = var.governed_tenant_name
    "governingTenantId"   = var.governing_tenant_id
    "governingTenantName" = var.governing_tenant_name
    "@odata.type"         = var.odata_type
    "policySnapshot"      = (var.policy_snapshot == null ? null : { for key0, value0 in { "@odata.type" = var.policy_snapshot["odata_type"], "delegatedAdministrationRoleAssignments" = (var.policy_snapshot["delegatedAdministrationRoleAssignments"] == null ? null : [for item1 in var.policy_snapshot["delegatedAdministrationRoleAssignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "groupDisplayName" = item1["groupDisplayName"], "groupId" = item1["groupId"], "roleTemplates" = (item1["roleTemplates"] == null ? null : [for item3 in item1["roleTemplates"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "id" = item3["id"], "name" = item3["name"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]), "governedTenantCanTerminate" = var.policy_snapshot["governedTenantCanTerminate"], "multiTenantApplicationsToProvision" = (var.policy_snapshot["multiTenantApplicationsToProvision"] == null ? null : [for item1 in var.policy_snapshot["multiTenantApplicationsToProvision"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "appId" = item1["appId"], "displayName" = item1["displayName"], "objectId" = item1["objectId"], "requiredResourceAccesses" = (item1["requiredResourceAccesses"] == null ? null : [for item3 in item1["requiredResourceAccesses"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "permissions" = item3["permissions"], "resourceAppId" = item3["resourceAppId"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]), "policyId" = var.policy_snapshot["policyId"] } : key0 => value0 if value0 != null })
    "status"              = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/tenantGovernance/governanceRelationships"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
