# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    managed_device_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/managedDevices/test-parent-id/assignmentFilterEvaluationStatusDetails"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["payloadId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    managed_device_id = "test-parent-id"
    payload_id        = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["payloadId"]) == jsonencode("example")
    error_message = "payloadId must preserve typed values and omit nested nulls."
  }
}
