# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    exact_match_data_store_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "dataClassification/exactMatchDataStores/test-parent-id/sessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["checksum", "completionDateTime", "creationDateTime", "dataStoreId", "dataUploadURI", "error", "fields", "fileName", "lastUpdatedDateTime", "processingCompletionDateTime", "remainingBlockCount", "remainingJobCount", "rowsPerBlock", "salt", "startDateTime", "state", "totalBlockCount", "totalJobCount", "uploadAgent", "uploadAgentId", "uploadCompletionDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    exact_match_data_store_id = "test-parent-id"
    checksum                  = "example"
    remaining_block_count     = -2147483648
    fields                    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["checksum"]) == jsonencode("example")
    error_message = "checksum must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["remainingBlockCount"]) == jsonencode(-2147483648)
    error_message = "remainingBlockCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["fields"]) == jsonencode(["example"])
    error_message = "fields must preserve typed values and omit nested nulls."
  }
}
