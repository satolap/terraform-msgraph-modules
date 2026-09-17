# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/activities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activationUrl", "activitySourceHost", "appActivityId", "appDisplayName", "contentInfo", "contentUrl", "createdDateTime", "expirationDateTime", "fallbackUrl", "historyItems", "lastModifiedDateTime", "status", "userTimezone", "visualElements"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activation_url  = "example"
    visual_elements = { "attribution" = null }
    history_items   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activationUrl"]) == jsonencode("example")
    error_message = "activationUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["visualElements"]) == jsonencode({ "@odata.type" = "#microsoft.graph.visualInfo" })
    error_message = "visualElements must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["historyItems"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.activityHistoryItem" }])
    error_message = "historyItems must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
