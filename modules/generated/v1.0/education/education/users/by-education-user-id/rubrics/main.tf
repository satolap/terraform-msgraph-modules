# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "displayName" = var.display_name
    "grading"     = var.grading
    "levels"      = (var.levels == null ? null : [for item0 in var.levels : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "grading" = item0["grading"], "levelId" = item0["levelId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
    "qualities"   = (var.qualities == null ? null : [for item0 in var.qualities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "criteria" = (item0["criteria"] == null ? null : [for item2 in item0["criteria"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "description" = item2["description"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "qualityId" = item0["qualityId"], "weight" = item0["weight"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/users/${urlencode(var.education_user_id)}/rubrics"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
