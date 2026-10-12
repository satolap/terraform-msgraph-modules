# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyCategories"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["children", "definitionFile", "definitions", "displayName", "ingestionSource", "isRoot", "lastModifiedDateTime", "parent"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name = "example"
    is_root      = false
    children     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isRoot"]) == jsonencode(false)
    error_message = "isRoot must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["children"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.groupPolicyCategory" }])
    error_message = "children must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ingestion_source = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.ingestion_source]
}
