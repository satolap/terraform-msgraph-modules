# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    product_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/windows/updates/products/test-parent-id/editions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceFamily", "isInService", "servicingPeriods"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    product_id        = "test-parent-id"
    device_family     = "example"
    is_in_service     = false
    servicing_periods = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceFamily"]) == jsonencode("example")
    error_message = "deviceFamily must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isInService"]) == jsonencode(false)
    error_message = "isInService must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["servicingPeriods"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.windowsUpdates.servicingPeriod" }])
    error_message = "servicingPeriods must preserve typed values and omit nested nulls."
  }
}
