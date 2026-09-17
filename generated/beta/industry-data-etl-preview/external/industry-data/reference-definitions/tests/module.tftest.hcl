# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "external/industryData/referenceDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["code", "displayName", "isDisabled", "referenceType", "sortIndex"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    code        = "example"
    is_disabled = false
    sort_index  = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["code"]) == jsonencode("example")
    error_message = "code must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDisabled"]) == jsonencode(false)
    error_message = "isDisabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sortIndex"]) == jsonencode(-2147483648)
    error_message = "sortIndex must preserve typed values and omit nested nulls."
  }
}
