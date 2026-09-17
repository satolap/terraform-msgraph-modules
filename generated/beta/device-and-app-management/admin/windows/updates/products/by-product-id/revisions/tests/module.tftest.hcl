# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    product_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/windows/updates/products/test-parent-id/revisions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["catalogEntry", "knowledgeBaseArticle", "osBuild"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    product_id = "test-parent-id"
    os_build   = {}
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["osBuild"]) == jsonencode({ "@odata.type" = "#microsoft.graph.windowsUpdates.buildVersionDetails" })
    error_message = "osBuild must preserve typed values and omit nested nulls."
  }
}
