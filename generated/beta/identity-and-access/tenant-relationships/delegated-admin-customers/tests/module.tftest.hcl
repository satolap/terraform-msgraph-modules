# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/delegatedAdminCustomers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["serviceManagementDetails"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    service_management_details = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["serviceManagementDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.delegatedAdminServiceManagementDetail" }])
    error_message = "serviceManagementDetails must preserve typed values and omit nested nulls."
  }
}
