# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageCustomWorkflowExtensions" = (var.access_package_custom_workflow_extensions == null ? null : [for item0 in var.access_package_custom_workflow_extensions : item0 if item0 != null])
    "accessPackageResourceScopes"           = (var.access_package_resource_scopes == null ? null : [for item0 in var.access_package_resource_scopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessPackageResource" = item0["accessPackageResource"], "description" = item0["description"], "displayName" = item0["displayName"], "isRootScope" = item0["isRootScope"], "originId" = item0["originId"], "originSystem" = item0["originSystem"], "roleOriginId" = item0["roleOriginId"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "accessPackageResources"                = (var.access_package_resources == null ? null : [for item0 in var.access_package_resources : item0 if item0 != null])
    "catalogStatus"                         = var.catalog_status
    "catalogType"                           = var.catalog_type
    "customAccessPackageWorkflowExtensions" = (var.custom_access_package_workflow_extensions == null ? null : [for item0 in var.custom_access_package_workflow_extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "authenticationConfiguration" = item0["authenticationConfiguration"], "clientConfiguration" = (item0["clientConfiguration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["clientConfiguration"]["odata_type"], "maximumRetries" = item0["clientConfiguration"]["maximumRetries"], "timeoutInMilliseconds" = item0["clientConfiguration"]["timeoutInMilliseconds"] } : key2 => value2 if value2 != null }), "description" = item0["description"], "displayName" = item0["displayName"], "endpointConfiguration" = item0["endpointConfiguration"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                           = var.description
    "displayName"                           = var.display_name
    "isExternallyVisible"                   = var.is_externally_visible
    "@odata.type"                           = var.odata_type
    "privilegeLevel"                        = var.privilege_level
    "uniqueName"                            = var.unique_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/catalogs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
