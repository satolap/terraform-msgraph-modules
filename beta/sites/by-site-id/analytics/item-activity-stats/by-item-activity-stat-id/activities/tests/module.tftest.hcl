# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id               = "test-parent-id"
    item_activity_stat_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/analytics/itemActivityStats/test-parent-id/activities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["access", "activityDateTime", "driveItem"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id               = "test-parent-id"
    item_activity_stat_id = "test-parent-id"
    activity_date_time    = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "activityDateTime must preserve typed values and omit nested nulls."
  }
}
