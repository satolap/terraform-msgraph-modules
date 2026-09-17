# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/profile/emails"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["address", "allowedAudiences", "createdBy", "createdDateTime", "displayName", "source", "inference", "isSearchable", "lastModifiedBy", "lastModifiedDateTime", "sources", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    address       = "example"
    is_searchable = false
    sources       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["address"]) == jsonencode("example")
    error_message = "address must preserve typed values and omit nested nulls."
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
    allowed_audiences = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_audiences]
}
