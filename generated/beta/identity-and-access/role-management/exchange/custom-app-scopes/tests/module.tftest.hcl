# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/exchange/customAppScopes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["customAttributes"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    custom_attributes = {}
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customAttributes"]) == jsonencode({ "@odata.type" = "#microsoft.graph.customAppScopeAttributesDictionary" })
    error_message = "customAttributes must preserve typed values and omit nested nulls."
  }
}
