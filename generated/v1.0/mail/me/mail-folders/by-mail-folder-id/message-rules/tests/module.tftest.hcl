# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    mail_folder_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/mailFolders/test-parent-id/messageRules"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actions", "conditions", "displayName", "exceptions", "isEnabled", "sequence"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    mail_folder_id = "test-parent-id"
    display_name   = "example"
    is_enabled     = false
    sequence       = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sequence"]) == jsonencode(-2147483648)
    error_message = "sequence must preserve typed values and omit nested nulls."
  }
}
