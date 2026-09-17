# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    embedded_sim_activation_code_pool_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/embeddedSIMActivationCodePools/test-parent-id/deviceStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "deviceName", "lastSyncDateTime", "modifiedDateTime", "state", "stateDetails", "universalIntegratedCircuitCardIdentifier", "userName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    embedded_sim_activation_code_pool_id = "test-parent-id"
    created_date_time                    = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    embedded_sim_activation_code_pool_id = "test-parent-id"
    state                                = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
