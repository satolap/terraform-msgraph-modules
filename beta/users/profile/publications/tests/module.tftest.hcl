# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/profile/publications"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedAudiences", "createdBy", "createdDateTime", "description", "displayName", "source", "inference", "isSearchable", "lastModifiedBy", "lastModifiedDateTime", "publishedDate", "publisher", "sources", "thumbnailUrl", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    allowed_audiences = "me"
    is_searchable     = false
    graph_source      = { "type" = null }
    sources           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedAudiences"]) == jsonencode("me")
    error_message = "allowedAudiences must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isSearchable"]) == jsonencode(false)
    error_message = "isSearchable must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["source"]) == jsonencode({ "@odata.type" = "#microsoft.graph.personDataSources" })
    error_message = "source must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.profileSourceAnnotation" }])
    error_message = "sources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    allowed_audiences = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_audiences]
}

run "flags_enum_combination" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    allowed_audiences = "me, Family"
  }

  assert {
    condition     = msgraph_resource.this.body["allowedAudiences"] == "me, Family"
    error_message = "allowedAudiences must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    allowed_audiences = "me,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_audiences]
}
