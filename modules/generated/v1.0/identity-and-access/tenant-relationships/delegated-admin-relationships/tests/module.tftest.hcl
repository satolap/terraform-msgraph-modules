# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/delegatedAdminRelationships"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessAssignments", "accessDetails", "autoExtendDuration", "customer", "displayName", "duration", "operations", "requests"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    auto_extend_duration = "example"
    access_details       = { "unifiedRoles" = null }
    access_assignments   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["autoExtendDuration"]) == jsonencode("example")
    error_message = "autoExtendDuration must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessDetails"]) == jsonencode({ "@odata.type" = "#microsoft.graph.delegatedAdminAccessDetails" })
    error_message = "accessDetails must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessAssignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.delegatedAdminAccessAssignment" }])
    error_message = "accessAssignments must preserve typed values and omit nested nulls."
  }
}
