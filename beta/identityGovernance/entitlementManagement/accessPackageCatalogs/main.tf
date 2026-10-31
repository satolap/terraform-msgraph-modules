# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageCustomWorkflowExtensions" = (var.accessPackageCustomWorkflowExtensions == null ? null : [for item0 in var.accessPackageCustomWorkflowExtensions : item0 if item0 != null])
    "accessPackageResourceScopes"           = (var.accessPackageResourceScopes == null ? null : [for item0 in var.accessPackageResourceScopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessPackageResource" = item0["accessPackageResource"], "description" = item0["description"], "displayName" = item0["displayName"], "isRootScope" = item0["isRootScope"], "originId" = item0["originId"], "originSystem" = item0["originSystem"], "roleOriginId" = item0["roleOriginId"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "accessPackageResources"                = (var.accessPackageResources == null ? null : [for item0 in var.accessPackageResources : item0 if item0 != null])
    "catalogStatus"                         = var.catalogStatus
    "catalogType"                           = var.catalogType
    "customAccessPackageWorkflowExtensions" = (var.customAccessPackageWorkflowExtensions == null ? null : [for item0 in var.customAccessPackageWorkflowExtensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "authenticationConfiguration" = item0["authenticationConfiguration"], "clientConfiguration" = (item0["clientConfiguration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["clientConfiguration"]["odata_type"], "maximumRetries" = item0["clientConfiguration"]["maximumRetries"], "timeoutInMilliseconds" = item0["clientConfiguration"]["timeoutInMilliseconds"] } : key2 => value2 if value2 != null }), "description" = item0["description"], "displayName" = item0["displayName"], "endpointConfiguration" = item0["endpointConfiguration"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                           = var.description
    "displayName"                           = var.displayName
    "isExternallyVisible"                   = var.isExternallyVisible
    "@odata.type"                           = var.odata_type
    "privilegeLevel"                        = var.privilegeLevel
    "uniqueName"                            = var.uniqueName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageCatalogs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["accessPackageCustomWorkflowExtensions", "accessPackageResourceScopes", "accessPackageResources", "customAccessPackageWorkflowExtensions"], name)])]))))] } : null

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
