# A caller that upgrades from v4.0.0 and still spells a nested attribute in snake_case must
# fail at plan time: Terraform would otherwise drop the unknown key and fall back to the
# default (approval off, review off, ...). expect_failures does not read the message.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        custom_extension_stage_settings = []
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  displayName       = "Standard request policy"
}

run "specific_allowed_targets_accepts_the_graph_names" {
  command = apply
  variables {
    allowedTargetScope       = "specificDirectoryUsers"
    specific_allowed_targets = [{ type = "attributeRuleMembers", membershipRule = "user.department -eq \"Engineering\"" }]
  }
}

run "specific_allowed_targets_accepts_explicit_null_legacy_names" {
  command = apply
  variables {
    allowedTargetScope       = "specificDirectoryUsers"
    specific_allowed_targets = [{ type = "attributeRuleMembers", membershipRule = "user.department -eq \"Engineering\"", membership_rule = null }]
  }
}

run "specific_allowed_targets_rejects_membership_rule" {
  command = plan
  variables {
    allowedTargetScope       = "specificDirectoryUsers"
    specific_allowed_targets = [{ type = "attributeRuleMembers", membershipRule = "user.department -eq \"Engineering\"", membership_rule = true }]
  }
  expect_failures = [var.specific_allowed_targets]
}

run "expiration_accepts_the_graph_names" {
  command = apply
  variables {
    expiration = { type = "afterDuration", duration_days = 5 }
  }
}

run "expiration_accepts_explicit_null_legacy_names" {
  command = apply
  variables {
    expiration = { type = "afterDuration", duration_days = 5, end_date_time = null }
  }
}

run "expiration_rejects_end_date_time" {
  command = plan
  variables {
    expiration = { type = "afterDuration", duration_days = 5, end_date_time = true }
  }
  expect_failures = [var.expiration]
}

run "requestor_settings_accepts_the_graph_names" {
  command = apply
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true }
  }
}

run "requestor_settings_accepts_explicit_null_legacy_names" {
  command = apply
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, allow_custom_assignment_schedule = null, enable_on_behalf_requestors_to_add_access = null, enable_on_behalf_requestors_to_remove_access = null, enable_on_behalf_requestors_to_update_access = null, enable_targets_to_self_add_access = null, enable_targets_to_self_remove_access = null, enable_targets_to_self_update_access = null, on_behalf_requestors = null }
  }
}

run "requestor_settings_rejects_allow_custom_assignment_schedule" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, allow_custom_assignment_schedule = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_enable_on_behalf_requestors_to_add_access" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, enable_on_behalf_requestors_to_add_access = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_enable_on_behalf_requestors_to_remove_access" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, enable_on_behalf_requestors_to_remove_access = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_enable_on_behalf_requestors_to_update_access" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, enable_on_behalf_requestors_to_update_access = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_enable_targets_to_self_add_access" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, enable_targets_to_self_add_access = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_enable_targets_to_self_remove_access" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, enable_targets_to_self_remove_access = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_enable_targets_to_self_update_access" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, enable_targets_to_self_update_access = true }
  }
  expect_failures = [var.requestor_settings]
}

run "requestor_settings_rejects_on_behalf_requestors" {
  command = plan
  variables {
    requestor_settings = { enableTargetsToSelfAddAccess = true, on_behalf_requestors = true }
  }
  expect_failures = [var.requestor_settings]
}

run "request_approval_settings_accepts_the_graph_names" {
  command = apply
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }] }]
    }
  }
}

run "request_approval_settings_accepts_explicit_null_legacy_names" {
  command = apply
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true, is_approval_required_for_add = null, is_approval_required_for_update = null, is_requestor_justification_required = null
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], approver_information_visibility = null, escalation_approvers = null, fallback_escalation_approvers = null, fallback_primary_approvers = null, is_approver_justification_required = null, is_escalation_enabled = null }]
    }
  }
}

run "request_approval_settings_rejects_is_approval_required_for_add" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true, is_approval_required_for_add = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }] }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_is_approval_required_for_update" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true, is_approval_required_for_update = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }] }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_is_requestor_justification_required" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true, is_requestor_justification_required = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }] }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_approver_information_visibility" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], approver_information_visibility = true }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_escalation_approvers" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], escalation_approvers = true }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_fallback_escalation_approvers" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], fallback_escalation_approvers = true }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_fallback_primary_approvers" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], fallback_primary_approvers = true }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_is_approver_justification_required" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], is_approver_justification_required = true }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "request_approval_settings_rejects_is_escalation_enabled" {
  command = plan
  variables {
    request_approval_settings = {
      isApprovalRequiredForAdd = true
      stages                   = [{ primaryApprovers = [{ type = "requestorManager" }], is_escalation_enabled = true }]
    }
  }
  expect_failures = [var.request_approval_settings]
}

run "questions_accepts_the_graph_names" {
  command = apply
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1 }]
  }
}

run "questions_accepts_explicit_null_legacy_names" {
  command = apply
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1, is_answer_editable = null, is_multiple_selection_allowed = null, is_required = null, is_single_line_question = null, regex_pattern = null }]
  }
}

run "questions_rejects_is_answer_editable" {
  command = plan
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1, is_answer_editable = true }]
  }
  expect_failures = [var.questions]
}

run "questions_rejects_is_multiple_selection_allowed" {
  command = plan
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1, is_multiple_selection_allowed = true }]
  }
  expect_failures = [var.questions]
}

run "questions_rejects_is_required" {
  command = plan
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1, is_required = true }]
  }
  expect_failures = [var.questions]
}

run "questions_rejects_is_single_line_question" {
  command = plan
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1, is_single_line_question = true }]
  }
  expect_failures = [var.questions]
}

run "questions_rejects_regex_pattern" {
  command = plan
  variables {
    questions = [{ text = "Why do you need this access?", isRequired = true, sequence = 1, regex_pattern = true }]
  }
  expect_failures = [var.questions]
}

run "review_settings_accepts_the_graph_names" {
  command = apply
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
}

run "review_settings_accepts_explicit_null_legacy_names" {
  command = apply
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, fallback_reviewers = null, is_enabled = null, is_recommendation_enabled = null, is_reviewer_justification_required = null, is_self_review = null, primary_reviewers = null
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2, day_of_month = null, number_of_occurrences = null }
      }
    }
  }
}

run "review_settings_rejects_fallback_reviewers" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, fallback_reviewers = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_is_enabled" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, is_enabled = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_is_recommendation_enabled" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, is_recommendation_enabled = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_is_reviewer_justification_required" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, is_reviewer_justification_required = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_is_self_review" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, is_self_review = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_primary_reviewers" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true, primary_reviewers = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_day_of_month" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2, day_of_month = true }
      }
    }
  }
  expect_failures = [var.review_settings]
}

run "review_settings_rejects_number_of_occurrences" {
  command = plan
  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      isSelfReview       = true
      schedule = {
        startDateTime    = "2026-11-02T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 2, number_of_occurrences = true }
      }
    }
  }
  expect_failures = [var.review_settings]
}
