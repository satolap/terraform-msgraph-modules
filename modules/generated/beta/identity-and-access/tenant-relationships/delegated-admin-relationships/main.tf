# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessAssignments"  = (var.access_assignments == null ? null : [for item0 in var.access_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessContainer" = (item0["accessContainer"] == null ? null : { for key2, value2 in { "@odata.type" = item0["accessContainer"]["odata_type"], "accessContainerId" = item0["accessContainer"]["accessContainerId"], "accessContainerType" = item0["accessContainer"]["accessContainerType"] } : key2 => value2 if value2 != null }), "accessDetails" = (item0["accessDetails"] == null ? null : { for key2, value2 in { "@odata.type" = item0["accessDetails"]["odata_type"], "unifiedRoles" = (item0["accessDetails"]["unifiedRoles"] == null ? null : [for item3 in item0["accessDetails"]["unifiedRoles"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "roleDefinitionId" = item3["roleDefinitionId"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "accessDetails"      = (var.access_details == null ? null : { for key0, value0 in { "@odata.type" = var.access_details["odata_type"], "unifiedRoles" = (var.access_details["unifiedRoles"] == null ? null : [for item1 in var.access_details["unifiedRoles"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "roleDefinitionId" = item1["roleDefinitionId"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "autoExtendDuration" = var.auto_extend_duration
    "customer"           = var.customer
    "displayName"        = var.display_name
    "duration"           = var.duration
    "@odata.type"        = var.odata_type
    "operations"         = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "operationType" = item0["operationType"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "requests"           = (var.requests == null ? null : [for item0 in var.requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/delegatedAdminRelationships"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
