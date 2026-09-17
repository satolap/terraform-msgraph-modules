# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"               = var.address
    "balance"               = var.balance
    "blocked"               = var.blocked
    "currency"              = var.currency
    "currencyCode"          = var.currency_code
    "currencyId"            = var.currency_id
    "displayName"           = var.display_name
    "email"                 = var.email
    "id"                    = var.id
    "lastModifiedDateTime"  = var.last_modified_date_time
    "number"                = var.number
    "@odata.type"           = var.odata_type
    "paymentMethod"         = var.payment_method
    "paymentMethodId"       = var.payment_method_id
    "paymentTerm"           = var.payment_term
    "paymentTermsId"        = var.payment_terms_id
    "phoneNumber"           = var.phone_number
    "picture"               = (var.picture == null ? null : [for item0 in var.picture : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "contentType" = item0["contentType"], "height" = item0["height"], "id" = item0["id"], "width" = item0["width"] } : key1 => value1 if value1 != null }) if item0 != null])
    "taxLiable"             = var.tax_liable
    "taxRegistrationNumber" = var.tax_registration_number
    "website"               = var.website
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/vendors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
