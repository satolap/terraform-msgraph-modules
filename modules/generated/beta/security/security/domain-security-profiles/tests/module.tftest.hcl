# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/domainSecurityProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activityGroupNames", "azureSubscriptionId", "azureTenantId", "countHits", "countInOrg", "domainCategories", "domainRegisteredDateTime", "firstSeenDateTime", "lastSeenDateTime", "name", "registrant", "riskScore", "tags", "vendorInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    azure_subscription_id = "example"
    count_hits            = -2147483648
    activity_group_names  = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureSubscriptionId"]) == jsonencode("example")
    error_message = "azureSubscriptionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["countHits"]) == jsonencode(-2147483648)
    error_message = "countHits must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityGroupNames"]) == jsonencode(["example"])
    error_message = "activityGroupNames must preserve typed values and omit nested nulls."
  }
}
