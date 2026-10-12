# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identity/verifiedId/profiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "faceCheckConfiguration", "lastModifiedDateTime", "mobileDriversLicenseConfiguration", "name", "priority", "selfServiceIssuance", "state", "verifiedIdProfileConfiguration", "verifiedIdUsageConfigurations", "verifierDid"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                      = "example"
    priority                         = -2147483648
    face_check_configuration         = { "isEnabled" = null }
    verified_id_usage_configurations = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priority"]) == jsonencode(-2147483648)
    error_message = "priority must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["faceCheckConfiguration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.faceCheckConfiguration" })
    error_message = "faceCheckConfiguration must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["verifiedIdUsageConfigurations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.verifiedIdUsageConfiguration" }])
    error_message = "verifiedIdUsageConfigurations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
