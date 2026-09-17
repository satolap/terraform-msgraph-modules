# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    branch_site_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/connectivity/branches/test-parent-id/connectivityConfiguration/links"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "localConfigurations", "peerConfiguration"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    branch_site_id       = "test-parent-id"
    display_name         = "example"
    peer_configuration   = { "asn" = null }
    local_configurations = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["peerConfiguration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.networkaccess.peerConnectivityConfiguration" })
    error_message = "peerConfiguration must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["localConfigurations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.networkaccess.localConnectivityConfiguration" }])
    error_message = "localConfigurations must preserve typed values and omit nested nulls."
  }
}
