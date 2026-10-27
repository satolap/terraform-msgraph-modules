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
  principal_id                  = "11111111-1111-1111-1111-111111111111"
  role_definition_id            = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "legacy_state_without_remove" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }
}
run "unchanged_apply_registers_old_url" {
  state_key = "upgrade"
  command   = apply
  assert {
    condition     = null_resource.remove_on_destroy[0].id == run.legacy_state_without_remove.owned_state_id
    error_message = "Upgrade must preserve the legacy identity record."
  }
  assert {
    condition     = msgraph_resource_action.assign.id == run.legacy_state_without_remove.post_state_id
    error_message = "Upgrade must keep the old adminAssign without replacement or replay."
  }
  assert {
    condition     = msgraph_resource_action.remove[0].resource_url == "roleManagement/directory/roleEligibilityScheduleRequests" && msgraph_resource_action.remove[0].body.principalId == "11111111-1111-1111-1111-111111111111" && msgraph_resource_action.remove[0].body.roleDefinitionId == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && msgraph_resource_action.remove[0].body.directoryScopeId == "/"
    error_message = "Removal must retain the old request collection and exact identity."
  }
  assert {
    condition     = msgraph_resource_action.remove[0].when == "destroy" && msgraph_resource_action.remove[0].method == "POST" && msgraph_resource_action.remove[0].body.action == "adminRemove"
    error_message = "Registration must send no adminRemove during apply."
  }
}
