# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    drive_id     = "test-parent-id"
    list_item_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "drives/test-parent-id/list/items/test-parent-id/documentSetVersions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["comment", "createdBy", "createdDateTime", "fields", "items", "shouldCaptureMinorVersion"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    drive_id                     = "test-parent-id"
    list_item_id                 = "test-parent-id"
    comment                      = "example"
    should_capture_minor_version = false
    items                        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["comment"]) == jsonencode("example")
    error_message = "comment must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["shouldCaptureMinorVersion"]) == jsonencode(false)
    error_message = "shouldCaptureMinorVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["items"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.documentSetVersionItem" }])
    error_message = "items must preserve typed values and omit nested nulls."
  }
}
