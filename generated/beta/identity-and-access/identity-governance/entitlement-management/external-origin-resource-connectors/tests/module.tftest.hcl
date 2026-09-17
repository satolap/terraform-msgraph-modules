# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/externalOriginResourceConnectors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["connectionInfo", "connectorType", "createdBy", "createdDateTime", "description", "displayName", "modifiedBy", "modifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    connector_type  = "sapIag"
    connection_info = { "url" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectorType"]) == jsonencode("sapIag")
    error_message = "connectorType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectionInfo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.connectionInfo" })
    error_message = "connectionInfo must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    connector_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.connector_type]
}
