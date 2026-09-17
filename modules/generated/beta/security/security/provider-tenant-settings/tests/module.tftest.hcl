# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/providerTenantSettings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["azureTenantId", "enabled", "provider", "lastModifiedDateTime", "vendor"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    azure_tenant_id = "example"
    enabled         = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureTenantId"]) == jsonencode("example")
    error_message = "azureTenantId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enabled"]) == jsonencode(false)
    error_message = "enabled must preserve typed values and omit nested nulls."
  }
}
