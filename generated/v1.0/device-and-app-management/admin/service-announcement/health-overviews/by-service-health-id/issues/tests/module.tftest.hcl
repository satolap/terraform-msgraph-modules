# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    service_health_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/serviceAnnouncement/healthOverviews/test-parent-id/issues"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["classification", "details", "endDateTime", "feature", "featureGroup", "impactDescription", "isResolved", "lastModifiedDateTime", "origin", "posts", "service", "startDateTime", "status", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    service_health_id = "test-parent-id"
    classification    = "advisory"
    is_resolved       = false
    details           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["classification"]) == jsonencode("advisory")
    error_message = "classification must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isResolved"]) == jsonencode(false)
    error_message = "isResolved must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["details"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValuePair" }])
    error_message = "details must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    service_health_id = "test-parent-id"
    classification    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.classification]
}
