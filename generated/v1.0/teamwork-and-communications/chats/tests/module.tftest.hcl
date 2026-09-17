# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "chats"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["chatType", "installedApps", "lastMessagePreview", "members", "messages", "migrationMode", "originalCreatedDateTime", "permissionGrants", "pinnedMessages", "tabs", "targetedMessages", "topic", "viewpoint"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    chat_type      = "oneOnOne"
    installed_apps = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["chatType"]) == jsonencode("oneOnOne")
    error_message = "chatType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["installedApps"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.teamsAppInstallation" }])
    error_message = "installedApps must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    chat_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.chat_type]
}
