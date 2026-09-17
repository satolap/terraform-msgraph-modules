# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionUrl"        = var.action_url
    "complianceStatus" = var.compliance_status
    "helpUrl"          = var.help_url
    "maxScore"         = var.max_score
    "@odata.type"      = var.odata_type
    "requirementType"  = var.requirement_type
    "score"            = var.score
    "state"            = var.state
    "updatedDateTime"  = var.updated_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/partner/securityScore/requirements"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
