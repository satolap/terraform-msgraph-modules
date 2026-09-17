# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "decision"      = var.decision
    "insights"      = (var.insights == null ? null : [for item0 in var.insights : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "insightCreatedDateTime" = item0["insightCreatedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "justification" = var.justification
    "@odata.type"   = var.odata_type
    "permission"    = var.permission
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/unified/definitions/${urlencode(var.access_review_schedule_definition_id)}/instances/${urlencode(var.access_review_instance_id)}/stages/${urlencode(var.access_review_stage_id)}/decisions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
