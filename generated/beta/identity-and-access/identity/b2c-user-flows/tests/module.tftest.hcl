# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identity/b2cUserFlows"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["apiConnectorConfiguration", "defaultLanguageTag", "identityProviders", "isLanguageCustomizationEnabled", "languages", "userAttributeAssignments", "userFlowIdentityProviders", "userFlowType", "userFlowTypeVersion"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    default_language_tag              = "example"
    is_language_customization_enabled = false
    identity_providers                = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultLanguageTag"]) == jsonencode("example")
    error_message = "defaultLanguageTag must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isLanguageCustomizationEnabled"]) == jsonencode(false)
    error_message = "isLanguageCustomizationEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["identityProviders"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.identityProvider" }])
    error_message = "identityProviders must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_flow_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.user_flow_type]
}
