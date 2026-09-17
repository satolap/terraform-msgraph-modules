# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    retention_label_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/labels/retentionLabels/test-parent-id/dispositionReviewStages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["name", "reviewersEmailAddresses", "stageNumber"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    retention_label_id        = "test-parent-id"
    name                      = "example"
    reviewers_email_addresses = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["name"]) == jsonencode("example")
    error_message = "name must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["reviewersEmailAddresses"]) == jsonencode(["example"])
    error_message = "reviewersEmailAddresses must preserve typed values and omit nested nulls."
  }
}
