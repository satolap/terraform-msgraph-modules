# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/serviceAnnouncement/messages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionRequiredByDateTime", "attachments", "attachmentsArchive", "body", "category", "details", "endDateTime", "hasAttachments", "isMajorChange", "lastModifiedDateTime", "services", "severity", "startDateTime", "tags", "title", "viewPoint"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action_required_by_date_time = "2026-01-01T00:00:00Z"
    has_attachments              = false
    body                         = { "content" = null }
    attachments                  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionRequiredByDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "actionRequiredByDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasAttachments"]) == jsonencode(false)
    error_message = "hasAttachments must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["body"]) == jsonencode({ "@odata.type" = "#microsoft.graph.itemBody" })
    error_message = "body must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attachments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.serviceAnnouncementAttachment" }])
    error_message = "attachments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
