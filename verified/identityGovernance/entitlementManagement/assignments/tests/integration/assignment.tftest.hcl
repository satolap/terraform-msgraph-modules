# Credentialed live suite only. Fixture state is retained privately on failed cleanup.

run "create" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.state == "delivered",
      output.item.target.objectId == output.expected.target,
      output.item.accessPackage.id == output.expected.package,
      output.item.assignmentPolicy.id == output.expected.policy,
      output.member_present,
      output.membership_complete,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "unchanged" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.state == "delivered",
      output.item.target.objectId == output.expected.target,
      output.item.accessPackage.id == output.expected.package,
      output.item.assignmentPolicy.id == output.expected.policy,
      output.member_present,
      output.membership_complete,
      output.id == run.create.id,
      output.request_id == run.create.request_id,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "destroy_assignment" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    enabled    = false
    removed_id = run.create.id
  }
  assert {
    condition = alltrue([
      output.absent,
      !output.member_present,
      output.membership_complete,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}
