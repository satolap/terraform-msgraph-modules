# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "account"                = var.account
    "balancingAccountId"     = var.balancing_account_id
    "balancingAccountNumber" = var.balancing_account_number
    "code"                   = var.code
    "customerPayments"       = (var.customer_payments == null ? null : [for item0 in var.customer_payments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "amount" = item0["amount"], "appliesToInvoiceId" = item0["appliesToInvoiceId"], "appliesToInvoiceNumber" = item0["appliesToInvoiceNumber"], "comment" = item0["comment"], "contactId" = item0["contactId"], "customer" = item0["customer"], "customerId" = item0["customerId"], "customerNumber" = item0["customerNumber"], "description" = item0["description"], "documentNumber" = item0["documentNumber"], "externalDocumentNumber" = item0["externalDocumentNumber"], "id" = item0["id"], "journalDisplayName" = item0["journalDisplayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "lineNumber" = item0["lineNumber"], "postingDate" = item0["postingDate"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"            = var.display_name
    "id"                     = var.id
    "lastModifiedDateTime"   = var.last_modified_date_time
    "@odata.type"            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/customerPaymentJournals"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
