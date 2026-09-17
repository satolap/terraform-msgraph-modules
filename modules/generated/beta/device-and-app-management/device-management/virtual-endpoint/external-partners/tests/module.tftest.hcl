# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/externalPartners"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["agentSetting", "connectionStatus", "enableConnection", "lastSyncDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    connection_status = "notAvailable"
    enable_connection = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectionStatus"]) == jsonencode("notAvailable")
    error_message = "connectionStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enableConnection"]) == jsonencode(false)
    error_message = "enableConnection must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    connection_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.connection_status]
}
