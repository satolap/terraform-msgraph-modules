# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    end_user_notification_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/endUserNotifications/test-parent-id/details"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["emailContent", "isDefaultLangauge", "language", "locale", "sentFrom", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    end_user_notification_id = "test-parent-id"
    email_content            = "example"
    is_default_langauge      = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["emailContent"]) == jsonencode("example")
    error_message = "emailContent must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefaultLangauge"]) == jsonencode(false)
    error_message = "isDefaultLangauge must preserve typed values and omit nested nulls."
  }
}
