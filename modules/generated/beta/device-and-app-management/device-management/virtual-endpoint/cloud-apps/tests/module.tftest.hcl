# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/cloudApps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appDetail", "appStatus", "availableToUser", "description", "displayName", "provisioningPolicyId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_status        = "preparing"
    available_to_user = false
    app_detail        = { "commandLineArguments" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appStatus"]) == jsonencode("preparing")
    error_message = "appStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["availableToUser"]) == jsonencode(false)
    error_message = "availableToUser must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDetail"]) == jsonencode({ "@odata.type" = "#microsoft.graph.cloudPcCloudAppDetail" })
    error_message = "appDetail must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    app_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.app_status]
}
