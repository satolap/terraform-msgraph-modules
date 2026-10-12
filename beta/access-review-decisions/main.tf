# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessRecommendation" = var.access_recommendation
    "accessReviewId"       = var.access_review_id
    "appliedBy"            = var.applied_by
    "appliedDateTime"      = var.applied_date_time
    "applyResult"          = var.apply_result
    "justification"        = var.justification
    "@odata.type"          = var.odata_type
    "reviewResult"         = var.review_result
    "reviewedBy"           = var.reviewed_by
    "reviewedDateTime"     = var.reviewed_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "accessReviewDecisions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
