# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/snapshots"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["cloudPcId", "createdDateTime", "expirationDateTime", "lastRestoredDateTime", "snapshotType", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    cloud_pc_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cloudPcId"]) == jsonencode("example")
    error_message = "cloudPcId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    snapshot_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.snapshot_type]
}
