# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/credentialUserRegistrationDetails"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authMethods", "isCapable", "isEnabled", "isMfaRegistered", "isRegistered", "userDisplayName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_display_name = "example"
    is_capable        = false
    auth_methods      = ["email"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userDisplayName"]) == jsonencode("example")
    error_message = "userDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCapable"]) == jsonencode(false)
    error_message = "isCapable must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["authMethods"]) == jsonencode(["email"])
    error_message = "authMethods must preserve typed values and omit nested nulls."
  }
}
