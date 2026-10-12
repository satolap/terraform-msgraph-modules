# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    application_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "applications/test-parent-id/synchronization/templates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applicationId", "default", "description", "discoverable", "factoryTag", "metadata", "schema"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    application_id   = "test-parent-id"
    application_id_2 = "00000000-0000-0000-0000-000000000001"
    default          = false
    metadata         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationId"]) == jsonencode("00000000-0000-0000-0000-000000000001")
    error_message = "applicationId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["default"]) == jsonencode(false)
    error_message = "default must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["metadata"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.synchronizationMetadataEntry" }])
    error_message = "metadata must preserve typed values and omit nested nulls."
  }
}
