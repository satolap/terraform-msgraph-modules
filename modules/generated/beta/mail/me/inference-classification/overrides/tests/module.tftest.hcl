# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/inferenceClassification/overrides"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["classifyAs", "senderEmailAddress"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    classify_as = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.classify_as]
}
