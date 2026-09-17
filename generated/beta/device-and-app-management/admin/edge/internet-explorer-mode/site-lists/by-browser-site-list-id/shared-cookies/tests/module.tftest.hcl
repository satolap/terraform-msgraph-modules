# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    browser_site_list_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/edge/internetExplorerMode/siteLists/test-parent-id/sharedCookies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["comment", "createdDateTime", "deletedDateTime", "displayName", "history", "hostOnly", "hostOrDomain", "lastModifiedBy", "lastModifiedDateTime", "path", "sourceEnvironment", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    browser_site_list_id = "test-parent-id"
    comment              = "example"
    host_only            = false
    history              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["comment"]) == jsonencode("example")
    error_message = "comment must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hostOnly"]) == jsonencode(false)
    error_message = "hostOnly must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["history"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.browserSharedCookieHistory" }])
    error_message = "history must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    browser_site_list_id = "test-parent-id"
    source_environment   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.source_environment]
}
