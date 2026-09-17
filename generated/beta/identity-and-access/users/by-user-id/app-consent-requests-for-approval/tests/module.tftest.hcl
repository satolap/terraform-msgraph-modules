# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/appConsentRequestsForApproval"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appDisplayName", "appId", "consentType", "pendingScopes", "userConsentRequests"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id          = "test-parent-id"
    app_display_name = "example"
    pending_scopes   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDisplayName"]) == jsonencode("example")
    error_message = "appDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["pendingScopes"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appConsentRequestScope" }])
    error_message = "pendingScopes must preserve typed values and omit nested nulls."
  }
}
