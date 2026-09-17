# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "account"                = var.account
    "balancingAccountId"     = var.balancing_account_id
    "balancingAccountNumber" = var.balancing_account_number
    "code"                   = var.code
    "displayName"            = var.display_name
    "id"                     = var.id
    "journalLines"           = (var.journal_lines == null ? null : [for item0 in var.journal_lines : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "account" = item0["account"], "accountId" = item0["accountId"], "accountNumber" = item0["accountNumber"], "amount" = item0["amount"], "comment" = item0["comment"], "description" = item0["description"], "documentNumber" = item0["documentNumber"], "externalDocumentNumber" = item0["externalDocumentNumber"], "id" = item0["id"], "journalDisplayName" = item0["journalDisplayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "lineNumber" = item0["lineNumber"], "postingDate" = item0["postingDate"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime"   = var.last_modified_date_time
    "@odata.type"            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/journals"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
