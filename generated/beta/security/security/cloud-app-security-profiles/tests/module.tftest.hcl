# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/cloudAppSecurityProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["azureSubscriptionId", "azureTenantId", "createdDateTime", "deploymentPackageUrl", "destinationServiceName", "isSigned", "lastModifiedDateTime", "manifest", "name", "permissionsRequired", "platform", "policyName", "publisher", "riskScore", "tags", "type", "vendorInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    azure_subscription_id = "example"
    is_signed             = false
    tags                  = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureSubscriptionId"]) == jsonencode("example")
    error_message = "azureSubscriptionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isSigned"]) == jsonencode(false)
    error_message = "isSigned must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["tags"]) == jsonencode(["example"])
    error_message = "tags must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    permissions_required = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.permissions_required]
}
