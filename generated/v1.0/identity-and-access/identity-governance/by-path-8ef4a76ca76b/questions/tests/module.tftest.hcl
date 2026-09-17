# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_assignment_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/assignmentPolicies/test-parent-id/questions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isAnswerEditable", "isRequired", "localizations", "sequence", "text"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_assignment_policy_id = "test-parent-id"
    text                                = "example"
    is_answer_editable                  = false
    sequence                            = -2147483648
    localizations                       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["text"]) == jsonencode("example")
    error_message = "text must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAnswerEditable"]) == jsonencode(false)
    error_message = "isAnswerEditable must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sequence"]) == jsonencode(-2147483648)
    error_message = "sequence must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["localizations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.accessPackageLocalizedText" }])
    error_message = "localizations must preserve typed values and omit nested nulls."
  }
}
