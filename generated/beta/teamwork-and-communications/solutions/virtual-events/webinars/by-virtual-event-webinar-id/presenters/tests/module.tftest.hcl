# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    virtual_event_webinar_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/virtualEvents/webinars/test-parent-id/presenters"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["email", "identity", "presenterDetails", "sessions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    virtual_event_webinar_id = "test-parent-id"
    email                    = "example"
    sessions                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["email"]) == jsonencode("example")
    error_message = "email must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sessions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.virtualEventSession" }])
    error_message = "sessions must preserve typed values and omit nested nulls."
  }
}
