# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"          = var.display_name
    "@odata.type"          = var.odata_type
    "userMatchingSettings" = (var.user_matching_settings == null ? null : [for item0 in var.user_matching_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "matchTarget" = item0["matchTarget"], "priorityOrder" = item0["priorityOrder"], "roleGroup" = (item0["roleGroup"] == null ? null : { for key2, value2 in { "@odata.type" = item0["roleGroup"]["odata_type"], "displayName" = item0["roleGroup"]["displayName"], "roles" = (item0["roleGroup"]["roles"] == null ? null : [for item3 in item0["roleGroup"]["roles"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "code" = item3["code"], "value" = item3["value"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }), "sourceIdentifier" = (item0["sourceIdentifier"] == null ? null : { for key2, value2 in { "@odata.type" = item0["sourceIdentifier"]["odata_type"], "code" = item0["sourceIdentifier"]["code"], "value" = (item0["sourceIdentifier"]["value"] == null ? null : { for key3, value3 in { "@odata.type" = item0["sourceIdentifier"]["value"]["odata_type"], "code" = item0["sourceIdentifier"]["value"]["code"], "displayName" = item0["sourceIdentifier"]["value"]["displayName"], "isDisabled" = item0["sourceIdentifier"]["value"]["isDisabled"], "referenceType" = item0["sourceIdentifier"]["value"]["referenceType"], "sortIndex" = item0["sourceIdentifier"]["value"]["sortIndex"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "vendor"               = var.vendor
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/sourceSystems"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
