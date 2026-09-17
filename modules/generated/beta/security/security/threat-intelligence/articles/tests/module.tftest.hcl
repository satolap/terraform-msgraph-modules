# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatIntelligence/articles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["body", "createdDateTime", "imageUrl", "indicators", "isFeatured", "lastUpdatedDateTime", "summary", "tags", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time = "2026-01-01T00:00:00Z"
    is_featured       = false
    body              = { "content" = null }
    indicators        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isFeatured"]) == jsonencode(false)
    error_message = "isFeatured must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["body"]) == jsonencode({ "@odata.type" = "#microsoft.graph.security.formattedContent" })
    error_message = "body must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["indicators"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.articleIndicator" }])
    error_message = "indicators must preserve typed values and omit nested nulls."
  }
}
