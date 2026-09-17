# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "insightCreatedDateTime" = var.insight_created_date_time
    "@odata.type"            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/unified/definitions/${urlencode(var.access_review_schedule_definition_id)}/instances/${urlencode(var.access_review_instance_id)}/stages/${urlencode(var.access_review_stage_id)}/decisions/${urlencode(var.access_review_instance_decision_item_id)}/insights"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
