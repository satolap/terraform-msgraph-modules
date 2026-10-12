# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    b2c_identity_user_flow_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identity/b2cUserFlows/test-parent-id/languages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["defaultPages", "isEnabled", "overridesPages"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    b2c_identity_user_flow_id = "test-parent-id"
    is_enabled                = false
    default_pages             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultPages"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.userFlowLanguagePage" }])
    error_message = "defaultPages must preserve typed values and omit nested nulls."
  }
}
