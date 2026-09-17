# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/supportedRegions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["regionGroup", "supportedSolution"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    region_group = "default"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["regionGroup"]) == jsonencode("default")
    error_message = "regionGroup must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    region_group = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.region_group]
}
