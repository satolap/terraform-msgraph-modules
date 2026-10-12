# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/enterpriseApps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["resourceNamespaces", "roleAssignmentApprovals", "roleAssignmentScheduleInstances", "roleAssignmentScheduleRequests", "roleAssignmentSchedules", "roleAssignments", "roleDefinitions", "roleEligibilityScheduleInstances", "roleEligibilityScheduleRequests", "roleEligibilitySchedules", "transitiveRoleAssignments"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    resource_namespaces = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resourceNamespaces"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.unifiedRbacResourceNamespace" }])
    error_message = "resourceNamespaces must preserve typed values and omit nested nulls."
  }
}
