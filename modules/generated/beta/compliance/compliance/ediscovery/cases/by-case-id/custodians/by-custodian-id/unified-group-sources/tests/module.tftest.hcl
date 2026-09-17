# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    case_id      = "test-parent-id"
    custodian_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "compliance/ediscovery/cases/test-parent-id/custodians/test-parent-id/unifiedGroupSources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdBy", "createdDateTime", "displayName", "group", "holdStatus", "includedSources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    case_id           = "test-parent-id"
    custodian_id      = "test-parent-id"
    created_date_time = "2026-01-01T00:00:00Z"
    group             = { "acceptedSenders" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["group"]) == jsonencode({ "@odata.type" = "#microsoft.graph.group" })
    error_message = "group must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    case_id      = "test-parent-id"
    custodian_id = "test-parent-id"
    hold_status  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.hold_status]
}
