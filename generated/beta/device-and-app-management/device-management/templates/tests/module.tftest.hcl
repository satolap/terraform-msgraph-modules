# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/templates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["categories", "description", "displayName", "intentCount", "isDeprecated", "migratableTo", "platformType", "publishedDateTime", "settings", "templateSubtype", "templateType", "versionInfo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description   = "example"
    is_deprecated = false
    intent_count  = -2147483648
    categories    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDeprecated"]) == jsonencode(false)
    error_message = "isDeprecated must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["intentCount"]) == jsonencode(-2147483648)
    error_message = "intentCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categories"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementTemplateSettingCategory" }])
    error_message = "categories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    platform_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platform_type]
}
