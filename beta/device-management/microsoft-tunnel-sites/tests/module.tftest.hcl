# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/microsoftTunnelSites"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "internalNetworkProbeUrl", "microsoftTunnelConfiguration", "microsoftTunnelServers", "publicAddress", "roleScopeTagIds", "upgradeAutomatically", "upgradeAvailable", "upgradeWindowEndTime", "upgradeWindowStartTime", "upgradeWindowUtcOffsetInMinutes"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                          = "example"
    upgrade_automatically                = false
    upgrade_window_utc_offset_in_minutes = -2147483648
    microsoft_tunnel_servers             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["upgradeAutomatically"]) == jsonencode(false)
    error_message = "upgradeAutomatically must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["upgradeWindowUtcOffsetInMinutes"]) == jsonencode(-2147483648)
    error_message = "upgradeWindowUtcOffsetInMinutes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["microsoftTunnelServers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.microsoftTunnelServer" }])
    error_message = "microsoftTunnelServers must preserve typed values and omit nested nulls."
  }
}
