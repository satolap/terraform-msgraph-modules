# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/policySets/test-parent-id/items"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "displayName", "errorCode", "guidedDeploymentTags", "itemType", "lastModifiedDateTime", "payloadId", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    policy_set_id          = "test-parent-id"
    created_date_time      = "2026-01-01T00:00:00Z"
    guided_deployment_tags = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["guidedDeploymentTags"]) == jsonencode(["example"])
    error_message = "guidedDeploymentTags must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    error_code    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.error_code]
}
