# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "name"            = var.name
    "@odata.type"     = var.odata_type
    "pageLayout"      = var.page_layout
    "parentReference" = (var.parent_reference == null ? null : { for key0, value0 in { "@odata.type" = var.parent_reference["odata_type"], "driveType" = var.parent_reference["driveType"], "shareId" = var.parent_reference["shareId"], "siteId" = var.parent_reference["siteId"] } : key0 => value0 if value0 != null })
    "publishingState" = (var.publishing_state == null ? null : { for key0, value0 in { "@odata.type" = var.publishing_state["odata_type"], "checkedOutBy" = var.publishing_state["checkedOutBy"] } : key0 => value0 if value0 != null })
    "title"           = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/pages"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
