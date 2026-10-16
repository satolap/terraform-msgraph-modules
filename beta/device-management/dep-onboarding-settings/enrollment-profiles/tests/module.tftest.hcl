# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    dep_onboarding_setting_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/depOnboardingSettings/test-parent-id/enrollmentProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["configurationEndpointUrl", "description", "displayName", "enableAuthenticationViaCompanyPortal", "requireCompanyPortalOnSetupAssistantEnrolledDevices", "requiresUserAuthentication"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    dep_onboarding_setting_id                = "test-parent-id"
    configuration_endpoint_url               = "example"
    enable_authentication_via_company_portal = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["configurationEndpointUrl"]) == jsonencode("example")
    error_message = "configurationEndpointUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enableAuthenticationViaCompanyPortal"]) == jsonencode(false)
    error_message = "enableAuthenticationViaCompanyPortal must preserve typed values and omit nested nulls."
  }
}
