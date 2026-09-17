# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"     = var.content
    "contentType" = var.content_type
    "height"      = var.height
    "id"          = var.id
    "@odata.type" = var.odata_type
    "width"       = var.width
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/salesOrders/${urlencode(var.sales_order_id)}/customer/picture"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
