mock_provider "time" {}
mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { output = { request_id = "saved_request", state = "delivered" } }
  }
  mock_data "msgraph_resource" {
    defaults = { output = { resources = [{ id = "resource_before_upgrade", originId = "33333333-3333-3333-3333-333333333333", originSystem = "AadGroup" }] } }
  }
}
variables {
  accessPackageCatalog-id    = "11111111-1111-1111-1111-111111111111"
  resource_origin_id         = "33333333-3333-3333-3333-333333333333"
  resource_origin_system     = "AadGroup"
  verification_delay_seconds = 0
}

run "legacy_state_without_remove" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }
  # The previous release declares the inputs under their former names.
  variables {
    catalog_id = "11111111-1111-1111-1111-111111111111"
  }
}
run "unchanged_apply_registers_old_url" {
  state_key = "upgrade"
  command   = apply
  assert {
    condition     = null_resource.remove_on_destroy[0].id == run.legacy_state_without_remove.owned_state_id
    error_message = "Upgrade must preserve the legacy identity record."
  }
  assert {
    condition     = msgraph_resource_action.add_request.id == run.legacy_state_without_remove.post_state_id
    error_message = "Upgrade must retain adminAdd without replay or replacement."
  }
  assert {
    condition     = msgraph_resource_action.remove[0].resource_url == "identityGovernance/entitlementManagement/resourceRequests" && msgraph_resource_action.remove[0].body.resource.id == "resource_before_upgrade" && msgraph_resource_action.remove[0].body.catalog.id == "11111111-1111-1111-1111-111111111111"
    error_message = "Removal must target the old resource and catalog with the documented counter-request."
  }
  assert {
    condition     = msgraph_resource_action.remove[0].when == "destroy" && msgraph_resource_action.remove[0].method == "POST" && msgraph_resource_action.remove[0].body.requestType == "adminRemove"
    error_message = "Registration must send no adminRemove during apply."
  }
}
