# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_compliance_script_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceComplianceScripts/test-parent-id/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["runRemediationScript", "runSchedule", "target"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_compliance_script_id = "test-parent-id"
    run_remediation_script      = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["runRemediationScript"]) == jsonencode(false)
    error_message = "runRemediationScript must preserve typed values and omit nested nulls."
  }
}
