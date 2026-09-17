# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "policies/servicePrincipalCreationPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deletedDateTime", "description", "displayName", "excludes", "includes", "isBuiltIn"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    deleted_date_time = "2026-01-01T00:00:00Z"
    is_built_in       = false
    excludes          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deletedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "deletedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isBuiltIn"]) == jsonencode(false)
    error_message = "isBuiltIn must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["excludes"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.servicePrincipalCreationConditionSet" }])
    error_message = "excludes must preserve typed values and omit nested nulls."
  }
}
