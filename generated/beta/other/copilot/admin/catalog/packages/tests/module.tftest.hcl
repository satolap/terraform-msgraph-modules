# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "copilot/admin/catalog/packages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acquireUsersAndGroups", "activeUsers", "agentIdentityId", "allowedUsersAndGroups", "appId", "assetId", "availableTo", "categories", "createdDateTime", "deployedTo", "displayName", "elementDetails", "elementTypes", "exceptionRate", "governanceMetadata", "version", "isBlocked", "lastModifiedDateTime", "lastUsedDateTime", "longDescription", "manifestId", "manifestVersion", "ownerId", "platform", "publisher", "requestStatus", "requestType", "sensitivity", "sharedWithUsersAndGroups", "shortDescription", "supportedHosts", "totalRunTimeInHours", "totalSessions", "type", "zipFile"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    agent_identity_id        = "example"
    is_blocked               = false
    active_users             = -2147483648
    acquire_users_and_groups = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["agentIdentityId"]) == jsonencode("example")
    error_message = "agentIdentityId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isBlocked"]) == jsonencode(false)
    error_message = "isBlocked must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeUsers"]) == jsonencode(-2147483648)
    error_message = "activeUsers must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acquireUsersAndGroups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.packageAccessEntity" }])
    error_message = "acquireUsersAndGroups must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    available_to = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.available_to]
}
