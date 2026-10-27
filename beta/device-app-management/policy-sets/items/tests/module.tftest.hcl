# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/policySets/test-parent-id/items"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "displayName", "errorCode", "guidedDeploymentTags", "itemType", "lastModifiedDateTime", "payloadId", "status"] : !contains(keys(msgraph_resource.this.body), key)])
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
    policy_set_id   = "test-parent-id"
    odata_type      = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    policy_set_id          = "test-parent-id"
    odata_type             = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
    created_date_time      = "2026-01-01T00:00:00Z"
    guided_deployment_tags = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.deviceCompliancePolicyPolicySetItem")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["guidedDeploymentTags"]) == jsonencode(["example"])
    error_message = "guidedDeploymentTags must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
    timeouts      = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
    timeouts      = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
    timeouts      = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    policy_set_id = "test-parent-id"
    odata_type    = "#microsoft.graph.deviceCompliancePolicyPolicySetItem"
    timeouts      = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
