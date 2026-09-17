# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/tags"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["childSelectability", "childTags", "createdBy", "description", "displayName", "lastModifiedDateTime", "parent"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    description        = "example"
    child_tags         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["childTags"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.ediscoveryReviewTag" }])
    error_message = "childTags must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ediscovery_case_id  = "test-parent-id"
    child_selectability = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.child_selectability]
}
