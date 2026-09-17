# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "calculateDiscountOnCreditMemos" = var.calculate_discount_on_credit_memos
    "code"                           = var.code
    "discountDateCalculation"        = var.discount_date_calculation
    "discountPercent"                = var.discount_percent
    "displayName"                    = var.display_name
    "dueDateCalculation"             = var.due_date_calculation
    "id"                             = var.id
    "lastModifiedDateTime"           = var.last_modified_date_time
    "@odata.type"                    = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/paymentTerms"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
