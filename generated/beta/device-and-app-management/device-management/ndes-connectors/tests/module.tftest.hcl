# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/ndesConnectors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["connectorVersion", "displayName", "enrolledDateTime", "lastConnectionDateTime", "machineName", "roleScopeTagIds", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    connector_version  = "example"
    role_scope_tag_ids = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectorVersion"]) == jsonencode("example")
    error_message = "connectorVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleScopeTagIds"]) == jsonencode(["example"])
    error_message = "roleScopeTagIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
