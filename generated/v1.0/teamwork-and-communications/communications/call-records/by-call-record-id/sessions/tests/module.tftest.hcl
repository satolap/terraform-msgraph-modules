# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    call_record_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "communications/callRecords/test-parent-id/sessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["callee", "caller", "endDateTime", "failureInfo", "isTest", "modalities", "startDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_record_id = "test-parent-id"
    end_date_time  = "2026-01-01T00:00:00Z"
    is_test        = false
    modalities     = ["audio"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["endDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "endDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isTest"]) == jsonencode(false)
    error_message = "isTest must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["modalities"]) == jsonencode(["audio"])
    error_message = "modalities must preserve typed values and omit nested nulls."
  }
}
