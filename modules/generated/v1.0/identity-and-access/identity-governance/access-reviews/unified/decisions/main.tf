# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "decision"      = var.decision
    "insights"      = (var.insights == null ? null : [for item0 in var.insights : item0 if item0 != null])
    "justification" = var.justification
    "@odata.type"   = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/unified/decisions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
