mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name = "Standard request policy"
      }
    }
  }
}

run "rejects_negative_expiration" {
  command = plan
  variables {
    expiration = { type = "afterDuration", duration_days = -1 }
  }
  expect_failures = [var.expiration]
}

run "rejects_fractional_expiration" {
  command = plan
  variables {
    expiration = { type = "afterDuration", duration_days = 1.5 }
  }
  expect_failures = [var.expiration]
}

run "rejects_conflicting_expiration" {
  command = plan
  variables {
    expiration = { type = "noExpiration", duration_days = 30 }
  }
  expect_failures = [var.expiration]
}

run "rejects_update_approval_without_stages" {
  command = plan
  variables {
    request_approval_settings = { is_approval_required_for_update = true }
  }
  expect_failures = [var.request_approval_settings]
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

run "creates_policy_with_defaults" {
  command = apply

  assert {
    condition     = msgraph_resource.assignment_policy.url == "identityGovernance/entitlementManagement/assignmentPolicies"
    error_message = "Policy must be created against the assignmentPolicies endpoint."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.update_method == "PUT"
    error_message = "assignmentPolicies updates must use PUT — Graph does not implement PATCH here."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.accessPackage.id == "77777777-7777-7777-7777-777777777777"
    error_message = "The access package must be referenced by id."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.allowedTargetScope == "notSpecified"
    error_message = "allowedTargetScope must default to notSpecified."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.expiration.type == "noExpiration"
    error_message = "expiration must default to noExpiration."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestApprovalSettings.isApprovalRequiredForAdd == false
    error_message = "Approval must be off by default."
  }
}

run "builds_full_policy_body" {
  command = apply

  variables {
    allowed_target_scope = "specificDirectoryUsers"

    specific_allowed_targets = [
      { type = "groupMembers", id = "33333333-3333-3333-3333-333333333333", description = "Engineering" },
      { type = "attributeRuleMembers", membership_rule = "user.department -eq \"Engineering\"" },
    ]

    expiration = {
      type          = "afterDuration"
      duration_days = 180
    }

    requestor_settings = {
      enable_targets_to_self_add_access = true
    }

    request_approval_settings = {
      is_approval_required_for_add        = true
      is_requestor_justification_required = true

      stages = [
        {
          approval_timeout_in_days   = 14
          is_escalation_enabled      = true
          escalation_timeout_in_days = 7
          primary_approvers = [
            { type = "singleUser", id = "22222222-2222-2222-2222-222222222222" },
            { type = "requestorManager" },
          ]
          escalation_approvers = [
            { type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" },
          ]
        },
      ]
    }

    questions = [
      { text = "Why do you need this access?", is_required = true, sequence = 1 },
    ]
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.expiration.duration == "P180D"
    error_message = "Duration days must be encoded as an ISO 8601 duration."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.specificAllowedTargets[0]["@odata.type"] == "#microsoft.graph.groupMembers"
    error_message = "Subject sets must carry their @odata.type."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.specificAllowedTargets[0].groupId == "33333333-3333-3333-3333-333333333333"
    error_message = "groupMembers targets must map id to groupId."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.specificAllowedTargets[1].membershipRule == "user.department -eq \"Engineering\""
    error_message = "attributeRuleMembers targets must carry their membershipRule."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestorSettings.enableTargetsToSelfAddAccess == true
    error_message = "Requestor settings must be passed through."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestApprovalSettings.isRequestorJustificationRequired == true
    error_message = "isRequestorJustificationRequired must be passed through."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestApprovalSettings.stages[0].durationBeforeAutomaticDenial == "P14D"
    error_message = "Approval timeout must be encoded as an ISO 8601 duration."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestApprovalSettings.stages[0].durationBeforeEscalation == "P7D"
    error_message = "Escalation timeout must be encoded as an ISO 8601 duration."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestApprovalSettings.stages[0].primaryApprovers[0].userId == "22222222-2222-2222-2222-222222222222"
    error_message = "singleUser approvers must map id to userId."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.requestApprovalSettings.stages[0].primaryApprovers[1]["@odata.type"] == "#microsoft.graph.requestorManager"
    error_message = "requestorManager approvers must carry their @odata.type."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.questions[0]["@odata.type"] == "#microsoft.graph.accessPackageTextInputQuestion"
    error_message = "Questions must be typed as accessPackageTextInputQuestion."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.questions[0].text == "Why do you need this access?"
    error_message = "Question text must be a plain string (v1.0 shape)."
  }
}

run "rejects_invalid_target_scope" {
  command = plan

  variables {
    allowed_target_scope = "everyone"
  }

  expect_failures = [var.allowed_target_scope]
}

run "rejects_after_duration_without_days" {
  command = plan

  variables {
    expiration = {
      type = "afterDuration"
    }
  }

  expect_failures = [var.expiration]
}

run "rejects_approval_without_stages" {
  command = plan

  variables {
    request_approval_settings = {
      is_approval_required_for_add = true
      stages                       = []
    }
  }

  expect_failures = [var.request_approval_settings]
}

run "rejects_invalid_approver_type" {
  command = plan

  variables {
    request_approval_settings = {
      is_approval_required_for_add = true
      stages = [
        {
          primary_approvers = [
            { type = "connectedOrganizationMembers", id = "99999999-9999-9999-9999-999999999999" },
          ]
        },
      ]
    }
  }

  expect_failures = [var.request_approval_settings]
}

run "rejects_invalid_specific_target_type" {
  command = plan

  variables {
    specific_allowed_targets = [
      { type = "everyoneInDirectory" },
    ]
  }

  expect_failures = [var.specific_allowed_targets]
}
