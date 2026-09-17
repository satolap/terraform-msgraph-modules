# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/resourceAccessProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "creationDateTime", "description", "displayName", "version", "lastModifiedDateTime", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    creation_date_time = "2026-01-01T00:00:00Z"
    graph_version      = -2147483648
    assignments        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["creationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "creationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(-2147483648)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementResourceAccessProfileAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}
