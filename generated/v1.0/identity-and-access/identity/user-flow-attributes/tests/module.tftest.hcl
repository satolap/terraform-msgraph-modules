# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identity/userFlowAttributes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["dataType", "description", "displayName", "userFlowAttributeType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    data_type = "string"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dataType"]) == jsonencode("string")
    error_message = "dataType must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    data_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.data_type]
}
