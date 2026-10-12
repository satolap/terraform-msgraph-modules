# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    notification_message_template_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/notificationMessageTemplates/test-parent-id/localizedNotificationMessages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isDefault", "lastModifiedDateTime", "locale", "messageTemplate", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    notification_message_template_id = "test-parent-id"
    last_modified_date_time          = "2026-01-01T00:00:00Z"
    is_default                       = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastModifiedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastModifiedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefault"]) == jsonencode(false)
    error_message = "isDefault must preserve typed values and omit nested nulls."
  }
}
