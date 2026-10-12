# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    unified_role_management_alert_id = "test-parent-id"
    odata_type                       = "#microsoft.graph.invalidLicenseAlertIncident"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/roleManagementAlerts/alerts/test-parent-id/alertIncidents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    unified_role_management_alert_id = "test-parent-id"
    odata_type                       = "#microsoft.graph.invalidLicenseAlertIncident"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.invalidLicenseAlertIncident")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    unified_role_management_alert_id = "test-parent-id"
    odata_type                       = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
