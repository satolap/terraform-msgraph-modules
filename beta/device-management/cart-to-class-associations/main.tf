# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "classroomIds"         = (var.classroom_ids == null ? null : [for item0 in var.classroom_ids : item0 if item0 != null])
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "deviceCartIds"        = (var.device_cart_ids == null ? null : [for item0 in var.device_cart_ids : item0 if item0 != null])
    "displayName"          = var.display_name
    "version"              = var.graph_version
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/cartToClassAssociations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
