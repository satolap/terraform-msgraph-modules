# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "teamwork/devices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activity", "activityState", "companyAssetTag", "configuration", "createdBy", "createdDateTime", "currentUser", "deviceType", "hardwareDetail", "health", "healthStatus", "lastModifiedBy", "lastModifiedDateTime", "notes", "operations"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity_state = "unknown"
    current_user   = { "displayName" = null }
    operations     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityState"]) == jsonencode("unknown")
    error_message = "activityState must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["currentUser"]) == jsonencode({ "@odata.type" = "#microsoft.graph.teamworkUserIdentity" })
    error_message = "currentUser must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["operations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.teamworkDeviceOperation" }])
    error_message = "operations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    activity_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.activity_state]
}
