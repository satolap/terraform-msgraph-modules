# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/onPremisesConnections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["adDomainName", "adDomainPassword", "adDomainUsername", "alternateResourceUrl", "connectionType", "displayName", "healthCheckStatus", "managedBy", "organizationalUnit", "resourceGroupId", "scopeIds", "subnetId", "subscriptionId", "type", "virtualNetworkId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ad_domain_name = "example"
    scope_ids      = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["adDomainName"]) == jsonencode("example")
    error_message = "adDomainName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["scopeIds"]) == jsonencode(["example"])
    error_message = "scopeIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    connection_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.connection_type]
}
