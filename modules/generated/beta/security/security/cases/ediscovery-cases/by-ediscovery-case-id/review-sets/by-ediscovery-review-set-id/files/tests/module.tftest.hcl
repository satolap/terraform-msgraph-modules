# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id       = "test-parent-id"
    ediscovery_review_set_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/reviewSets/test-parent-id/files"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "custodian", "dateTime", "extension", "extractedTextContent", "mediaType", "name", "otherProperties", "processingStatus", "senderOrAuthors", "size", "sourceType", "subjectTitle", "tags"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id       = "test-parent-id"
    ediscovery_review_set_id = "test-parent-id"
    content                  = "example"
    size                     = 0
    sender_or_authors        = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["size"]) == jsonencode(0)
    error_message = "size must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["senderOrAuthors"]) == jsonencode(["example"])
    error_message = "senderOrAuthors must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ediscovery_case_id       = "test-parent-id"
    ediscovery_review_set_id = "test-parent-id"
    processing_status        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.processing_status]
}
