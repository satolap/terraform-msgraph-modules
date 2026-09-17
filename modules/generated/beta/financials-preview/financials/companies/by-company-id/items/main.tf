# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "baseUnitOfMeasureId"  = var.base_unit_of_measure_id
    "blocked"              = var.blocked
    "displayName"          = var.display_name
    "gtin"                 = var.gtin
    "id"                   = var.id
    "inventory"            = var.inventory
    "itemCategory"         = var.item_category
    "itemCategoryCode"     = var.item_category_code
    "itemCategoryId"       = var.item_category_id
    "lastModifiedDateTime" = var.last_modified_date_time
    "number"               = var.number
    "@odata.type"          = var.odata_type
    "picture"              = (var.picture == null ? null : [for item0 in var.picture : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "contentType" = item0["contentType"], "height" = item0["height"], "id" = item0["id"], "width" = item0["width"] } : key1 => value1 if value1 != null }) if item0 != null])
    "priceIncludesTax"     = var.price_includes_tax
    "taxGroupCode"         = var.tax_group_code
    "taxGroupId"           = var.tax_group_id
    "type"                 = var.type
    "unitCost"             = var.unit_cost
    "unitPrice"            = var.unit_price
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/items"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
