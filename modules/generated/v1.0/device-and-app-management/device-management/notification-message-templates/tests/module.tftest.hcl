# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/notificationMessageTemplates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["brandingOptions", "defaultLocale", "displayName", "lastModifiedDateTime", "localizedNotificationMessages", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    branding_options                = "none"
    localized_notification_messages = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["brandingOptions"]) == jsonencode("none")
    error_message = "brandingOptions must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["localizedNotificationMessages"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.localizedNotificationMessage" }])
    error_message = "localizedNotificationMessages must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    branding_options = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.branding_options]
}
