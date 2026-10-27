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

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "security/threatSubmission/emailThreatSubmissionPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
