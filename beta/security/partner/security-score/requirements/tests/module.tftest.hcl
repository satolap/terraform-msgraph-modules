# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/partner/securityScore/requirements"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionUrl", "complianceStatus", "helpUrl", "maxScore", "requirementType", "score", "state", "updatedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action_url = "example"
    max_score  = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionUrl"]) == jsonencode("example")
    error_message = "actionUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["maxScore"]) == jsonencode(0)
    error_message = "maxScore must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    compliance_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.compliance_status]
}
