# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "print/printerShares"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowAllUsers", "allowedGroups", "allowedUsers", "capabilities", "defaults", "displayName", "isAcceptingJobs", "jobs", "location", "manufacturer", "model", "name", "printer", "status", "viewPoint"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name    = "example"
    allow_all_users = false
    status          = { "processingState" = null }
    allowed_groups  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowAllUsers"]) == jsonencode(false)
    error_message = "allowAllUsers must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["status"]) == jsonencode({ "@odata.type" = "#microsoft.graph.printerStatus" })
    error_message = "status must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedGroups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.group" }])
    error_message = "allowedGroups must preserve typed values and omit nested nulls."
  }
}
