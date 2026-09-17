# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["category", "categoryPath", "classType", "definitionFile", "displayName", "explainText", "version", "groupPolicyCategoryId", "hasRelatedDefinitions", "lastModifiedDateTime", "minDeviceCspVersion", "minUserCspVersion", "nextVersionDefinition", "policyType", "presentations", "previousVersionDefinition", "supportedOn"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    category_path           = "example"
    has_related_definitions = false
    presentations           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categoryPath"]) == jsonencode("example")
    error_message = "categoryPath must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasRelatedDefinitions"]) == jsonencode(false)
    error_message = "hasRelatedDefinitions must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["presentations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.groupPolicyPresentation" }])
    error_message = "presentations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    class_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.class_type]
}
