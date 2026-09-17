# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/profile/certifications"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedAudiences", "certificationId", "createdBy", "createdDateTime", "description", "displayName", "endDate", "source", "inference", "isSearchable", "issuedDate", "issuingAuthority", "issuingCompany", "lastModifiedBy", "lastModifiedDateTime", "sources", "startDate", "thumbnailUrl", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id          = "test-parent-id"
    certification_id = "example"
    is_searchable    = false
    sources          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificationId"]) == jsonencode("example")
    error_message = "certificationId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isSearchable"]) == jsonencode(false)
    error_message = "isSearchable must preserve typed values and omit nested nulls."
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
