# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managementTemplates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdByUserId", "createdDateTime", "provider", "version", "informationLinks", "lastActionByUserId", "lastActionDateTime", "managementTemplateCollections", "managementTemplateSteps", "priority", "userImpact"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_by_user_id = "example"
    graph_version      = -2147483648
    information_links  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdByUserId"]) == jsonencode("example")
    error_message = "createdByUserId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(-2147483648)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["informationLinks"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.actionUrl" }])
    error_message = "informationLinks must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    graph_provider = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.graph_provider]
}
