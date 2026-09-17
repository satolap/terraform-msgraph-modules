# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/logs/connections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["agentVersion", "applicationSnapshot", "createdDateTime", "crossTenantAccessType", "destinationFqdn", "destinationIp", "destinationPort", "deviceCategory", "deviceId", "deviceJoinType", "deviceOperatingSystem", "deviceOperatingSystemVersion", "endDateTime", "homeTenantId", "initiatingProcessName", "lastUpdateDateTime", "networkProtocol", "popProcessingRegion", "privateAccessDetails", "receivedBytes", "sentBytes", "sourceIp", "sourcePort", "status", "tenantId", "trafficType", "transactionBlockCount", "transactionCount", "transportProtocol", "userId", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    agent_version    = "example"
    destination_port = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["agentVersion"]) == jsonencode("example")
    error_message = "agentVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["destinationPort"]) == jsonencode(-2147483648)
    error_message = "destinationPort must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    cross_tenant_access_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.cross_tenant_access_type]
}
