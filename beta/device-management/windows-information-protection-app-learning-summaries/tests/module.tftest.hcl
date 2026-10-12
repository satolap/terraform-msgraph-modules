# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsInformationProtectionAppLearningSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applicationName", "applicationType", "deviceCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    application_name = "example"
    device_count     = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationName"]) == jsonencode("example")
    error_message = "applicationName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceCount"]) == jsonencode(-2147483648)
    error_message = "deviceCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    application_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.application_type]
}
