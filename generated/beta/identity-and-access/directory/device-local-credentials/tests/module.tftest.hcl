# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/deviceLocalCredentials"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["credentials", "deviceName", "lastBackupDateTime", "refreshDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_name = "example"
    credentials = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceName"]) == jsonencode("example")
    error_message = "deviceName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["credentials"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceLocalCredential" }])
    error_message = "credentials must preserve typed values and omit nested nulls."
  }
}
