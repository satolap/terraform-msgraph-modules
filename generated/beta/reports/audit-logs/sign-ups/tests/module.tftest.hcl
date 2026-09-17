# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "auditLogs/signUps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appDisplayName", "appId", "appliedEventListeners", "correlationId", "createdDateTime", "fraudProtectionDetails", "signUpIdentity", "signUpIdentityProvider", "signUpStage", "status", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_display_name        = "example"
    applied_event_listeners = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDisplayName"]) == jsonencode("example")
    error_message = "appDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliedEventListeners"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appliedAuthenticationEventListener" }])
    error_message = "appliedEventListeners must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    sign_up_stage = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.sign_up_stage]
}
