# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/servicePlans"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["provisioningType", "supportedSolution"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    supported_solution = "windows365"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["supportedSolution"]) == jsonencode("windows365")
    error_message = "supportedSolution must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    provisioning_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.provisioning_type]
}
