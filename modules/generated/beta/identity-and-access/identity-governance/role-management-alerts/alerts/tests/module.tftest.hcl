# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/roleManagementAlerts/alerts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertConfiguration", "alertDefinition", "alertDefinitionId", "alertIncidents", "incidentCount", "isActive", "lastModifiedDateTime", "lastScannedDateTime", "scopeId", "scopeType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_definition_id = "example"
    is_active           = false
    incident_count      = -2147483648
    alert_incidents     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertDefinitionId"]) == jsonencode("example")
    error_message = "alertDefinitionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isActive"]) == jsonencode(false)
    error_message = "isActive must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["incidentCount"]) == jsonencode(-2147483648)
    error_message = "incidentCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertIncidents"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.unifiedRoleManagementAlertIncident" }])
    error_message = "alertIncidents must preserve typed values and omit nested nulls."
  }
}
