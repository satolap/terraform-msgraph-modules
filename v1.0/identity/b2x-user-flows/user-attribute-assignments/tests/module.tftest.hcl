# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    b2x_identity_user_flow_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identity/b2xUserFlows/test-parent-id/userAttributeAssignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "isOptional", "requiresVerification", "userAttribute", "userAttributeValues", "userInputType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    b2x_identity_user_flow_id = "test-parent-id"
    display_name              = "example"
    is_optional               = false
    user_attribute_values     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isOptional"]) == jsonencode(false)
    error_message = "isOptional must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userAttributeValues"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.userAttributeValuesItem" }])
    error_message = "userAttributeValues must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    b2x_identity_user_flow_id = "test-parent-id"
    user_input_type           = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.user_input_type]
}
