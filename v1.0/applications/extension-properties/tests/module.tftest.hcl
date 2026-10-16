# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    application_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "applications/test-parent-id/extensionProperties"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["dataType", "deletedDateTime", "isMultiValued", "name", "targetObjects"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    application_id  = "test-parent-id"
    data_type       = "example"
    is_multi_valued = false
    target_objects  = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dataType"]) == jsonencode("example")
    error_message = "dataType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isMultiValued"]) == jsonencode(false)
    error_message = "isMultiValued must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["targetObjects"]) == jsonencode(["example"])
    error_message = "targetObjects must preserve typed values and omit nested nulls."
  }
}
