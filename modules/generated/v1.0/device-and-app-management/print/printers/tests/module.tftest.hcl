# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "print/printers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["capabilities", "connectors", "defaults", "displayName", "isAcceptingJobs", "jobs", "location", "manufacturer", "model", "status", "taskTriggers"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name      = "example"
    is_accepting_jobs = false
    status            = { "state" = null }
    connectors        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAcceptingJobs"]) == jsonencode(false)
    error_message = "isAcceptingJobs must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["status"]) == jsonencode({ "@odata.type" = "#microsoft.graph.printerStatus" })
    error_message = "status must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectors"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.printConnector" }])
    error_message = "connectors must preserve typed values and omit nested nulls."
  }
}
