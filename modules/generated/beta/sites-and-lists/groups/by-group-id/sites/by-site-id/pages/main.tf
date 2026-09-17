# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdByUser"      = var.created_by_user
    "description"        = var.description
    "lastModifiedByUser" = var.last_modified_by_user
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "pageLayout"         = var.page_layout
    "parentReference"    = var.parent_reference
    "publishingState"    = var.publishing_state
    "title"              = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/sites/${urlencode(var.site_id)}/pages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
