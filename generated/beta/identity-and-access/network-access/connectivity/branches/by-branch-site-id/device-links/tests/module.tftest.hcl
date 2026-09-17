# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    branch_site_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/connectivity/branches/test-parent-id/deviceLinks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["bandwidthCapacityInMbps", "bgpConfiguration", "deviceVendor", "ipAddress", "lastModifiedDateTime", "name", "redundancyConfiguration", "tunnelConfiguration"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    branch_site_id    = "test-parent-id"
    device_vendor     = "barracudaNetworks"
    bgp_configuration = { "asn" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceVendor"]) == jsonencode("barracudaNetworks")
    error_message = "deviceVendor must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["bgpConfiguration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.networkaccess.bgpConfiguration" })
    error_message = "bgpConfiguration must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    branch_site_id             = "test-parent-id"
    bandwidth_capacity_in_mbps = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.bandwidth_capacity_in_mbps]
}
