# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/teams/telephoneNumberManagement/numberAssignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activationState", "assignmentCategory", "assignmentStatus", "assignmentTargetId", "capabilities", "city", "civicAddressId", "isoCountryCode", "locationId", "networkSiteId", "numberSource", "numberType", "operatorId", "portInStatus", "reverseNumberLookupOptions", "supportedCustomerActions", "telephoneNumber"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activation_state = "activated"
    capabilities     = ["conferenceAssignment"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activationState"]) == jsonencode("activated")
    error_message = "activationState must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["capabilities"]) == jsonencode(["conferenceAssignment"])
    error_message = "capabilities must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    activation_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.activation_state]
}
