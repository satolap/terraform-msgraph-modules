# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/cloudLicensing/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allotment", "assignedTo", "disabledServicePlanIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    assigned_to               = { "deletedDateTime" = null }
    disabled_service_plan_ids = ["00000000-0000-0000-0000-000000000001"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedTo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.directoryObject" })
    error_message = "assignedTo must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["disabledServicePlanIds"]) == jsonencode(["00000000-0000-0000-0000-000000000001"])
    error_message = "disabledServicePlanIds must preserve typed values and omit nested nulls."
  }
}
