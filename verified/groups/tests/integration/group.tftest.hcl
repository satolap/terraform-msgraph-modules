# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with Group.ReadWrite.All.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_group" {
  command = apply

  variables {
    display_name  = "tftest-group-${run.setup.suffix}"
    mail_nickname = "tftest-group-${run.setup.suffix}"
    description   = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID object id for the created group."
  }

  assert {
    condition     = output.display_name == "tftest-group-${run.setup.suffix}"
    error_message = "The created group must carry the requested display name."
  }
}

# Exercises the update (PATCH) path against the real API.
run "rename_group" {
  command = apply

  variables {
    display_name  = "tftest-group-${run.setup.suffix}-renamed"
    mail_nickname = "tftest-group-${run.setup.suffix}"
    description   = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = output.display_name == "tftest-group-${run.setup.suffix}-renamed"
    error_message = "Renaming the group in place (PATCH) must be reflected in the response."
  }
}

# Learn lists "DynamicMembership" in groupTypes as changeable on an existing
# group (static to dynamic and back) but does not list mailEnabled or "Unified"
# as updatable (GB-directory-objects-519, -520). These runs record what Graph
# does for the documented conversion. Dynamic membership needs Microsoft Entra
# ID P1; the rule matches no user, so no member is added.
run "make_group_dynamic" {
  command = apply

  variables {
    display_name    = "tftest-group-${run.setup.suffix}-renamed"
    mail_nickname   = "tftest-group-${run.setup.suffix}"
    description     = "Created by terraform test; safe to delete"
    group_types     = ["DynamicMembership"]
    membership_rule = "user.department -eq \"tftest-${run.setup.suffix}-nobody\""
  }

  assert {
    condition     = output.id == run.rename_group.id
    error_message = "Adding DynamicMembership with a membership rule must PATCH the existing group, not replace it."
  }
}

# An ignored PATCH would keep the id, so read the group back from Graph.
run "read_back_dynamic_group" {
  module {
    source = "./tests/integration/readback"
  }

  variables {
    group_id  = run.make_group_dynamic.id
    run_label = "dynamic"
  }

  assert {
    condition     = output.id == run.rename_group.id
    error_message = "The read-back must return the same group."
  }

  assert {
    condition     = contains(output.group_types, "DynamicMembership")
    error_message = "Graph must store DynamicMembership in groupTypes after the PATCH."
  }

  assert {
    condition     = output.membership_rule == "user.department -eq \"tftest-${run.setup.suffix}-nobody\""
    error_message = "Graph must store the membership rule sent with the PATCH."
  }

  assert {
    condition     = try(lower(output.membership_rule_processing_state), "") == "on"
    error_message = "Graph must report membership rule processing as On."
  }
}

run "make_group_static_again" {
  command = apply

  variables {
    display_name  = "tftest-group-${run.setup.suffix}-renamed"
    mail_nickname = "tftest-group-${run.setup.suffix}"
    description   = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = output.id == run.rename_group.id
    error_message = "Removing DynamicMembership must PATCH the existing group, not replace it."
  }
}

run "read_back_static_group" {
  module {
    source = "./tests/integration/readback"
  }

  variables {
    group_id  = run.make_group_static_again.id
    run_label = "static"
  }

  assert {
    condition     = output.id == run.rename_group.id
    error_message = "The read-back must return the same group."
  }

  assert {
    condition     = !contains(output.group_types, "DynamicMembership")
    error_message = "Graph must drop DynamicMembership from groupTypes after the PATCH."
  }

  assert {
    condition     = output.mail_enabled == false
    error_message = "The group must stay not mail-enabled."
  }

  # Learn does not say what happens to membershipRule and
  # membershipRuleProcessingState when DynamicMembership is removed, so they are
  # not asserted. The helper outputs membership_rule and
  # membership_rule_processing_state; `terraform test -verbose` prints them for
  # the owner to record in GB-directory-objects-520.
}

# The module refuses these two changes at plan time, because Learn does not
# list them as updatable and a PATCH may be refused or ignored.
run "refuse_converting_to_microsoft_365" {
  command = plan

  variables {
    display_name  = "tftest-group-${run.setup.suffix}-renamed"
    mail_nickname = "tftest-group-${run.setup.suffix}"
    group_types   = ["Unified"]
    mail_enabled  = true
  }

  expect_failures = [msgraph_resource.group]
}

# A mail_enabled change alone is refused by the mail/security precondition that
# also applies to a new group, so it needs no run of its own here.
