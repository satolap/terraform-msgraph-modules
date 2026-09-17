# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/exchangeConnectors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["connectorServerName", "exchangeAlias", "exchangeConnectorType", "exchangeOrganization", "version", "lastSyncDateTime", "primarySmtpAddress", "serverName", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    connector_server_name = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectorServerName"]) == jsonencode("example")
    error_message = "connectorServerName must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    exchange_connector_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.exchange_connector_type]
}
