# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.emailAuthenticationMethodConfiguration"
  }

  assert {
    condition     = msgraph_resource.this.url == "authenticationMethodsPolicy/authenticationMethodConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["excludeTargets", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type      = "#microsoft.graph.emailAuthenticationMethodConfiguration"
    state           = "enabled"
    exclude_targets = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.emailAuthenticationMethodConfiguration")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["state"]) == jsonencode("enabled")
    error_message = "state must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["excludeTargets"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.excludeTarget" }])
    error_message = "excludeTargets must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
