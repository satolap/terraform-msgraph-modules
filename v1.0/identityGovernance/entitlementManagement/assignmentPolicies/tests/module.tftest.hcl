# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/assignmentPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedTargetScope", "automaticRequestSettings", "createdDateTime", "customExtensionStageSettings", "description", "displayName", "expiration", "modifiedDateTime", "notificationSettings", "questions", "requestApprovalSettings", "requestorSettings", "reviewSettings", "specificAllowedTargets"] : !contains(keys(msgraph_resource.this.body), key)])
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
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["customExtensionStageSettings", "questions"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowedTargetScope           = "notSpecified"
    automaticRequestSettings     = { "gracePeriodBeforeAccessRemoval" = null }
    customExtensionStageSettings = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedTargetScope"]) == jsonencode("notSpecified")
    error_message = "allowedTargetScope must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["automaticRequestSettings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.accessPackageAutomaticRequestSettings" })
    error_message = "automaticRequestSettings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customExtensionStageSettings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customExtensionStageSetting" }])
    error_message = "customExtensionStageSettings must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowedTargetScope = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowedTargetScope]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
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
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}

# A PUT update sends the whole request body, so every input that is set must be in it.

run "full_body_put_update" {
  command = plan

  variables {
    allowedTargetScope = "notSpecified"
  }

  assert {
    condition     = msgraph_resource.this.update_method == "PUT"
    error_message = "The update verb must be PUT."
  }

  assert {
    condition     = alltrue([for name in ["allowedTargetScope", "@odata.type"] : contains(keys(msgraph_resource.this.body), name)])
    error_message = "The request body must carry every input that is set."
  }
}
