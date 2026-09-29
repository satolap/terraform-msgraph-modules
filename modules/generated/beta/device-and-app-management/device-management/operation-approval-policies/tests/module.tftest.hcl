# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/operationApprovalPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["approverGroupIds", "description", "displayName", "policyPlatform", "policySet", "policyType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description        = "example"
    policy_set         = {}
    approver_group_ids = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["policySet"]) == jsonencode({ "@odata.type" = "#microsoft.graph.operationApprovalPolicySet" })
    error_message = "policySet must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["approverGroupIds"]) == jsonencode(["example"])
    error_message = "approverGroupIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    policy_platform = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.policy_platform]
}

run "flags_enum_combination" {
  command = plan

  variables {
    policy_platform = "notApplicable, AndroidDeviceAdministrator"
  }

  assert {
    condition     = msgraph_resource.this.body["policyPlatform"] == "notApplicable, AndroidDeviceAdministrator"
    error_message = "policyPlatform must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    policy_platform = "notApplicable,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.policy_platform]
}
