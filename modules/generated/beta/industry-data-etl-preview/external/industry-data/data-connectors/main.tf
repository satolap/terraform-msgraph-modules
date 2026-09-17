# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"  = var.display_name
    "@odata.type"  = var.odata_type
    "sourceSystem" = (var.source_system == null ? null : { for key0, value0 in { "@odata.type" = var.source_system["odata_type"], "displayName" = var.source_system["displayName"], "userMatchingSettings" = (var.source_system["userMatchingSettings"] == null ? null : [for item1 in var.source_system["userMatchingSettings"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "matchTarget" = item1["matchTarget"], "priorityOrder" = item1["priorityOrder"], "roleGroup" = (item1["roleGroup"] == null ? null : { for key3, value3 in { "@odata.type" = item1["roleGroup"]["odata_type"], "displayName" = item1["roleGroup"]["displayName"], "roles" = (item1["roleGroup"]["roles"] == null ? null : [for item4 in item1["roleGroup"]["roles"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "sourceIdentifier" = (item1["sourceIdentifier"] == null ? null : { for key3, value3 in { "@odata.type" = item1["sourceIdentifier"]["odata_type"], "code" = item1["sourceIdentifier"]["code"], "value" = (item1["sourceIdentifier"]["value"] == null ? null : { for key4, value4 in { "@odata.type" = item1["sourceIdentifier"]["value"]["odata_type"], "code" = item1["sourceIdentifier"]["value"]["code"], "displayName" = item1["sourceIdentifier"]["value"]["displayName"], "isDisabled" = item1["sourceIdentifier"]["value"]["isDisabled"], "referenceType" = item1["sourceIdentifier"]["value"]["referenceType"], "sortIndex" = item1["sourceIdentifier"]["value"]["sortIndex"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }) if item1 != null]), "vendor" = var.source_system["vendor"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/dataConnectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
