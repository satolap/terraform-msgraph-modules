# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/threads"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["ccRecipients", "hasAttachments", "isLocked", "lastDeliveredDateTime", "posts", "preview", "toRecipients", "topic", "uniqueSenders"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id                 = "test-parent-id"
    last_delivered_date_time = "2026-01-01T00:00:00Z"
    has_attachments          = false
    cc_recipients            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastDeliveredDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastDeliveredDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasAttachments"]) == jsonencode(false)
    error_message = "hasAttachments must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["ccRecipients"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.recipient" }])
    error_message = "ccRecipients must preserve typed values and omit nested nulls."
  }
}
