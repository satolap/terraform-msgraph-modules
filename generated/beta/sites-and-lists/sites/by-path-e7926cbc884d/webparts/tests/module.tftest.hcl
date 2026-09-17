# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id                      = "test-parent-id"
    page_template_id             = "test-parent-id"
    horizontal_section_id        = "test-parent-id"
    horizontal_section_column_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/pageTemplates/test-parent-id/canvasLayout/horizontalSections/test-parent-id/columns/test-parent-id/webparts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}
