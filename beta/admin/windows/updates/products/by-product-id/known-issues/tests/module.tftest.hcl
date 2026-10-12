# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    product_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/windows/updates/products/test-parent-id/knownIssues"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "knownIssueHistories", "originatingKnowledgeBaseArticle", "resolvedDateTime", "resolvingKnowledgeBaseArticle", "safeguardHoldIds", "startDateTime", "status", "title", "webViewUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    product_id            = "test-parent-id"
    description           = "example"
    known_issue_histories = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["knownIssueHistories"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.windowsUpdates.knownIssueHistoryItem" }])
    error_message = "knownIssueHistories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    product_id = "test-parent-id"
    status     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
