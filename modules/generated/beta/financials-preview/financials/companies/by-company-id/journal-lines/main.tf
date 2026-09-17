# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "account"                = var.account
    "accountId"              = var.account_id
    "accountNumber"          = var.account_number
    "amount"                 = var.amount
    "comment"                = var.comment
    "description"            = var.description
    "documentNumber"         = var.document_number
    "externalDocumentNumber" = var.external_document_number
    "id"                     = var.id
    "journalDisplayName"     = var.journal_display_name
    "lastModifiedDateTime"   = var.last_modified_date_time
    "lineNumber"             = var.line_number
    "@odata.type"            = var.odata_type
    "postingDate"            = var.posting_date
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/journalLines"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
