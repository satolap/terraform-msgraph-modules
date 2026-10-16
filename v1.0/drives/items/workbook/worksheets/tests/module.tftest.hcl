# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    drive_id      = "test-parent-id"
    drive_item_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "drives/test-parent-id/items/test-parent-id/workbook/worksheets"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["name", "pivotTables", "position", "visibility"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    drive_id      = "test-parent-id"
    drive_item_id = "test-parent-id"
    name          = "example"
    position      = -2147483648
    pivot_tables  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["name"]) == jsonencode("example")
    error_message = "name must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["position"]) == jsonencode(-2147483648)
    error_message = "position must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["pivotTables"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.workbookPivotTable" }])
    error_message = "pivotTables must preserve typed values and omit nested nulls."
  }
}
