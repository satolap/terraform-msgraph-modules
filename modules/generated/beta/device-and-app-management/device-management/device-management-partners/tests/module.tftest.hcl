# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceManagementPartners"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "groupsRequiringPartnerEnrollment", "isConfigured", "lastHeartbeatDateTime", "partnerAppType", "partnerState", "singleTenantAppId", "whenPartnerDevicesWillBeMarkedAsNonCompliantDateTime", "whenPartnerDevicesWillBeRemovedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                        = "example"
    is_configured                       = false
    groups_requiring_partner_enrollment = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isConfigured"]) == jsonencode(false)
    error_message = "isConfigured must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["groupsRequiringPartnerEnrollment"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementPartnerAssignment" }])
    error_message = "groupsRequiringPartnerEnrollment must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    partner_app_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.partner_app_type]
}
