# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    virtual_event_townhall_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/virtualEvents/townhalls/test-parent-id/registrationConfiguration/questions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "isRequired"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    virtual_event_townhall_id = "test-parent-id"
    display_name              = "example"
    is_required               = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isRequired"]) == jsonencode(false)
    error_message = "isRequired must preserve typed values and omit nested nulls."
  }
}
