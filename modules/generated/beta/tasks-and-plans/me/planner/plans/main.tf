# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "container"                         = var.container
    "contentSensitivityLabelAssignment" = var.content_sensitivity_label_assignment
    "creationSource"                    = var.creation_source
    "@odata.type"                       = var.odata_type
    "owner"                             = var.owner
    "sharedWithContainers"              = (var.shared_with_containers == null ? null : [for item0 in var.shared_with_containers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessLevel" = item0["accessLevel"], "containerId" = item0["containerId"], "type" = item0["type"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "title"                             = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/planner/plans"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
