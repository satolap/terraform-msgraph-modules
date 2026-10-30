# Credentialed live suite only. Fixture state is retained privately on failed cleanup.

run "create" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.scope.query == output.expected.group_query,
      output.item.reviewers[0].query == output.expected.reviewer_query,
      output.item.settings.autoApplyDecisionsEnabled == false,
      output.item.settings.defaultDecisionEnabled == false,
      output.item.settings.mailNotificationsEnabled == false,
      output.item.settings.reminderNotificationsEnabled == false,
      output.members_unchanged,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "update" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    description = "Updated by terraform test; safe to delete"
  }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.scope.query == output.expected.group_query,
      output.item.reviewers[0].query == output.expected.reviewer_query,
      output.item.settings.autoApplyDecisionsEnabled == false,
      output.item.settings.defaultDecisionEnabled == false,
      output.item.settings.mailNotificationsEnabled == false,
      output.item.settings.reminderNotificationsEnabled == false,
      output.members_unchanged,
      output.id == run.create.id,
      output.item.descriptionForAdmins == "Updated by terraform test; safe to delete",
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "destroy_definition" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    enabled    = false
    removed_id = run.create.id
  }
  assert {
    condition = alltrue([
      output.absent,
      output.members_unchanged,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}
