# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "education/classes/test-parent-id/assignments/test-parent-id/submissions/test-parent-id/resources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentResourceUrl", "dependentResources", "resource"] : !contains(keys(msgraph_resource.this.body), key)])
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
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    select_response         = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["dependentResources"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    assignment_resource_url = "example"
    dependent_resources     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentResourceUrl"]) == jsonencode("example")
    error_message = "assignmentResourceUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dependentResources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.educationSubmissionResource" }])
    error_message = "dependentResources must preserve typed values and omit nested nulls."
  }
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    timeouts                = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    timeouts                = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    timeouts                = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    timeouts                = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
