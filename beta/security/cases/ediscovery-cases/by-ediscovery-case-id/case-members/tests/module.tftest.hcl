# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/caseMembers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "recipientType", "smtpAddress"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    display_name       = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    recipient_type     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.recipient_type]
}

run "flags_enum_combination" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    recipient_type     = "user, RoleGroup"
  }

  assert {
    condition     = msgraph_resource.this.body["recipientType"] == "user, RoleGroup"
    error_message = "recipientType must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    recipient_type     = "user,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.recipient_type]
}
