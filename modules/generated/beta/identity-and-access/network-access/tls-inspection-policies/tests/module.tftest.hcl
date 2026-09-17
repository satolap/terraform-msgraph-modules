# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/tlsInspectionPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "version", "name", "policyRules", "settings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description  = "example"
    settings     = {}
    policy_rules = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.networkaccess.tlsInspectionPolicySettings" })
    error_message = "settings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["policyRules"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.networkaccess.policyRule" }])
    error_message = "policyRules must preserve typed values and omit nested nulls."
  }
}
