# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.crossTenantCalendarAvailabilityBasic"
  }

  assert {
    condition     = msgraph_resource.this.url == "policies/crossTenantAccessPolicy/default/m365Capabilities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["inboundAccess", "lastModifiedDateTime", "name"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type              = "#microsoft.graph.crossTenantCalendarAvailabilityBasic"
    last_modified_date_time = "2026-01-01T00:00:00Z"
    inbound_access          = { "isAllowed" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.crossTenantCalendarAvailabilityBasic")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastModifiedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastModifiedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["inboundAccess"]) == jsonencode({ "@odata.type" = "#microsoft.graph.m365CapabilityInboundAccess" })
    error_message = "inboundAccess must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
