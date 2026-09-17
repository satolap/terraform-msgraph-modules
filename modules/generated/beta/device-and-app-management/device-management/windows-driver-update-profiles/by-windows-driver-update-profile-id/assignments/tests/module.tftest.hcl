# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    windows_driver_update_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsDriverUpdateProfiles/test-parent-id/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["target"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    windows_driver_update_profile_id = "test-parent-id"
    target                           = { "deviceAndAppManagementAssignmentFilterId" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["target"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceAndAppManagementAssignmentTarget" })
    error_message = "target must preserve typed values and omit nested nulls."
  }
}
