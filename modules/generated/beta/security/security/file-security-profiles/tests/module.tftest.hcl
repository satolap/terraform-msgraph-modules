# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/fileSecurityProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activityGroupNames", "azureSubscriptionId", "azureTenantId", "certificateThumbprint", "extensions", "fileType", "firstSeenDateTime", "hashes", "lastSeenDateTime", "malwareStates", "names", "riskScore", "size", "tags", "vendorInformation", "vulnerabilityStates"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    azure_subscription_id = "example"
    size                  = 0
    activity_group_names  = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureSubscriptionId"]) == jsonencode("example")
    error_message = "azureSubscriptionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["size"]) == jsonencode(0)
    error_message = "size must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityGroupNames"]) == jsonencode(["example"])
    error_message = "activityGroupNames must preserve typed values and omit nested nulls."
  }
}
