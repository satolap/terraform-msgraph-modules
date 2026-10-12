# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    domain_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "domains/test-parent-id/serviceConfigurationRecords"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isOptional", "label", "recordType", "supportedService", "ttl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    domain_id   = "test-parent-id"
    label       = "example"
    is_optional = false
    ttl         = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["label"]) == jsonencode("example")
    error_message = "label must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isOptional"]) == jsonencode(false)
    error_message = "isOptional must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["ttl"]) == jsonencode(-2147483648)
    error_message = "ttl must preserve typed values and omit nested nulls."
  }
}
