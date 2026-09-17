# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/caseManagement/cases/test-parent-id/attachments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "createdBy", "createdDateTime", "description", "displayName", "fileExtension", "fileSize", "lastModifiedBy", "lastModifiedDateTime", "origin", "scanResult"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    case_id   = "test-parent-id"
    content   = "example"
    file_size = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["fileSize"]) == jsonencode(0)
    error_message = "fileSize must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    case_id     = "test-parent-id"
    scan_result = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.scan_result]
}
