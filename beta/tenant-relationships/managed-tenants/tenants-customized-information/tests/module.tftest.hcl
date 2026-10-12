# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/tenantsCustomizedInformation"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["businessRelationship", "complianceRequirements", "contacts", "managedServicesPlans", "note", "noteLastModifiedDateTime", "partnerRelationshipManagerUserIds", "website"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    business_relationship   = "example"
    compliance_requirements = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["businessRelationship"]) == jsonencode("example")
    error_message = "businessRelationship must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["complianceRequirements"]) == jsonencode(["example"])
    error_message = "complianceRequirements must preserve typed values and omit nested nulls."
  }
}
