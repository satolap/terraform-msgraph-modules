# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managementTemplateStepVersions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acceptedFor", "contentMarkdown", "createdByUserId", "createdDateTime", "deployments", "version", "lastActionByUserId", "lastActionDateTime", "name", "templateStep", "versionInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    content_markdown = "example"
    graph_version    = -2147483648
    deployments      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentMarkdown"]) == jsonencode("example")
    error_message = "contentMarkdown must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(-2147483648)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deployments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedTenants.managementTemplateStepDeployment" }])
    error_message = "deployments must preserve typed values and omit nested nulls."
  }
}
