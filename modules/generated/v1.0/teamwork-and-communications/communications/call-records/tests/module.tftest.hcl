# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "communications/callRecords"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["endDateTime", "version", "joinWebUrl", "lastModifiedDateTime", "modalities", "organizer", "organizer_v2", "participants", "participants_v2", "startDateTime", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    end_date_time = "2026-01-01T00:00:00Z"
    graph_version = 0
    modalities    = ["audio"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["endDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "endDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(0)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["modalities"]) == jsonencode(["audio"])
    error_message = "modalities must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.type]
}
