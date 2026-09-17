# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/accessReviews/definitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalNotificationRecipients", "descriptionForAdmins", "descriptionForReviewers", "displayName", "fallbackReviewers", "instanceEnumerationScope", "instances", "reviewers", "scope", "settings", "stageSettings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description_for_admins             = "example"
    additional_notification_recipients = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["descriptionForAdmins"]) == jsonencode("example")
    error_message = "descriptionForAdmins must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalNotificationRecipients"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.accessReviewNotificationRecipientItem" }])
    error_message = "additionalNotificationRecipients must preserve typed values and omit nested nulls."
  }
}
