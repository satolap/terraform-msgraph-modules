# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    custom_security_attribute_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "directory/customSecurityAttributeDefinitions/test-parent-id/allowedValues"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isActive"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    custom_security_attribute_definition_id = "test-parent-id"
    is_active                               = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isActive"]) == jsonencode(false)
    error_message = "isActive must preserve typed values and omit nested nulls."
  }
}
