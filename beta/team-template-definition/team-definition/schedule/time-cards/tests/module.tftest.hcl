# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamTemplateDefinition/test-parent-id/teamDefinition/schedule/timeCards"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["breaks", "clockInEvent", "clockOutEvent", "confirmedBy", "createdBy", "notes", "originalEntry", "state", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    confirmed_by                = "none"
    clock_in_event              = { "atApprovedLocation" = null }
    breaks                      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["confirmedBy"]) == jsonencode("none")
    error_message = "confirmedBy must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clockInEvent"]) == jsonencode({ "@odata.type" = "#microsoft.graph.timeCardEvent" })
    error_message = "clockInEvent must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["breaks"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.timeCardBreak" }])
    error_message = "breaks must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    confirmed_by                = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.confirmed_by]
}

run "flags_enum_combination" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    confirmed_by                = "none, User"
  }

  assert {
    condition     = msgraph_resource.this.body["confirmedBy"] == "none, User"
    error_message = "confirmedBy must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    confirmed_by                = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.confirmed_by]
}
