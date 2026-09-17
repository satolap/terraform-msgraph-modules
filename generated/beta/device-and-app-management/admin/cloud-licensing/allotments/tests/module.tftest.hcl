# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/cloudLicensing/allotments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignableTo", "assignments", "externalServiceIdentifier", "subscriptions", "waitingMembers"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    assignable_to = "none"
    assignments   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignableTo"]) == jsonencode("none")
    error_message = "assignableTo must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.cloudLicensing.assignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    assignable_to = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.assignable_to]
}
