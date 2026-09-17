# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managementTemplateSteps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acceptedVersion", "category", "createdByUserId", "createdDateTime", "description", "displayName", "informationLinks", "lastActionByUserId", "lastActionDateTime", "managementTemplate", "portalLink", "priority", "userImpact", "versions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_by_user_id = "example"
    priority           = -2147483648
    information_links  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdByUserId"]) == jsonencode("example")
    error_message = "createdByUserId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priority"]) == jsonencode(-2147483648)
    error_message = "priority must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["informationLinks"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.actionUrl" }])
    error_message = "informationLinks must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
