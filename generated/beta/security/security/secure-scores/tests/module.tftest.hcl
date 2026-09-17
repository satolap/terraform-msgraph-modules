# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/secureScores"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activeUserCount", "averageComparativeScores", "azureTenantId", "controlScores", "createdDateTime", "currentScore", "enabledServices", "licensedUserCount", "maxScore", "vendorInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    azure_tenant_id            = "example"
    active_user_count          = -2147483648
    average_comparative_scores = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureTenantId"]) == jsonencode("example")
    error_message = "azureTenantId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeUserCount"]) == jsonencode(-2147483648)
    error_message = "activeUserCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["averageComparativeScores"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.averageComparativeScore" }])
    error_message = "averageComparativeScores must preserve typed values and omit nested nulls."
  }
}
