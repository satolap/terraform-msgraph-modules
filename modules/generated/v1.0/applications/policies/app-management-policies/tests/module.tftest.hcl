# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "policies/appManagementPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appliesTo", "deletedDateTime", "description", "displayName", "isEnabled", "restrictions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    deleted_date_time = "2026-01-01T00:00:00Z"
    is_enabled        = false
    applies_to        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deletedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "deletedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliesTo"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.directoryObject" }])
    error_message = "appliesTo must preserve typed values and omit nested nulls."
  }
}
