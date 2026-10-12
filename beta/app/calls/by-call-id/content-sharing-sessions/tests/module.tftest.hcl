# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    call_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "app/calls/test-parent-id/contentSharingSessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["pngOfCurrentSlide", "presenterParticipantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_id              = "test-parent-id"
    png_of_current_slide = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["pngOfCurrentSlide"]) == jsonencode("example")
    error_message = "pngOfCurrentSlide must preserve typed values and omit nested nulls."
  }
}
