# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/dataDiscovery/cloudAppDiscovery/uploadedStreams"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["anonymizeMachineData", "anonymizeUserData", "createdDateTime", "description", "displayName", "isSnapshotReport", "lastDataReceivedDateTime", "lastModifiedDateTime", "logDataProvider", "logFileCount", "receiverProtocol", "supportedEntityTypes", "supportedTrafficTypes"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time      = "2026-01-01T00:00:00Z"
    anonymize_machine_data = false
    log_file_count         = -2147483648
    supported_entity_types = ["userName"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["anonymizeMachineData"]) == jsonencode(false)
    error_message = "anonymizeMachineData must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["logFileCount"]) == jsonencode(-2147483648)
    error_message = "logFileCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["supportedEntityTypes"]) == jsonencode(["userName"])
    error_message = "supportedEntityTypes must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    log_data_provider = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.log_data_provider]
}
