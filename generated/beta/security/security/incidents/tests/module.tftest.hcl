# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/incidents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alerts", "assignedTo", "classification", "comments", "createdDateTime", "customTags", "description", "determination", "displayName", "incidentWebUrl", "lastModifiedBy", "lastUpdateDateTime", "priorityScore", "recommendedActions", "recommendedHuntingQueries", "redirectIncidentId", "resolvingComment", "severity", "status", "summary", "systemTags", "tenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    assigned_to    = "example"
    priority_score = -2147483648
    alerts         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedTo"]) == jsonencode("example")
    error_message = "assignedTo must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priorityScore"]) == jsonencode(-2147483648)
    error_message = "priorityScore must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alerts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.alert" }])
    error_message = "alerts must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    classification = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.classification]
}
