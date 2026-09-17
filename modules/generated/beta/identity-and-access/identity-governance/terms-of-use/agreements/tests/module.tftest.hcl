# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/termsOfUse/agreements"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "file", "files", "isPerDeviceAcceptanceRequired", "isViewingBeforeAcceptanceRequired", "termsExpiration", "userReacceptRequiredFrequency"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                      = "example"
    is_per_device_acceptance_required = false
    files                             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isPerDeviceAcceptanceRequired"]) == jsonencode(false)
    error_message = "isPerDeviceAcceptanceRequired must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["files"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.agreementFileLocalization" }])
    error_message = "files must preserve typed values and omit nested nulls."
  }
}
