# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "compliantRequirementsCount" = var.compliant_requirements_count
    "createdDateTime"            = var.created_date_time
    "@odata.type"                = var.odata_type
    "score"                      = var.score
    "totalRequirementsCount"     = var.total_requirements_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/partner/securityScore/history"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
