# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    drive_id                 = "test-parent-id"
    drive_item_id            = "test-parent-id"
    workbook_worksheet_id    = "test-parent-id"
    workbook_chart_id        = "test-parent-id"
    workbook_chart_series_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "drives/test-parent-id/items/test-parent-id/workbook/worksheets/test-parent-id/charts/test-parent-id/series/test-parent-id/points"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}
