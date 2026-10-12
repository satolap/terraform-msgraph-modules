# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/assignmentFilters"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentFilterManagementType", "createdDateTime", "description", "displayName", "lastModifiedDateTime", "payloads", "platform", "roleScopeTags", "rule"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    assignment_filter_management_type = "devices"
    payloads                          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentFilterManagementType"]) == jsonencode("devices")
    error_message = "assignmentFilterManagementType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["payloads"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.payloadByFilter" }])
    error_message = "payloads must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    assignment_filter_management_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.assignment_filter_management_type]
}
