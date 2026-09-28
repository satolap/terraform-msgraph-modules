# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    remote_network_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/connectivity/remoteNetworks/test-parent-id/forwardingProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["associations", "description", "version", "isCustomProfile", "lastModifiedDateTime", "name", "policies", "priority", "servicePrincipal", "state", "trafficForwardingType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    remote_network_id = "test-parent-id"
    description       = "example"
    is_custom_profile = false
    priority          = -2147483648
    associations      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCustomProfile"]) == jsonencode(false)
    error_message = "isCustomProfile must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priority"]) == jsonencode(-2147483648)
    error_message = "priority must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["associations"]) == jsonencode([{}])
    error_message = "associations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    remote_network_id = "test-parent-id"
    state             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
