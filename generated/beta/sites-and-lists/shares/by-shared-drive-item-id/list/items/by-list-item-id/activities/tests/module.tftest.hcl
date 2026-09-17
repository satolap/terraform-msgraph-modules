# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    shared_drive_item_id = "test-parent-id"
    list_item_id         = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "shares/test-parent-id/list/items/test-parent-id/activities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "actor", "driveItem", "listItem", "times"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}
