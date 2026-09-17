# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    delegated_admin_relationship_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/delegatedAdminRelationships/test-parent-id/accessAssignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessContainer", "accessDetails"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    delegated_admin_relationship_id = "test-parent-id"
    access_container                = { "accessContainerId" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessContainer"]) == jsonencode({ "@odata.type" = "#microsoft.graph.delegatedAdminAccessContainer" })
    error_message = "accessContainer must preserve typed values and omit nested nulls."
  }
}
