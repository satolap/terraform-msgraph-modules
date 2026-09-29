# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/notes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attachments", "body", "categories", "createdDateTime", "extensions", "lastModifiedDateTime", "multiValueExtendedProperties", "singleValueExtendedProperties", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    created_date_time = "2026-01-01T00:00:00Z"
    body              = { "content" = null }
    attachments       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["body"]) == jsonencode({ "@odata.type" = "#microsoft.graph.itemBody" })
    error_message = "body must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attachments"]) == jsonencode([{}])
    error_message = "attachments must preserve typed values and omit nested nulls."
  }
}
