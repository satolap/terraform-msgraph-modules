# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/windows/updates/deployments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["audience", "content", "settings", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    settings = { "contentApplicability" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.windowsUpdates.deploymentSettings" })
    error_message = "settings must preserve typed values and omit nested nulls."
  }
}
