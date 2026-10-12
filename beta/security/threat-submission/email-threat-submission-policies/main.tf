# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "customizedNotificationSenderEmailAddress" = var.customized_notification_sender_email_address
    "customizedReportRecipientEmailAddress"    = var.customized_report_recipient_email_address
    "isAlwaysReportEnabledForUsers"            = var.is_always_report_enabled_for_users
    "isAskMeEnabledForUsers"                   = var.is_ask_me_enabled_for_users
    "isCustomizedMessageEnabled"               = var.is_customized_message_enabled
    "isCustomizedMessageEnabledForPhishing"    = var.is_customized_message_enabled_for_phishing
    "isCustomizedNotificationSenderEnabled"    = var.is_customized_notification_sender_enabled
    "isNeverReportEnabledForUsers"             = var.is_never_report_enabled_for_users
    "isOrganizationBrandingEnabled"            = var.is_organization_branding_enabled
    "isReportFromQuarantineEnabled"            = var.is_report_from_quarantine_enabled
    "isReportToCustomizedEmailAddressEnabled"  = var.is_report_to_customized_email_address_enabled
    "isReportToMicrosoftEnabled"               = var.is_report_to_microsoft_enabled
    "isReviewEmailNotificationEnabled"         = var.is_review_email_notification_enabled
    "@odata.type"                              = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatSubmission/emailThreatSubmissionPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
