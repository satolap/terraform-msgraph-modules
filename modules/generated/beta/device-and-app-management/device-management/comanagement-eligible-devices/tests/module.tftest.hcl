# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/comanagementEligibleDevices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["clientRegistrationStatus", "deviceName", "deviceType", "entitySource", "managementAgents", "managementState", "manufacturer", "mdmStatus", "model", "osDescription", "osVersion", "ownerType", "referenceId", "serialNumber", "status", "upn", "userEmail", "userId", "userName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    client_registration_status = "notRegistered"
    entity_source              = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientRegistrationStatus"]) == jsonencode("notRegistered")
    error_message = "clientRegistrationStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["entitySource"]) == jsonencode(-2147483648)
    error_message = "entitySource must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    client_registration_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.client_registration_status]
}
