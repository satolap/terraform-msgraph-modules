# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/managedAppRegistrations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appIdentifier", "applicationVersion", "appliedPolicies", "createdDateTime", "deviceName", "deviceTag", "deviceType", "flaggedReasons", "version", "intendedPolicies", "lastSyncDateTime", "managementSdkVersion", "operations", "platformVersion", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    application_version = "example"
    applied_policies    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationVersion"]) == jsonencode("example")
    error_message = "applicationVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliedPolicies"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedAppPolicy" }])
    error_message = "appliedPolicies must preserve typed values and omit nested nulls."
  }
}
