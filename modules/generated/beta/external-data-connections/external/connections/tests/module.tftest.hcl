# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "external/connections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activitySettings", "complianceSettings", "configuration", "connectorId", "contentCategory", "description", "enabledContentExperiences", "groups", "ingestedItemsCount", "items", "name", "operations", "quota", "schema", "searchSettings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    connector_id         = "example"
    ingested_items_count = 0
    activity_settings    = { "urlToItemResolvers" = null }
    groups               = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectorId"]) == jsonencode("example")
    error_message = "connectorId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["ingestedItemsCount"]) == jsonencode(0)
    error_message = "ingestedItemsCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activitySettings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.externalConnectors.activitySettings" })
    error_message = "activitySettings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["groups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.externalConnectors.externalGroup" }])
    error_message = "groups must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    content_category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.content_category]
}

run "flags_enum_combination" {
  command = plan

  variables {
    enabled_content_experiences = "search, Compliance"
  }

  assert {
    condition     = msgraph_resource.this.body["enabledContentExperiences"] == "search, Compliance"
    error_message = "enabledContentExperiences must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    enabled_content_experiences = "search,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.enabled_content_experiences]
}
