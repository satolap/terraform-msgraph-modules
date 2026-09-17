# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/mobileAppTroubleshootingEvents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalInformation", "appLogCollectionRequests", "applicationId", "correlationId", "deviceId", "eventDateTime", "eventName", "history", "managedDeviceIdentifier", "troubleshootingErrorDetails", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                = "test-parent-id"
    application_id         = "example"
    additional_information = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationId"]) == jsonencode("example")
    error_message = "applicationId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInformation"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValuePair" }])
    error_message = "additionalInformation must preserve typed values and omit nested nulls."
  }
}
