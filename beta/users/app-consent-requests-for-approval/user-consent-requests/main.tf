# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "approval"          = var.approval
    "approvalId"        = var.approval_id
    "completedDateTime" = var.completed_date_time
    "createdBy"         = var.created_by
    "createdDateTime"   = var.created_date_time
    "customData"        = var.custom_data
    "@odata.type"       = var.odata_type
    "reason"            = var.reason
    "status"            = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/appConsentRequestsForApproval/${urlencode(var.app_consent_request_id)}/userConsentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
