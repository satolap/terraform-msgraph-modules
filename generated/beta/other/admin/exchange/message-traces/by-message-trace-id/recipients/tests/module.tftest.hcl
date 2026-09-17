# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    message_trace_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/exchange/messageTraces/test-parent-id/recipients"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deliveryStatus", "events", "recipientEmail"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    message_trace_id = "test-parent-id"
    delivery_status  = "gettingStatus"
    events           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deliveryStatus"]) == jsonencode("gettingStatus")
    error_message = "deliveryStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["events"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.messageEvent" }])
    error_message = "events must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    message_trace_id = "test-parent-id"
    delivery_status  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.delivery_status]
}
