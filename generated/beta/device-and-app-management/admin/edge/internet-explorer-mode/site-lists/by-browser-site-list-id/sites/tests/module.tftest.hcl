# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    browser_site_list_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/edge/internetExplorerMode/siteLists/test-parent-id/sites"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowRedirect", "comment", "compatibilityMode", "createdDateTime", "deletedDateTime", "history", "lastModifiedBy", "lastModifiedDateTime", "mergeType", "status", "targetEnvironment", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    browser_site_list_id = "test-parent-id"
    comment              = "example"
    allow_redirect       = false
    history              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["comment"]) == jsonencode("example")
    error_message = "comment must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowRedirect"]) == jsonencode(false)
    error_message = "allowRedirect must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["history"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.browserSiteHistory" }])
    error_message = "history must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    browser_site_list_id = "test-parent-id"
    compatibility_mode   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.compatibility_mode]
}
