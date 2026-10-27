mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "99999999-9999-9999-9999-999999999999"
    }
  }
}

variables {
  display_name              = "Quarterly review of the owned group"
  description_for_admins    = "Offline fixture"
  description_for_reviewers = "No decisions are applied"
  group_id                  = "11111111-1111-1111-1111-111111111111"
  reviewer_user_ids         = ["22222222-2222-2222-2222-222222222222"]
  start_date                = "2030-01-15"
  recurrence = {
    type     = "weekly"
    interval = 1
  }
  instance_duration_in_days = 7
}

run "sends_the_full_writable_object_by_put" {
  command = apply

  assert {
    condition     = msgraph_resource.this.update_method == "PUT" && msgraph_resource.this.url == "identityGovernance/accessReviews/definitions"
    error_message = "The definition must be updated with a PUT of the collection's item."
  }

  assert {
    condition = alltrue([
      for k in ["displayName", "descriptionForAdmins", "descriptionForReviewers", "scope", "reviewers", "fallbackReviewers", "settings"] :
      contains(keys(msgraph_resource.this.body), k)
    ])
    error_message = "Every managed writable property must be in the body, because a PUT needs the whole object."
  }

  assert {
    condition = (
      msgraph_resource.this.body.scope["@odata.type"] == "#microsoft.graph.accessReviewQueryScope" &&
      msgraph_resource.this.body.scope.query == "/groups/11111111-1111-1111-1111-111111111111/transitiveMembers" &&
      msgraph_resource.this.body.scope.queryType == "MicrosoftGraph"
    )
    error_message = "The scope must be the group's transitiveMembers query scope."
  }

  assert {
    condition     = msgraph_resource.this.body.reviewers == [{ query = "/users/22222222-2222-2222-2222-222222222222", queryType = "MicrosoftGraph" }] && msgraph_resource.this.body.fallbackReviewers == []
    error_message = "Reviewers must be the named user and fallback reviewers an explicit empty list."
  }
}

run "keeps_every_safety_switch_off" {
  command = apply

  assert {
    condition = (
      msgraph_resource.this.body.settings.autoApplyDecisionsEnabled == false &&
      msgraph_resource.this.body.settings.defaultDecisionEnabled == false &&
      msgraph_resource.this.body.settings.mailNotificationsEnabled == false &&
      msgraph_resource.this.body.settings.reminderNotificationsEnabled == false &&
      msgraph_resource.this.body.settings.decisionHistoriesForReviewersEnabled == false
    )
    error_message = "Automatic apply, default decisions and mail and reminder automation must be explicitly false."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.this.body.settings), "applyActions") && !contains(keys(msgraph_resource.this.body.settings), "defaultDecision")
    error_message = "The module must not send applyActions or defaultDecision."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.this.body), "stageSettings") && !contains(keys(msgraph_resource.this.body), "instanceEnumerationScope")
    error_message = "Stages and instanceEnumerationScope are outside this module."
  }
}

run "weekly_recurrence_has_no_day_of_month_and_never_ends_by_default" {
  command = apply

  assert {
    condition     = msgraph_resource.this.body.settings.recurrence == { pattern = { type = "weekly", interval = 1 }, range = { type = "noEnd", startDate = "2030-01-15" } }
    error_message = "A weekly series without occurrences must send a noEnd range with the explicit start date and no dayOfMonth."
  }

  assert {
    condition     = msgraph_resource.this.body.settings.instanceDurationInDays == 7
    error_message = "The instance duration must be sent."
  }
}

run "monthly_recurrence_with_occurrences" {
  command = apply

  variables {
    recurrence = {
      type                  = "absoluteMonthly"
      interval              = 3
      day_of_month          = 10
      number_of_occurrences = 4
    }
    instance_duration_in_days = 14
  }

  assert {
    condition     = msgraph_resource.this.body.settings.recurrence == { pattern = { type = "absoluteMonthly", interval = 3, dayOfMonth = 10 }, range = { type = "numbered", startDate = "2030-01-15", numberOfOccurrences = 4 } }
    error_message = "A monthly numbered series must send dayOfMonth and a numbered range."
  }
}

run "direct_scope_and_two_fallbacks" {
  command = apply

  variables {
    group_id                   = "AAAAAAAA-1111-1111-1111-111111111111"
    membership_scope           = "direct"
    reviewer_user_ids          = ["22222222-2222-2222-2222-222222222222", "33333333-3333-3333-3333-333333333333"]
    fallback_reviewer_user_ids = ["44444444-4444-4444-4444-444444444444"]
    recommendations_enabled    = true
  }

  assert {
    condition     = msgraph_resource.this.body.scope.query == "/groups/aaaaaaaa-1111-1111-1111-111111111111/members" && output.scope_query == "/groups/aaaaaaaa-1111-1111-1111-111111111111/members"
    error_message = "The direct scope must use the lower-case group ID."
  }

  assert {
    condition     = length(msgraph_resource.this.body.reviewers) == 2 && length(msgraph_resource.this.body.fallbackReviewers) == 1 && msgraph_resource.this.body.settings.recommendationsEnabled == true
    error_message = "Reviewers, fallback reviewers and recommendations must follow the inputs."
  }
}

run "outputs_expose_id_group_and_reviewers" {
  command = apply

  assert {
    condition     = output.id == "99999999-9999-9999-9999-999999999999" && output.group_id == "11111111-1111-1111-1111-111111111111" && output.reviewer_user_ids == ["22222222-2222-2222-2222-222222222222"]
    error_message = "The outputs must carry the definition ID, group ID and reviewer IDs."
  }
}

run "rejects_self_review" {
  command = plan

  variables {
    reviewer_user_ids = []
  }

  expect_failures = [var.reviewer_user_ids]
}

run "rejects_a_reviewer_that_is_not_a_guid" {
  command = plan

  variables {
    reviewer_user_ids = ["not-a-guid"]
  }

  expect_failures = [var.reviewer_user_ids]
}

run "rejects_duplicate_reviewers_in_another_case" {
  command = plan

  variables {
    reviewer_user_ids = ["aaaaaaaa-2222-2222-2222-222222222222", "AAAAAAAA-2222-2222-2222-222222222222"]
  }

  expect_failures = [var.reviewer_user_ids]
}

run "rejects_a_user_who_is_reviewer_and_fallback" {
  command = plan

  variables {
    fallback_reviewer_user_ids = ["22222222-2222-2222-2222-222222222222"]
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_a_group_id_that_is_not_a_guid" {
  command = plan

  variables {
    group_id = "my-group"
  }

  expect_failures = [var.group_id]
}

run "rejects_an_unknown_membership_scope" {
  command = plan

  variables {
    membership_scope = "owners"
  }

  expect_failures = [var.membership_scope]
}

run "rejects_an_impossible_start_date" {
  command = plan

  variables {
    start_date = "2030-02-31"
  }

  expect_failures = [var.start_date]
}

run "rejects_a_start_date_that_is_a_timestamp" {
  command = plan

  variables {
    start_date = "2030-01-15T00:00:00Z"
  }

  expect_failures = [var.start_date]
}

run "rejects_monthly_without_day_of_month" {
  command = plan

  variables {
    recurrence = {
      type     = "absoluteMonthly"
      interval = 1
    }
  }

  expect_failures = [var.recurrence]
}

run "rejects_weekly_with_day_of_month" {
  command = plan

  variables {
    recurrence = {
      type         = "weekly"
      interval     = 1
      day_of_month = 5
    }
  }

  expect_failures = [var.recurrence]
}

run "rejects_an_unsupported_recurrence_type" {
  command = plan

  variables {
    recurrence = {
      type     = "daily"
      interval = 1
    }
  }

  expect_failures = [var.recurrence]
}

run "rejects_zero_occurrences" {
  command = plan

  variables {
    recurrence = {
      type                  = "weekly"
      interval              = 1
      number_of_occurrences = 0
    }
  }

  expect_failures = [var.recurrence]
}

run "rejects_a_weekly_instance_longer_than_a_week" {
  command = plan

  variables {
    instance_duration_in_days = 8
  }

  expect_failures = [var.instance_duration_in_days]
}

run "rejects_empty_descriptions" {
  command = plan

  variables {
    description_for_admins = " "
  }

  expect_failures = [var.description_for_admins]
}

run "rejects_an_invalid_timeout" {
  command = plan

  variables {
    timeouts = { create = "0m" }
  }

  expect_failures = [var.timeouts]
}

run "rejects_a_reviewer_description_over_256_characters" {
  command = plan

  variables {
    description_for_reviewers = join("", [for i in range(257) : "x"])
  }

  expect_failures = [var.description_for_reviewers]
}

run "accepts_a_reviewer_description_of_exactly_256_characters" {
  command = plan

  variables {
    description_for_reviewers = join("", [for i in range(256) : "x"])
  }
}

run "rejects_a_monthly_instance_longer_than_the_recurrence" {
  command = plan

  variables {
    recurrence = {
      type         = "absoluteMonthly"
      interval     = 1
      day_of_month = 1
    }
    instance_duration_in_days = 29
  }

  expect_failures = [var.instance_duration_in_days]
}

run "accepts_a_two_weekly_instance_of_fourteen_days" {
  command = plan

  variables {
    recurrence = {
      type     = "weekly"
      interval = 2
    }
    instance_duration_in_days = 14
  }
}

# The runs below share the state of the apply runs above in file order: the last
# apply created the definition with id 99999999-..., and an update keeps that id.

run "a_second_apply_updates_the_same_definition_in_place" {
  command = apply

  variables {
    display_name                       = "Renamed review"
    reviewer_user_ids                  = ["22222222-2222-2222-2222-222222222222", "33333333-3333-3333-3333-333333333333"]
    justification_required_on_approval = true
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "aaaaaaaa-0000-0000-0000-000000000001"
    }
  }

  assert {
    condition     = output.id == "99999999-9999-9999-9999-999999999999"
    error_message = "A change of name, reviewers or settings must update the definition in place and keep its id."
  }

  assert {
    condition = (
      msgraph_resource.this.body.displayName == "Renamed review" &&
      length(msgraph_resource.this.body.reviewers) == 2 &&
      msgraph_resource.this.body.settings.justificationRequiredOnApproval == true &&
      msgraph_resource.this.body.settings.autoApplyDecisionsEnabled == false
    )
    error_message = "The update must send the complete body, safety switches included."
  }
}

run "a_changed_group_replaces_the_definition" {
  command = apply

  variables {
    group_id = "55555555-5555-5555-5555-555555555555"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "bbbbbbbb-0000-0000-0000-000000000002"
    }
  }

  assert {
    condition     = output.id == "bbbbbbbb-0000-0000-0000-000000000002"
    error_message = "A change of group_id must replace the definition, because Graph's update table does not list scope."
  }
}

run "a_changed_membership_scope_replaces_the_definition" {
  command = apply

  variables {
    group_id         = "55555555-5555-5555-5555-555555555555"
    membership_scope = "direct"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "cccccccc-0000-0000-0000-000000000003"
    }
  }

  assert {
    condition     = output.id == "cccccccc-0000-0000-0000-000000000003" && msgraph_resource.this.body.scope.query == "/groups/55555555-5555-5555-5555-555555555555/members"
    error_message = "A change of membership_scope must replace the definition."
  }
}

run "an_unchanged_scope_does_not_replace_the_definition" {
  command = apply

  variables {
    group_id         = "55555555-5555-5555-5555-555555555555"
    membership_scope = "direct"
    display_name     = "Renamed again"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "dddddddd-0000-0000-0000-000000000004"
    }
  }

  assert {
    condition     = output.id == "cccccccc-0000-0000-0000-000000000003"
    error_message = "A rename with the same scope must keep the definition's id."
  }
}
