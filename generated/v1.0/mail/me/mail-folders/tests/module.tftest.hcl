# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/mailFolders"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["childFolderCount", "childFolders", "displayName", "isHidden", "messageRules", "messages", "parentFolderId", "totalItemCount", "unreadItemCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name       = "example"
    is_hidden          = false
    child_folder_count = -2147483648
    child_folders      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isHidden"]) == jsonencode(false)
    error_message = "isHidden must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["childFolderCount"]) == jsonencode(-2147483648)
    error_message = "childFolderCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["childFolders"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.mailFolder" }])
    error_message = "childFolders must preserve typed values and omit nested nulls."
  }
}
