# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/notes"
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
    created_date_time = "2026-01-01T00:00:00Z"
    attachments       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attachments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attachment" }])
    error_message = "attachments must preserve typed values and omit nested nulls."
  }
}
