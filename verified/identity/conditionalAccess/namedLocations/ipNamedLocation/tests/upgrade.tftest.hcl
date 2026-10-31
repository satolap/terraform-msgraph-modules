mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = { location = {
        id            = "44444444-4444-4444-4444-444444444444"
        "@odata.type" = "#microsoft.graph.ipNamedLocation"
        isTrusted     = true
      } }
    }
  }
  mock_resource "msgraph_resource" {
    defaults = {
      id = "44444444-4444-4444-4444-444444444444"
      output = {
        display_name = "Office egress"
        is_trusted   = true
        ip_ranges    = ["2001:db8::/48", "192.0.2.0/24"]
      }
    }
  }
}

variables {
  displayName = "Office egress"
  ip_ranges   = ["2001:db8::/48", "192.0.2.0/24"]
  isTrusted   = true
}

# v4.0.0 state has the named location only and no trust action. The saved ID differs
# from the mock default, so a replacement would be visible as a changed ID.
run "v4_0_0_state_without_trust_action" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }
  override_resource {
    target = msgraph_resource.named_location
    values = {
      id = "55555555-5555-5555-5555-555555555555"
      output = {
        display_name = "Office egress"
        is_trusted   = true
        ip_ranges    = ["2001:db8::/48", "192.0.2.0/24"]
      }
    }
  }
  assert {
    condition     = msgraph_resource.named_location.id == "55555555-5555-5555-5555-555555555555"
    error_message = "The v4.0.0 fixture must save the legacy location ID."
  }
}

# GB-msgraph-provider-631: an unchanged apply of the current module registers the new
# action against the saved ID and does not replace the location.
run "unchanged_apply_registers_trust_action" {
  state_key = "upgrade"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_trust
    values = { output = { location = {
      id            = "55555555-5555-5555-5555-555555555555"
      "@odata.type" = "#microsoft.graph.ipNamedLocation"
      isTrusted     = true
    } } }
  }
  assert {
    condition     = msgraph_resource.named_location.id == "55555555-5555-5555-5555-555555555555"
    error_message = "An unchanged upgrade must keep the saved named-location ID, not replace the location."
  }
  assert {
    condition     = msgraph_resource_action.trust.resource_url == "identity/conditionalAccess/namedLocations/55555555-5555-5555-5555-555555555555"
    error_message = "Upgrade must register the trust PATCH against the saved location ID."
  }
  assert {
    condition     = msgraph_resource_action.trust.method == "PATCH" && msgraph_resource_action.trust.when == "apply"
    error_message = "The registered action must be the apply-time PATCH."
  }
  assert {
    condition = jsonencode(msgraph_resource_action.trust.body) == jsonencode({
      "@odata.type" = "#microsoft.graph.ipNamedLocation"
      isTrusted     = true
    })
    error_message = "The first upgraded apply PATCHes exactly the derived type and the configured isTrusted."
  }
  assert {
    condition     = output.id == "55555555-5555-5555-5555-555555555555" && output.is_trusted == true
    error_message = "The module must expose the retained ID and the independently confirmed trust value."
  }
}
