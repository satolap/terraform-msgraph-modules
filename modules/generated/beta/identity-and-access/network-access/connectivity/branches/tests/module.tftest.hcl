# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/connectivity/branches"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["bandwidthCapacity", "connectivityConfiguration", "connectivityState", "country", "deviceLinks", "forwardingProfiles", "version", "lastModifiedDateTime", "name", "region"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    country            = "example"
    bandwidth_capacity = 0
    device_links       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["country"]) == jsonencode("example")
    error_message = "country must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["bandwidthCapacity"]) == jsonencode(0)
    error_message = "bandwidthCapacity must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceLinks"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.networkaccess.deviceLink" }])
    error_message = "deviceLinks must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    connectivity_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.connectivity_state]
}
