# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    call_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "communications/calls/test-parent-id/audioRoutingGroups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["receivers", "routingMode", "sources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_id      = "test-parent-id"
    routing_mode = "oneToOne"
    receivers    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["routingMode"]) == jsonencode("oneToOne")
    error_message = "routingMode must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["receivers"]) == jsonencode(["example"])
    error_message = "receivers must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    call_id      = "test-parent-id"
    routing_mode = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.routing_mode]
}
