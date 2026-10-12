# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "captchaFailureCount"          = var.captcha_failure_count
    "captchaNotTriggeredUserCount" = var.captcha_not_triggered_user_count
    "captchaShownUserCount"        = var.captcha_shown_user_count
    "captchaSuccessCount"          = var.captcha_success_count
    "factDate"                     = var.fact_date
    "@odata.type"                  = var.odata_type
    "telecomBlockedUserCount"      = var.telecom_blocked_user_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/userInsights/daily/mfaTelecomFraud"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
