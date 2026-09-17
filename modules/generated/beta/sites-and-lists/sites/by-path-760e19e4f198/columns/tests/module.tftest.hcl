# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id               = "test-parent-id"
    page_template_id      = "test-parent-id"
    horizontal_section_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/pageTemplates/test-parent-id/canvasLayout/horizontalSections/test-parent-id/columns"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["webparts", "width"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id               = "test-parent-id"
    page_template_id      = "test-parent-id"
    horizontal_section_id = "test-parent-id"
    width                 = -2147483648
    webparts              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["width"]) == jsonencode(-2147483648)
    error_message = "width must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["webparts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.webPart" }])
    error_message = "webparts must preserve typed values and omit nested nulls."
  }
}
