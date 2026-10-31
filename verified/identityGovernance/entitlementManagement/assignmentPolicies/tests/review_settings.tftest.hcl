# Access reviews of the assignments made through the policy (reviewSettings). The key
# is sent only when review_settings is set; request_body_compatibility.tftest.hcl
# proves that the body without it is unchanged. Validations use expect_failures, which
# does not read the message, so tests/test_assignment_policy_reviews_questions.py
# checks the wording.
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

run "leaves_review_settings_out_by_default" {
  command = apply

  assert {
    condition     = !contains(keys(msgraph_resource.assignment_policy.body), "reviewSettings")
    error_message = "reviewSettings must not be sent when review_settings is null."
  }
}

run "leaves_review_settings_out_for_an_explicit_null" {
  command = apply

  variables {
    review_settings = null
  }

  assert {
    condition     = !contains(keys(msgraph_resource.assignment_policy.body), "reviewSettings")
    error_message = "An explicit null must mean the same as the default."
  }
}

# Quarterly reviews by a group that remove access when nobody responds: the body is
# the documented accessPackageAssignmentReviewSettings shape, with the defaults of the
# optional flags made explicit.
run "sends_quarterly_reviews_by_a_group" {
  command = apply

  variables {
    allowedTargetScope       = "specificConnectedOrganizationUsers"
    specific_allowed_targets = [{ type = "connectedOrganizationMembers", id = "55555555-5555-5555-5555-555555555555" }]
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body.reviewSettings) == jsonencode({
      isEnabled                       = true
      expirationBehavior              = "removeAccess"
      isRecommendationEnabled         = true
      isReviewerJustificationRequired = true
      isSelfReview                    = false
      primaryReviewers = [
        { "@odata.type" = "#microsoft.graph.groupMembers", groupId = "33333333-3333-3333-3333-333333333333" },
      ]
      fallbackReviewers = []
      schedule = {
        startDateTime = "2026-11-01T00:00:00Z"
        expiration    = { duration = "P25D", type = "afterDuration" }
        recurrence = {
          pattern = { dayOfMonth = 1, interval = 3, type = "absoluteMonthly" }
          range   = { type = "noEnd", numberOfOccurrences = 0 }
        }
      }
    })
    error_message = "Quarterly group reviews must send the complete reviewSettings object with the documented property names."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.update_method == "PUT"
    error_message = "The policy must still be updated with a full-body PUT."
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == "[]" && length(msgraph_resource.assignment_policy.body.questions) == 0
    error_message = "reviewSettings must be added next to the other keys, not replace them."
  }
}

run "sends_every_flag_reviewer_and_recurrence_setting" {
  command = apply

  variables {
    review_settings = {
      isEnabled                       = true
      expirationBehavior              = "acceptAccessRecommendation"
      isRecommendationEnabled         = false
      isReviewerJustificationRequired = false
      isSelfReview                    = false
      primaryReviewers = [
        { type = "singleUser", id = "22222222-2222-2222-2222-222222222222" },
        { type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" },
      ]
      fallbackReviewers = [
        { type = "singleUser", id = "44444444-4444-4444-4444-444444444444" },
      ]
      schedule = {
        startDateTime    = "2027-01-15T08:30:00Z"
        duration_in_days = 14
        recurrence = {
          type                = "absoluteMonthly"
          interval            = 6
          dayOfMonth          = 15
          range_type          = "numbered"
          numberOfOccurrences = 4
        }
      }
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body.reviewSettings) == jsonencode({
      isEnabled                       = true
      expirationBehavior              = "acceptAccessRecommendation"
      isRecommendationEnabled         = false
      isReviewerJustificationRequired = false
      isSelfReview                    = false
      primaryReviewers = [
        { "@odata.type" = "#microsoft.graph.singleUser", userId = "22222222-2222-2222-2222-222222222222" },
        { "@odata.type" = "#microsoft.graph.groupMembers", groupId = "33333333-3333-3333-3333-333333333333" },
      ]
      fallbackReviewers = [
        { "@odata.type" = "#microsoft.graph.singleUser", userId = "44444444-4444-4444-4444-444444444444" },
      ]
      schedule = {
        startDateTime = "2027-01-15T08:30:00Z"
        expiration    = { duration = "P14D", type = "afterDuration" }
        recurrence = {
          pattern = { type = "absoluteMonthly", interval = 6, dayOfMonth = 15 }
          range   = { type = "numbered", numberOfOccurrences = 4 }
        }
      }
    })
    error_message = "Every flag, both reviewer types in order, dayOfMonth and a numbered range must be sent as configured."
  }
}

run "sends_weekly_self_reviews_without_reviewers" {
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

  assert {
    condition     = msgraph_resource.assignment_policy.body.reviewSettings.isSelfReview == true && length(msgraph_resource.assignment_policy.body.reviewSettings.primaryReviewers) == 0
    error_message = "A self-review needs no primary reviewer."
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.reviewSettings.schedule.recurrence.pattern) == jsonencode({ type = "weekly", interval = 2 })
    error_message = "A weekly pattern must send only type and interval."
  }
}

# Turning reviews off sends isEnabled false with the rest of the settings, which is
# how the module states it: a body without reviewSettings does not.
run "sends_disabled_reviews_explicitly" {
  command = apply

  variables {
    review_settings = {
      isEnabled          = false
      expirationBehavior = "keepAccess"
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.reviewSettings.isEnabled == false
    error_message = "isEnabled = false must be sent as isEnabled false."
  }
}

run "sends_the_beta_api_version_the_same_way" {
  command = apply

  variables {
    api_version = "beta"
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  assert {
    condition     = msgraph_resource.assignment_policy.api_version == "beta" && msgraph_resource.assignment_policy.body.reviewSettings.schedule.expiration.duration == "P25D"
    error_message = "The beta api_version must send the same reviewSettings."
  }
}

# Validations.
run "rejects_an_unknown_expiration_behavior" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "denyAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_the_unknown_future_value_expiration_behavior" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "unknownFutureValue"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_an_undocumented_reviewer_type" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "requestorManager", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_an_undocumented_fallback_reviewer_type" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      fallbackReviewers  = [{ type = "externalSponsors", id = "44444444-4444-4444-4444-444444444444" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_reviewer_id_that_is_not_a_guid" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "access-reviewers" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_enabled_reviews_without_a_reviewer" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      fallbackReviewers  = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_start_that_is_not_a_timestamp" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_start_with_a_utc_offset" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00+01:00"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_review_that_is_never_open" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 0
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_fractional_review_duration" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 2.5
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_pattern_that_access_reviews_do_not_support" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "relativeMonthly", interval = 3 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_zero_interval" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 0 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_fractional_interval" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 1.5 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_day_of_month_out_of_range" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3, dayOfMonth = 32 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_day_of_month_on_a_weekly_pattern" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 3
        recurrence       = { type = "weekly", interval = 1, dayOfMonth = 1 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_an_end_date_range" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3, range_type = "endDate" }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_numbered_range_without_occurrences" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3, range_type = "numbered" }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_a_numbered_range_with_zero_occurrences" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3, range_type = "numbered", numberOfOccurrences = 0 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

run "rejects_occurrences_without_a_numbered_range" {
  command = plan

  variables {
    review_settings = {
      expirationBehavior = "removeAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3, numberOfOccurrences = 4 }
      }
    }
  }

  expect_failures = [var.review_settings]
}

# Learn requires dayOfMonth with absoluteMonthly. Without dayOfMonth the day of the
# first review's start is sent; a weekly pattern takes no day.
run "derives_the_day_of_month_from_the_start_date" {
  command = apply

  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-15T08:30:00Z"
        duration_in_days = 14
        recurrence       = { type = "absoluteMonthly", interval = 1 }
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.reviewSettings.schedule.recurrence.pattern) == jsonencode({ dayOfMonth = 15, interval = 1, type = "absoluteMonthly" })
    error_message = "absoluteMonthly without dayOfMonth must send the day of startDateTime."
  }
}

run "sends_no_day_for_a_weekly_pattern" {
  command = apply

  variables {
    review_settings = {
      expirationBehavior = "keepAccess"
      primaryReviewers   = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
      schedule = {
        startDateTime    = "2026-11-15T08:30:00Z"
        duration_in_days = 5
        recurrence       = { type = "weekly", interval = 2 }
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.reviewSettings.schedule.recurrence.pattern) == jsonencode({ interval = 2, type = "weekly" })
    error_message = "A weekly pattern must carry only type and interval."
  }
}

# A reviewer group that the same apply creates has an id that is unknown at plan
# time. The GUID validation must wait for it instead of failing the plan.
run "accepts_a_reviewer_group_that_the_same_apply_creates" {
  command = apply

  module {
    source = "./tests/unknown_reviewer"
  }

  assert {
    condition     = output.id == "88888888-8888-8888-8888-888888888888"
    error_message = "Reviews by a group created in the same apply must create the policy."
  }
}
