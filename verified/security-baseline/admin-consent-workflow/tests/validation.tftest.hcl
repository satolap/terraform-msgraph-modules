# Input validation and response validation. Every run plans against the same mocked policy.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        skus      = []
        policy = {
          id                    = "00000000-0000-4000-8000-0000000000aa"
          version               = 3
          isEnabled             = false
          notifyReviewers       = false
          remindersEnabled      = false
          requestDurationInDays = 7
          reviewers             = []
        }
      }
    }
  }

  mock_resource "msgraph_update_resource" {
    defaults = {
      output = {
        policy = {
          version               = 4
          isEnabled             = true
          notifyReviewers       = true
          remindersEnabled      = true
          requestDurationInDays = 30
          reviewers             = []
        }
      }
    }
  }
}

variables {
  tier              = "free"
  reviewer_user_ids = ["00000000-0000-4000-8000-000000000010"]
}

run "rejects_enabled_without_reviewers" {
  command = plan

  variables {
    reviewer_user_ids = []
  }

  expect_failures = [msgraph_update_resource.this]
}

run "rejects_enabled_with_empty_groups_and_users" {
  command = plan

  variables {
    reviewer_user_ids  = []
    reviewer_group_ids = []
    enabled            = true
  }

  expect_failures = [msgraph_update_resource.this]
}

run "rejects_malformed_user_id" {
  command = plan

  variables {
    reviewer_user_ids = ["admin@contoso.onmicrosoft.com"]
  }

  expect_failures = [var.reviewer_user_ids]
}

run "rejects_uppercase_user_id" {
  command = plan

  variables {
    reviewer_user_ids = ["AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"]
  }

  expect_failures = [var.reviewer_user_ids]
}

run "rejects_malformed_group_id" {
  command = plan

  variables {
    reviewer_group_ids = ["Consent reviewers"]
  }

  expect_failures = [var.reviewer_group_ids]
}

run "rejects_uppercase_group_id" {
  command = plan

  variables {
    reviewer_group_ids = ["AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"]
  }

  expect_failures = [var.reviewer_group_ids]
}

run "rejects_duplicate_user_ids" {
  command = plan

  variables {
    reviewer_user_ids = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000010"]
  }

  expect_failures = [var.reviewer_user_ids]
}

run "rejects_duplicate_group_ids" {
  command = plan

  variables {
    reviewer_group_ids = ["00000000-0000-4000-8000-000000000030", "00000000-0000-4000-8000-000000000030"]
  }

  expect_failures = [var.reviewer_group_ids]
}

run "rejects_duration_zero" {
  command = plan

  variables {
    request_duration_in_days = 0
  }

  expect_failures = [var.request_duration_in_days]
}

run "rejects_duration_31" {
  command = plan

  variables {
    request_duration_in_days = 31
  }

  expect_failures = [var.request_duration_in_days]
}

run "rejects_fractional_duration" {
  command = plan

  variables {
    request_duration_in_days = 2.5
  }

  expect_failures = [var.request_duration_in_days]
}

run "rejects_unknown_tier" {
  command = plan

  variables {
    tier = "auto"
  }

  expect_failures = [var.tier]
}

# No snapshot can exist when the policy cannot be read: the plan fails before any write.
run "rejects_restore_when_policy_unreadable" {
  command = plan

  variables {
    restore_previous_state = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {}
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

# A restore needs a snapshot to send.
run "rejects_restore_without_snapshot" {
  command = plan

  variables {
    restore_previous_state = true
  }

  override_resource {
    target          = terraform_data.previous_state
    override_during = plan
    values = {
      output = null
    }
  }

  expect_failures = [msgraph_update_resource.this]
}

run "rejects_response_without_policy" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {}
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_response_with_missing_property" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = { isEnabled = false, notifyReviewers = false, remindersEnabled = false, reviewers = [] }
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_response_with_non_boolean_flag" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = { isEnabled = "yes", notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 7, reviewers = [] }
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_response_with_fractional_duration" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = { isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 2.5, reviewers = [] }
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_response_with_malformed_reviewer" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = { isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 7, reviewers = [{ queryType = "MicrosoftGraph" }] }
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_response_with_null_reviewer_query" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = { isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 7, reviewers = [{ query = null, queryType = "MicrosoftGraph" }] }
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_response_with_null_reviewer_query_type" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = { isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 7, reviewers = [{ query = "/users/00000000-0000-4000-8000-000000000099", queryType = null }] }
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}
