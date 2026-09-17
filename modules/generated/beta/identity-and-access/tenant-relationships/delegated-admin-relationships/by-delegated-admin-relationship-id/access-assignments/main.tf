# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessContainer" = (var.access_container == null ? null : { for key0, value0 in { "@odata.type" = var.access_container["odata_type"], "accessContainerId" = var.access_container["accessContainerId"], "accessContainerType" = var.access_container["accessContainerType"] } : key0 => value0 if value0 != null })
    "accessDetails"   = (var.access_details == null ? null : { for key0, value0 in { "@odata.type" = var.access_details["odata_type"], "unifiedRoles" = (var.access_details["unifiedRoles"] == null ? null : [for item1 in var.access_details["unifiedRoles"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "roleDefinitionId" = item1["roleDefinitionId"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/delegatedAdminRelationships/${urlencode(var.delegated_admin_relationship_id)}/accessAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
