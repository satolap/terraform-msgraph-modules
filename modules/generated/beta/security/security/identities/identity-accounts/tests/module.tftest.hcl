# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/identities/identityAccounts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accounts", "cloudSecurityIdentifier", "displayName", "domain", "isEnabled", "onPremisesSecurityIdentifier"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    cloud_security_identifier = "example"
    is_enabled                = false
    accounts                  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cloudSecurityIdentifier"]) == jsonencode("example")
    error_message = "cloudSecurityIdentifier must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accounts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.account" }])
    error_message = "accounts must preserve typed values and omit nested nulls."
  }
}
