# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "canvasLayout"       = var.canvas_layout
    "createdByUser"      = var.created_by_user
    "description"        = var.description
    "lastModifiedByUser" = var.last_modified_by_user
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "pageLayout"         = var.page_layout
    "parentReference"    = var.parent_reference
    "publishingState"    = var.publishing_state
    "title"              = var.title
    "titleArea"          = var.title_area
    "webParts"           = (var.web_parts == null ? null : [for item0 in var.web_parts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/pageTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
