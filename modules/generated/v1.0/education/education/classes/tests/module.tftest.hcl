# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "education/classes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentCategories", "assignmentDefaults", "assignmentSettings", "assignments", "classCode", "course", "createdBy", "description", "displayName", "externalId", "externalName", "externalSource", "externalSourceDetail", "grade", "group", "mailNickname", "members", "modules", "schools", "teachers", "term"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    class_code            = "example"
    assignment_categories = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["classCode"]) == jsonencode("example")
    error_message = "classCode must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentCategories"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.educationCategory" }])
    error_message = "assignmentCategories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    external_source = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.external_source]
}
