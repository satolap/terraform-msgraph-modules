# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/settings/workHoursAndLocations/recurrences"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["end", "placeId", "recurrence", "start", "workLocationType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id  = "test-parent-id"
    place_id = "example"
    end      = { "dateTime" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["placeId"]) == jsonencode("example")
    error_message = "placeId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["end"]) == jsonencode({ "@odata.type" = "#microsoft.graph.dateTimeTimeZone" })
    error_message = "end must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id            = "test-parent-id"
    work_location_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.work_location_type]
}
