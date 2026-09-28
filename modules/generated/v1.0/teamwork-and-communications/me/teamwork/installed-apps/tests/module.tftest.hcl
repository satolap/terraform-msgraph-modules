# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/teamwork/installedApps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["chat", "consentedPermissionSet", "teamsApp", "teamsAppDefinition"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    consented_permission_set = { "resourceSpecificPermissions" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["consentedPermissionSet"]) == jsonencode({ "@odata.type" = "#microsoft.graph.teamsAppPermissionSet" })
    error_message = "consentedPermissionSet must preserve typed values and omit nested nulls."
  }
}
