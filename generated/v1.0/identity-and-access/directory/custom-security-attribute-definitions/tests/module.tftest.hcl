# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/customSecurityAttributeDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedValues", "attributeSet", "description", "isCollection", "isSearchable", "name", "status", "type", "usePreDefinedValuesOnly"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    attribute_set  = "example"
    is_collection  = false
    allowed_values = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attributeSet"]) == jsonencode("example")
    error_message = "attributeSet must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCollection"]) == jsonencode(false)
    error_message = "isCollection must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedValues"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.allowedValue" }])
    error_message = "allowedValues must preserve typed values and omit nested nulls."
  }
}
