# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "allowedDataLocations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appId", "domain", "isDefault", "location"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_id     = "example"
    is_default = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appId"]) == jsonencode("example")
    error_message = "appId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefault"]) == jsonencode(false)
    error_message = "isDefault must preserve typed values and omit nested nulls."
  }
}
