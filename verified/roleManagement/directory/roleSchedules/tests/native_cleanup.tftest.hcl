mock_provider "null" {}
mock_provider "time" {}
mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { output = { request_id = "request_before_upgrade", status = "ScheduleCreated" } }
  }
  mock_data "msgraph_resource" {
    defaults = { output = { "request" : { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "ScheduleCreated" }, "schedules" : [], "roles" : [] } }
  }
}
variables {
  assignment_type               = "eligible"
  principalId                   = "11111111-1111-1111-1111-111111111111"
  roleDefinitionId              = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "registers_verified_request_before_future_schedule" {
  command = apply
  variables { start_date_time = "2999-01-01T00:00:00Z" }
  assert {
    condition     = length(msgraph_resource_action.remove) == 1 && output.verified == false
    error_message = "A verified future request must have cleanup even when no schedule is listed."
  }
}

# An already registered remove action does not make the data-source proof one-time.
run "later_verification_change_fails_routine_plan" {
  command = plan
  variables { start_date_time = "2999-01-01T00:00:00Z" }
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { "request" : { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "Revoked" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}
run "schedule_gate_failure_keeps_registered_removal" {
  state_key = "failed_gate"
  command   = apply
  variables { fail_on_verification_mismatch = true }
  expect_failures = [terraform_data.verification_gate]
  assert {
    condition     = length(msgraph_resource_action.remove) == 1 && msgraph_resource_action.remove[0].when == "destroy"
    error_message = "The independent request proof must register cleanup before schedule verification fails."
  }
}

run "refuses_different_id" {
  state_key = "different_id"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "another_request", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "ScheduleCreated" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_different_principal" {
  state_key = "different_principal"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "22222222-2222-2222-2222-222222222222", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "ScheduleCreated" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_wrong_action" {
  state_key = "wrong_action"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "request_before_upgrade", "action" : "adminRemove", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "ScheduleCreated" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_validation_only" {
  state_key = "validation_only"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : true, "status" : "ScheduleCreated" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_pending" {
  state_key = "pending"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "PendingApproval" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_denied" {
  state_key = "denied"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : "Denied" } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_null_status" {
  state_key = "null_status"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = { "id" : "request_before_upgrade", "action" : "adminAssign", "principalId" : "11111111-1111-1111-1111-111111111111", "roleDefinitionId" : "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "directoryScopeId" : "/", "appScopeId" : null, "isValidationOnly" : false, "status" : null } } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_null" {
  state_key = "null"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_request[0]
    values = { output = { request = null } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "refuses_unsafe_created_request_id" {
  state_key = "unsafe"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assign
    values = { output = { request_id = "../another", status = "ScheduleCreated" } }
  }
  expect_failures = [data.msgraph_resource.verify_request[0]]
}

run "active_removal_uses_assignment_requests" {
  state_key = "active"
  command   = apply
  variables { assignment_type = "active" }
  assert {
    condition     = msgraph_resource_action.remove[0].resource_url == "roleManagement/directory/roleAssignmentScheduleRequests" && msgraph_resource_action.remove[0].body.action == "adminRemove"
    error_message = "Active cleanup must use the assignment counter-request, never eligibility or DELETE."
  }
}
