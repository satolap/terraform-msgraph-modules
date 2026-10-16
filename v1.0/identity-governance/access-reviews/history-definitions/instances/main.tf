# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "downloadUri"                      = var.download_uri
    "expirationDateTime"               = var.expiration_date_time
    "fulfilledDateTime"                = var.fulfilled_date_time
    "@odata.type"                      = var.odata_type
    "reviewHistoryPeriodEndDateTime"   = var.review_history_period_end_date_time
    "reviewHistoryPeriodStartDateTime" = var.review_history_period_start_date_time
    "runDateTime"                      = var.run_date_time
    "status"                           = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/accessReviews/historyDefinitions/${urlencode(var.access_review_history_definition_id)}/instances"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
