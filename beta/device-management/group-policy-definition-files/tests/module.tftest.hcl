# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyDefinitionFiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["definitions", "description", "displayName", "fileName", "languageCodes", "lastModifiedDateTime", "policyType", "revision", "targetNamespace", "targetPrefix"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description = "example"
    definitions = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["definitions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.groupPolicyDefinition" }])
    error_message = "definitions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    policy_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.policy_type]
}
