# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/hostSecurityProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["azureSubscriptionId", "azureTenantId", "firstSeenDateTime", "fqdn", "isAzureAdJoined", "isAzureAdRegistered", "isHybridAzureDomainJoined", "lastSeenDateTime", "logonUsers", "netBiosName", "networkInterfaces", "os", "osVersion", "parentHost", "relatedHostIds", "riskScore", "tags", "vendorInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    azure_subscription_id = "example"
    is_azure_ad_joined    = false
    logon_users           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureSubscriptionId"]) == jsonencode("example")
    error_message = "azureSubscriptionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAzureAdJoined"]) == jsonencode(false)
    error_message = "isAzureAdJoined must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["logonUsers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.logonUser" }])
    error_message = "logonUsers must preserve typed values and omit nested nulls."
  }
}
