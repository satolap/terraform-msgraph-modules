# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/secureScoreControlProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionType", "actionUrl", "azureTenantId", "complianceInformation", "controlCategory", "controlStateUpdates", "deprecated", "implementationCost", "lastModifiedDateTime", "maxScore", "rank", "remediation", "remediationImpact", "service", "threats", "tier", "title", "userImpact", "vendorInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action_type            = "example"
    deprecated             = false
    rank                   = -2147483648
    compliance_information = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionType"]) == jsonencode("example")
    error_message = "actionType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deprecated"]) == jsonencode(false)
    error_message = "deprecated must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["rank"]) == jsonencode(-2147483648)
    error_message = "rank must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["complianceInformation"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.complianceInformation" }])
    error_message = "complianceInformation must preserve typed values and omit nested nulls."
  }
}
