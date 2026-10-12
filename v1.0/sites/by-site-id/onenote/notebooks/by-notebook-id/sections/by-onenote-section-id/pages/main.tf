# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"     = var.content
    "@odata.type" = var.odata_type
    "title"       = var.title
    "userTags"    = (var.user_tags == null ? null : [for item0 in var.user_tags : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/onenote/notebooks/${urlencode(var.notebook_id)}/sections/${urlencode(var.onenote_section_id)}/pages"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
