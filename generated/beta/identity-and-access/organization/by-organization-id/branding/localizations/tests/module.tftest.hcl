# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    organization_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "organization/test-parent-id/branding/localizations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["backgroundColor", "backgroundImage", "bannerLogo", "contentCustomization", "customAccountResetCredentialsUrl", "customCannotAccessYourAccountText", "customCannotAccessYourAccountUrl", "customCSS", "customForgotMyPasswordText", "customPrivacyAndCookiesText", "customPrivacyAndCookiesUrl", "customResetItNowText", "customTermsOfUseText", "customTermsOfUseUrl", "favicon", "headerBackgroundColor", "headerLogo", "loginPageLayoutConfiguration", "loginPageTextVisibilitySettings", "signInPageText", "squareLogo", "squareLogoDark", "usernameHintText"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    organization_id  = "test-parent-id"
    background_color = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["backgroundColor"]) == jsonencode("example")
    error_message = "backgroundColor must preserve typed values and omit nested nulls."
  }
}
