# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/microsoftTunnelConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["advancedSettings", "defaultDomainSuffix", "description", "disableUdpConnections", "displayName", "dnsServers", "ipv6Network", "lastUpdateDateTime", "listenPort", "network", "roleScopeTagIds", "routeExcludes", "routeIncludes", "routesExclude", "routesInclude", "splitDNS"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    default_domain_suffix   = "example"
    disable_udp_connections = false
    listen_port             = -2147483648
    advanced_settings       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultDomainSuffix"]) == jsonencode("example")
    error_message = "defaultDomainSuffix must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["disableUdpConnections"]) == jsonencode(false)
    error_message = "disableUdpConnections must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["listenPort"]) == jsonencode(-2147483648)
    error_message = "listenPort must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["advancedSettings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValuePair" }])
    error_message = "advancedSettings must preserve typed values and omit nested nulls."
  }
}
