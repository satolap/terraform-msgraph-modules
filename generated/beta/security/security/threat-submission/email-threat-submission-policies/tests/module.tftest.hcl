# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatSubmission/emailThreatSubmissionPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["customizedNotificationSenderEmailAddress", "customizedReportRecipientEmailAddress", "isAlwaysReportEnabledForUsers", "isAskMeEnabledForUsers", "isCustomizedMessageEnabled", "isCustomizedMessageEnabledForPhishing", "isCustomizedNotificationSenderEnabled", "isNeverReportEnabledForUsers", "isOrganizationBrandingEnabled", "isReportFromQuarantineEnabled", "isReportToCustomizedEmailAddressEnabled", "isReportToMicrosoftEnabled", "isReviewEmailNotificationEnabled"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    customized_notification_sender_email_address = "example"
    is_always_report_enabled_for_users           = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customizedNotificationSenderEmailAddress"]) == jsonencode("example")
    error_message = "customizedNotificationSenderEmailAddress must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAlwaysReportEnabledForUsers"]) == jsonencode(false)
    error_message = "isAlwaysReportEnabledForUsers must preserve typed values and omit nested nulls."
  }
}
