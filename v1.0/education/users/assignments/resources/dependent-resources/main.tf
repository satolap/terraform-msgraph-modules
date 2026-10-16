# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "dependentResources"       = (var.dependent_resources == null ? null : [for item0 in var.dependent_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "dependentResources" = (item0["dependentResources"] == null ? null : [for item2 in item0["dependentResources"] : item2 if item2 != null]), "distributeForStudentWork" = item0["distributeForStudentWork"], "resource" = item0["resource"] } : key1 => value1 if value1 != null }) if item0 != null])
    "distributeForStudentWork" = var.distribute_for_student_work
    "@odata.type"              = var.odata_type
    "resource"                 = var.resource
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/users/${urlencode(var.education_user_id)}/assignments/${urlencode(var.education_assignment_id)}/resources/${urlencode(var.education_assignment_resource_id)}/dependentResources"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
