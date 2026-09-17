# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/alerts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actions", "alertType", "categories", "componentName", "creationDateTime", "description", "detectionTechnology", "displayName", "extendedProperties", "firstActivityDateTime", "isPreview", "lastActivityDateTime", "policy", "productName", "relatedResources", "severity", "subTechniques", "techniques", "vendorName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_type = "unhealthyRemoteNetworks"
    is_preview = false
    actions    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertType"]) == jsonencode("unhealthyRemoteNetworks")
    error_message = "alertType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isPreview"]) == jsonencode(false)
    error_message = "isPreview must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.networkaccess.alertAction" }])
    error_message = "actions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    alert_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.alert_type]
}
