# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "baseline"       = (var.baseline == null ? null : { for key0, value0 in { "@odata.type" = var.baseline["odata_type"], "description" = var.baseline["description"], "displayName" = var.baseline["displayName"], "parameters" = (var.baseline["parameters"] == null ? null : [for item1 in var.baseline["parameters"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "description" = item1["description"], "displayName" = item1["displayName"], "parameterType" = item1["parameterType"] } : key2 => value2 if value2 != null }) if item1 != null]), "resources" = (var.baseline["resources"] == null ? null : [for item1 in var.baseline["resources"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "properties" = (item1["properties"] == null ? null : { for key3, value3 in { "@odata.type" = item1["properties"]["odata_type"] } : key3 => value3 if value3 != null }), "resourceType" = item1["resourceType"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "createdBy"      = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "application" = var.created_by["application"], "device" = var.created_by["device"], "user" = var.created_by["user"] } : key0 => value0 if value0 != null })
    "description"    = var.description
    "displayName"    = var.display_name
    "lastModifiedBy" = (var.last_modified_by == null ? null : { for key0, value0 in { "@odata.type" = var.last_modified_by["odata_type"], "application" = var.last_modified_by["application"], "device" = var.last_modified_by["device"], "user" = var.last_modified_by["user"] } : key0 => value0 if value0 != null })
    "mode"           = var.mode
    "@odata.type"    = var.odata_type
    "parameters"     = var.parameters
    "status"         = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/configurationManagement/configurationMonitors"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
