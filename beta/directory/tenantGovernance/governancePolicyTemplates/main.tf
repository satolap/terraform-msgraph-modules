# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"                        = var.createdDateTime
    "delegatedAdministrationRoleAssignments" = (var.delegatedAdministrationRoleAssignments == null ? null : [for item0 in var.delegatedAdministrationRoleAssignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "group" = item0["group"], "roleTemplates" = (item0["roleTemplates"] == null ? null : [for item2 in item0["roleTemplates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "id" = item2["id"], "name" = item2["name"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                            = var.description
    "displayName"                            = var.displayName
    "governedTenantCanTerminate"             = var.governedTenantCanTerminate
    "version"                                = var.graph_version
    "lastModifiedDateTime"                   = var.lastModifiedDateTime
    "multiTenantApplicationsToProvision"     = (var.multiTenantApplicationsToProvision == null ? null : [for item0 in var.multiTenantApplicationsToProvision : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appId" = item0["appId"], "displayName" = item0["displayName"], "objectId" = item0["objectId"], "requiredResourceAccesses" = (item0["requiredResourceAccesses"] == null ? null : [for item2 in item0["requiredResourceAccesses"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "permissions" = (item2["permissions"] == null ? null : [for item4 in item2["permissions"] : item4 if item4 != null]), "resourceAppId" = item2["resourceAppId"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "directory/tenantGovernance/governancePolicyTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
