# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"             = var.display_name
    "grades"                  = (var.grades == null ? null : [for item0 in var.grades : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "defaultPercentage" = item0["defaultPercentage"], "displayName" = item0["displayName"], "minPercentage" = item0["minPercentage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hidePointsDuringGrading" = var.hide_points_during_grading
    "@odata.type"             = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/classes/${urlencode(var.education_class_id)}/assignmentSettings/gradingSchemes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
