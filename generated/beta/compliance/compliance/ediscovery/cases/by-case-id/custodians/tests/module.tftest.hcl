# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "compliance/ediscovery/cases/test-parent-id/custodians"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acknowledgedDateTime", "applyHoldToSources", "createdDateTime", "displayName", "email", "holdStatus", "lastIndexOperation", "lastModifiedDateTime", "releasedDateTime", "siteSources", "status", "unifiedGroupSources", "userSources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    case_id                = "test-parent-id"
    acknowledged_date_time = "2026-01-01T00:00:00Z"
    apply_hold_to_sources  = false
    site_sources           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acknowledgedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "acknowledgedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applyHoldToSources"]) == jsonencode(false)
    error_message = "applyHoldToSources must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["siteSources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.ediscovery.siteSource" }])
    error_message = "siteSources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    case_id     = "test-parent-id"
    hold_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.hold_status]
}
