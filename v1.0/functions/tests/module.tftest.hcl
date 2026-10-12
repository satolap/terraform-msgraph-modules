# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "functions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["parameters"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    parameters = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["parameters"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attributeMappingParameterSchema" }])
    error_message = "parameters must preserve typed values and omit nested nulls."
  }
}
