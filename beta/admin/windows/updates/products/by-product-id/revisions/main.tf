# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "catalogEntry"         = var.catalog_entry
    "knowledgeBaseArticle" = var.knowledge_base_article
    "@odata.type"          = var.odata_type
    "osBuild"              = (var.os_build == null ? null : { for key0, value0 in { "@odata.type" = var.os_build["odata_type"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/products/${urlencode(var.product_id)}/revisions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
