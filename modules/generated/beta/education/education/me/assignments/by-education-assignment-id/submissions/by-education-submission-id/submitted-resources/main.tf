# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentResourceUrl" = var.assignment_resource_url
    "dependentResources"    = (var.dependent_resources == null ? null : [for item0 in var.dependent_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentResourceUrl" = item0["assignmentResourceUrl"], "dependentResources" = (item0["dependentResources"] == null ? null : [for item2 in item0["dependentResources"] : item2 if item2 != null]), "resource" = item0["resource"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"           = var.odata_type
    "resource"              = var.resource
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/me/assignments/${urlencode(var.education_assignment_id)}/submissions/${urlencode(var.education_submission_id)}/submittedResources"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
