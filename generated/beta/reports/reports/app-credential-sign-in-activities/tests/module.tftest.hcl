# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/appCredentialSignInActivities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appId", "appObjectId", "createdDateTime", "credentialOrigin", "expirationDateTime", "keyId", "keyType", "keyUsage", "resourceId", "servicePrincipalObjectId", "signInActivity"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_id           = "example"
    sign_in_activity = { "lastNonInteractiveSignInDateTime" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appId"]) == jsonencode("example")
    error_message = "appId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["signInActivity"]) == jsonencode({ "@odata.type" = "#microsoft.graph.signInActivity" })
    error_message = "signInActivity must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    credential_origin = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.credential_origin]
}
