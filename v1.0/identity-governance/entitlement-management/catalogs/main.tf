# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "catalogType"              = var.catalog_type
    "customWorkflowExtensions" = (var.custom_workflow_extensions == null ? null : [for item0 in var.custom_workflow_extensions : item0 if item0 != null])
    "description"              = var.description
    "displayName"              = var.display_name
    "isExternallyVisible"      = var.is_externally_visible
    "@odata.type"              = var.odata_type
    "resourceRoles"            = (var.resource_roles == null ? null : [for item0 in var.resource_roles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "originId" = item0["originId"], "originSystem" = item0["originSystem"], "resource" = item0["resource"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "resourceScopes"           = (var.resource_scopes == null ? null : [for item0 in var.resource_scopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "isRootScope" = item0["isRootScope"], "originId" = item0["originId"], "originSystem" = item0["originSystem"], "resource" = item0["resource"] } : key1 => value1 if value1 != null }) if item0 != null])
    "resources"                = (var.resources == null ? null : [for item0 in var.resources : item0 if item0 != null])
    "state"                    = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/catalogs"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
