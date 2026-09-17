# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyUploadedDefinitionFiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "defaultLanguageCode", "definitions", "description", "displayName", "fileName", "groupPolicyOperations", "groupPolicyUploadedLanguageFiles", "languageCodes", "lastModifiedDateTime", "policyType", "revision", "status", "targetNamespace", "targetPrefix", "uploadDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    content     = "example"
    definitions = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
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
