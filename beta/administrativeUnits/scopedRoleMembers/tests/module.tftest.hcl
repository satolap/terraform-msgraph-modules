# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "administrativeUnits/test-parent-id/scopedRoleMembers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["administrativeUnitId", "roleId", "roleMemberInfo"] : !contains(keys(msgraph_resource.this.body), key)])
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
    administrativeUnit-id = "test-parent-id"
    select_response       = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    administrativeUnitId  = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["administrativeUnitId"]) == jsonencode("example")
    error_message = "administrativeUnitId must preserve typed values and omit nested nulls."
  }
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    timeouts              = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    timeouts              = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    timeouts              = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    timeouts              = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}

run "body_containing_the_error_is_rejected_scoped_role_member_source_not_replicated" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    additional_properties = { "note" = "The source resource object or one of the objects being referenced don't exist" }
  }

  expect_failures = [msgraph_resource.this]
}

run "retry_set_for_scoped_role_member_source_not_replicated" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
    roleMemberInfo        = {}
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.retry.error_message_regex) == jsonencode(["^\\s*\\{\\s*\"error\"\\s*:\\s*\\{\\s*\"code\"\\s*:\\s*\"(?:Request_)?BadRequest\"\\s*,\\s*\"message\"\\s*:\\s*\"The source resource object or one of the objects being referenced don(?:'|\\\\u0027)t exist\\.\"\\s*[,}]"])
    error_message = "A request that references another object must retry only the reviewed replication error."
  }
}

run "no_retry_without_scoped_role_member_source_not_replicated" {
  command = plan

  variables {
    administrativeUnit-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.retry == null
    error_message = "A request without the referencing input must set no retry."
  }
}
