# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "compliance/ediscovery/cases/test-parent-id/sourceCollections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["addToReviewSetOperation", "additionalSources", "contentQuery", "createdBy", "createdDateTime", "custodianSources", "dataSourceScopes", "description", "displayName", "lastEstimateStatisticsOperation", "lastModifiedBy", "lastModifiedDateTime", "noncustodialSources"] : !contains(keys(msgraph_resource.this.body), key)])
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
    case_id         = "test-parent-id"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["addToReviewSetOperation", "additionalSources", "custodianSources", "lastEstimateStatisticsOperation", "noncustodialSources"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    case_id            = "test-parent-id"
    content_query      = "example"
    additional_sources = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentQuery"]) == jsonencode("example")
    error_message = "contentQuery must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalSources"]) == jsonencode([{}])
    error_message = "additionalSources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    case_id            = "test-parent-id"
    data_source_scopes = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.data_source_scopes]
}

run "flags_enum_combination" {
  command = plan

  variables {
    case_id            = "test-parent-id"
    data_source_scopes = "none, AllTenantMailboxes"
  }

  assert {
    condition     = msgraph_resource.this.body["dataSourceScopes"] == "none, AllTenantMailboxes"
    error_message = "dataSourceScopes must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    case_id            = "test-parent-id"
    data_source_scopes = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.data_source_scopes]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    case_id  = "test-parent-id"
    timeouts = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    case_id  = "test-parent-id"
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    case_id  = "test-parent-id"
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    case_id  = "test-parent-id"
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
