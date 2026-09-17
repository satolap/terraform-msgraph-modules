# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "policies/mobileDeviceManagementPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appliesTo", "complianceUrl", "description", "discoveryUrl", "displayName", "includedGroups", "isMdmEnrollmentDuringRegistrationDisabled", "isValid", "termsOfUseUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    compliance_url                                 = "example"
    is_mdm_enrollment_during_registration_disabled = false
    included_groups                                = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["complianceUrl"]) == jsonencode("example")
    error_message = "complianceUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isMdmEnrollmentDuringRegistrationDisabled"]) == jsonencode(false)
    error_message = "isMdmEnrollmentDuringRegistrationDisabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["includedGroups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.group" }])
    error_message = "includedGroups must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    applies_to = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.applies_to]
}
