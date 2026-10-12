# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceCustomAttributeShellScripts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "customAttributeName", "customAttributeType", "description", "deviceRunStates", "displayName", "fileName", "groupAssignments", "roleScopeTagIds", "runAsAccount", "runSummary", "scriptContent", "userRunStates"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    custom_attribute_name = "example"
    assignments           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customAttributeName"]) == jsonencode("example")
    error_message = "customAttributeName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementScriptAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    custom_attribute_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.custom_attribute_type]
}
