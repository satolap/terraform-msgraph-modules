# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contractType"      = var.contract_type
    "customerId"        = var.customer_id
    "defaultDomainName" = var.default_domain_name
    "deletedDateTime"   = var.deleted_date_time
    "displayName"       = var.display_name
    "@odata.type"       = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "contracts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
