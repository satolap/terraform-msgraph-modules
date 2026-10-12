# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"   = var.created_date_time
    "displayName"       = var.display_name
    "@odata.type"       = var.odata_type
    "userPrincipalName" = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/instances/${urlencode(var.access_review_instance_id)}/stages/${urlencode(var.access_review_stage_id)}/decisions/${urlencode(var.access_review_instance_decision_item_id)}/instance/contactedReviewers"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
