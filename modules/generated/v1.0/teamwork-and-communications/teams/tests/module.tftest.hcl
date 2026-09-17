# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "teams"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allChannels", "channels", "classification", "createdDateTime", "description", "displayName", "firstChannelName", "funSettings", "group", "guestSettings", "incomingChannels", "installedApps", "internalId", "memberSettings", "members", "messagingSettings", "operations", "permissionGrants", "photo", "primaryChannel", "schedule", "specialization", "summary", "tags", "template", "tenantId", "visibility", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    classification = "example"
    all_channels   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["classification"]) == jsonencode("example")
    error_message = "classification must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allChannels"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.channel" }])
    error_message = "allChannels must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    specialization = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.specialization]
}
