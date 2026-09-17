# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/caseManagement/cases"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activities", "attachments", "createdBy", "createdDateTime", "customFields", "displayName", "lastModifiedBy", "lastModifiedDateTime", "relations", "status", "tasks"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_by = "example"
    activities = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdBy"]) == jsonencode("example")
    error_message = "createdBy must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activities"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.caseManagement.activity" }])
    error_message = "activities must preserve typed values and omit nested nulls."
  }
}
