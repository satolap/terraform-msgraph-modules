# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/profile/positions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedAudiences", "categories", "colleagues", "createdBy", "createdDateTime", "detail", "source", "inference", "isCurrent", "isSearchable", "lastModifiedBy", "lastModifiedDateTime", "manager", "sources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowed_audiences = "me"
    is_current        = false
    detail            = { "company" = null }
    categories        = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedAudiences"]) == jsonencode("me")
    error_message = "allowedAudiences must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCurrent"]) == jsonencode(false)
    error_message = "isCurrent must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["detail"]) == jsonencode({ "@odata.type" = "#microsoft.graph.positionDetail" })
    error_message = "detail must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categories"]) == jsonencode(["example"])
    error_message = "categories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowed_audiences = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_audiences]
}

run "flags_enum_combination" {
  command = plan

  variables {
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
    allowed_audiences = "me,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_audiences]
}
