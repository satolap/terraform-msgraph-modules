# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/tenantTags"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["tenants"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    tenants = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["tenants"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedTenants.tenantInfo" }])
    error_message = "tenants must preserve typed values and omit nested nulls."
  }
}
