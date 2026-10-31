# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.iosVppEBook"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/managedEBooks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "categories", "createdDateTime", "description", "deviceStates", "displayName", "informationUrl", "installSummary", "largeCover", "lastModifiedDateTime", "privacyInformationUrl", "publishedDateTime", "publisher", "userStateSummary"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    odata_type      = "#microsoft.graph.iosVppEBook"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "categories", "deviceStates", "installSummary", "userStateSummary"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type      = "#microsoft.graph.iosVppEBook"
    createdDateTime = "2026-01-01T00:00:00Z"
    largeCover      = { "type" = null }
    assignments     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.iosVppEBook")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["largeCover"]) == jsonencode({ "@odata.type" = "#microsoft.graph.mimeContent" })
    error_message = "largeCover must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedEBookAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.iosVppEBook"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.iosVppEBook"
    timeouts   = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.iosVppEBook"
    timeouts   = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.iosVppEBook"
    timeouts   = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.iosVppEBook"
    timeouts   = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
