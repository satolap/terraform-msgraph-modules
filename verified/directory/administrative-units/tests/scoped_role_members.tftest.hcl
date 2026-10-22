mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id     = "22222222-2222-2222-2222-222222222222"
      output = {}
    }
  }

  mock_resource "msgraph_resource_collection" {
    defaults = {
      id     = "directory/administrativeUnits/22222222-2222-2222-2222-222222222222/members"
      output = {}
    }
  }
}

variables {
  display_name = "Contoso sales"
}

run "no_scoped_role_members_by_default" {
  command = apply

  assert {
    condition     = length(msgraph_resource.scoped_role_member) == 0 && length(output.scoped_role_member_ids) == 0
    error_message = "Without scoped_role_members the module must create no scopedRoleMembership."
  }
}

run "a_scoped_role_member_is_posted_to_the_unit" {
  command = apply

  variables {
    scoped_role_members = {
      groups_administrator = { role_id = "AAAAAAAA-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    }
  }

  assert {
    condition     = length(msgraph_resource.scoped_role_member) == 1
    error_message = "One entry must create one scopedRoleMembership."
  }

  assert {
    condition     = msgraph_resource.scoped_role_member["groups_administrator"].url == "directory/administrativeUnits/22222222-2222-2222-2222-222222222222/scopedRoleMembers" && msgraph_resource.scoped_role_member["groups_administrator"].api_version == "v1.0"
    error_message = "The assignment must be posted to the unit's scopedRoleMembers collection on v1.0."
  }

  assert {
    condition = jsonencode(msgraph_resource.scoped_role_member["groups_administrator"].body) == jsonencode({
      roleId         = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      roleMemberInfo = { id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    })
    error_message = "The body must carry the lower-cased roleId and roleMemberInfo.id and nothing else."
  }

  assert {
    condition     = length(output.scoped_role_member_ids) == 1 && contains(keys(output.scoped_role_member_ids), "groups_administrator")
    error_message = "scoped_role_member_ids must hold one entry per assignment, under the caller's key."
  }
}

run "several_entries_and_one_role_with_two_members" {
  command = apply

  variables {
    scoped_role_members = {
      first  = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
      second = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" }
      third  = { role_id = "dddddddd-dddd-4ddd-8ddd-dddddddddddd", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    }
  }

  assert {
    condition     = length(msgraph_resource.scoped_role_member) == 3
    error_message = "Each entry must be its own assignment."
  }
}

# Learn documents no update for a scoped role membership: a changed pair under
# the same key must replace the assignment, which the stand-in triggers.
run "a_changed_pair_replaces_the_assignment" {
  command = apply

  variables {
    scoped_role_members = {
      first  = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "dddddddd-dddd-4ddd-8ddd-dddddddddddd" }
      second = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" }
      third  = { role_id = "dddddddd-dddd-4ddd-8ddd-dddddddddddd", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    }
  }

  assert {
    condition     = terraform_data.scoped_role_member["first"].input.member_id == "dddddddd-dddd-4ddd-8ddd-dddddddddddd" && jsonencode(msgraph_resource.scoped_role_member["first"].body.roleMemberInfo) == jsonencode({ id = "dddddddd-dddd-4ddd-8ddd-dddddddddddd" })
    error_message = "A changed member must reach the stand-in and the request body of that entry."
  }
}

run "the_unit_body_and_members_do_not_change_with_scoped_role_members" {
  command = apply

  variables {
    member_ids = ["eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee"]
    scoped_role_members = {
      groups_administrator = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body) == jsonencode({
      description                  = null
      displayName                  = "Contoso sales"
      isMemberManagementRestricted = false
      membershipType               = "Assigned"
      visibility                   = null
    })
    error_message = "Scoped role members must not add a key to the unit's body."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.members[0].reference_ids) == jsonencode(["eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee"])
    error_message = "Scoped role members must not change the member references."
  }
}

# A dynamic unit has no assigned members, but a role can still be scoped to it.
run "a_dynamic_unit_accepts_scoped_role_members" {
  command = apply

  variables {
    membership_type = "Dynamic"
    membership_rule = "(user.department -eq \"Sales\")"
    scoped_role_members = {
      groups_administrator = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    }
  }

  assert {
    condition     = length(msgraph_resource.scoped_role_member) == 1
    error_message = "A dynamic unit must accept a scoped role member."
  }
}

# A user that the same apply creates: its id is unknown at plan time, and the
# keys are the caller's, so the plan must not fail on for_each.
run "plans_a_member_that_the_same_apply_creates" {
  command = plan

  module {
    source = "./tests/scoped_member_from_resource"
  }
}

run "assigns_a_role_to_a_member_that_the_same_apply_creates" {
  command = apply

  module {
    source = "./tests/scoped_member_from_resource"
  }

  assert {
    condition     = contains(keys(output.scoped_role_member_ids), "groups_administrator")
    error_message = "The assignment of a member created in the same apply must be created."
  }
}

# Users, groups and devices are all sent as directoryObjects/{id} references,
# so a device is named by its object ID like any other member.
run "users_groups_and_devices_are_members_by_object_id" {
  command = apply

  variables {
    member_ids = [
      "11111111-1111-4111-8111-111111111111",
      "33333333-3333-4333-8333-333333333333",
      "44444444-4444-4444-8444-444444444444",
    ]
  }

  assert {
    condition     = length(msgraph_resource_collection.members[0].reference_ids) == 3
    error_message = "A list of user, group and device object IDs must be sent as three references."
  }
}

run "rejects_a_role_id_that_is_not_a_guid" {
  command = plan

  variables {
    scoped_role_members = { bad = { role_id = "Groups Administrator", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" } }
  }

  expect_failures = [var.scoped_role_members]
}

run "rejects_a_member_id_that_is_not_a_guid" {
  command = plan

  variables {
    scoped_role_members = { bad = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "user@contoso.com" } }
  }

  expect_failures = [var.scoped_role_members]
}

run "rejects_a_pair_named_twice_in_another_case" {
  command = plan

  variables {
    scoped_role_members = {
      first  = { role_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", member_id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
      second = { role_id = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA", member_id = "BBBBBBBB-BBBB-4BBB-8BBB-BBBBBBBBBBBB" }
    }
  }

  expect_failures = [var.scoped_role_members]
}
