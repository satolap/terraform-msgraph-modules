# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    update_policy_id = "test-parent-id"
    odata_type       = "#microsoft.graph.windowsUpdates.azureADDevice"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/windows/updates/updatePolicies/test-parent-id/audience/members"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    update_policy_id = "test-parent-id"
    odata_type       = "#microsoft.graph.windowsUpdates.azureADDevice"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.windowsUpdates.azureADDevice")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    update_policy_id = "test-parent-id"
    odata_type       = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
