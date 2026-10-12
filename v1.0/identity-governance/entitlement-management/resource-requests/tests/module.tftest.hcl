# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/resourceRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["catalog", "requestType", "resource"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    request_type = "notSpecified"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["requestType"]) == jsonencode("notSpecified")
    error_message = "requestType must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    request_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.request_type]
}
