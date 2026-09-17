# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/privilegeManagementElevations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificatePayload", "companyName", "deviceId", "deviceName", "elevationType", "eventDateTime", "fileDescription", "filePath", "fileVersion", "hash", "internalName", "justification", "parentProcessName", "policyId", "policyName", "processType", "productName", "result", "ruleId", "systemInitiatedElevation", "upn", "userType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    certificate_payload        = "example"
    system_initiated_elevation = false
    result                     = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificatePayload"]) == jsonencode("example")
    error_message = "certificatePayload must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["systemInitiatedElevation"]) == jsonencode(false)
    error_message = "systemInitiatedElevation must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["result"]) == jsonencode(-2147483648)
    error_message = "result must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    elevation_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.elevation_type]
}
