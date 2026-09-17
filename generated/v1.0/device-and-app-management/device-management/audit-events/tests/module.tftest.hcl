# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/auditEvents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activity", "activityDateTime", "activityOperationType", "activityResult", "activityType", "actor", "category", "componentName", "correlationId", "displayName", "resources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity  = "example"
    resources = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activity"]) == jsonencode("example")
    error_message = "activity must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.auditResource" }])
    error_message = "resources must preserve typed values and omit nested nulls."
  }
}
