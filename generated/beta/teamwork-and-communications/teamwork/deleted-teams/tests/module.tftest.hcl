# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "teamwork/deletedTeams"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["channels"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    channels = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["channels"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.channel" }])
    error_message = "channels must preserve typed values and omit nested nulls."
  }
}
