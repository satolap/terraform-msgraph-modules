# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_policy_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyConfigurations/test-parent-id/definitionValues"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["configurationType", "createdDateTime", "definition", "enabled", "lastModifiedDateTime", "presentationValues"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_policy_configuration_id = "test-parent-id"
    configuration_type            = "policy"
    enabled                       = false
    presentation_values           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["configurationType"]) == jsonencode("policy")
    error_message = "configurationType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enabled"]) == jsonencode(false)
    error_message = "enabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["presentationValues"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.groupPolicyPresentationValue" }])
    error_message = "presentationValues must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_policy_configuration_id = "test-parent-id"
    configuration_type            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.configuration_type]
}
