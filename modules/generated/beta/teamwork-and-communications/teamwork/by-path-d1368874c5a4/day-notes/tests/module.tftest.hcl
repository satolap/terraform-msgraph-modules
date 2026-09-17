# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_id            = "test-parent-id"
    team_template_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamwork/teamTemplates/test-parent-id/definitions/test-parent-id/teamDefinition/schedule/dayNotes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdBy", "dayNoteDate", "draftDayNote", "sharedDayNote"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_id            = "test-parent-id"
    team_template_definition_id = "test-parent-id"
    day_note_date               = "2026-01-01"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dayNoteDate"]) == jsonencode("2026-01-01")
    error_message = "dayNoteDate must preserve typed values and omit nested nulls."
  }
}
