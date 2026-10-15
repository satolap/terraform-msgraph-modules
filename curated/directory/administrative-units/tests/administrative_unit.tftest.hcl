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

# The runs below share one state in file order: the first run creates the unit,
# later runs update or replace it. A replacement takes the id of the
# override_resource block; an in-place update keeps the id in the state.

run "assigned_unit_renders_the_full_body" {
  command = apply

  assert {
    condition     = msgraph_resource.this.url == "directory/administrativeUnits" && msgraph_resource.this.api_version == "v1.0"
    error_message = "The unit must be created in the directory/administrativeUnits collection on v1.0."
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body) == jsonencode({
      description                  = null
      displayName                  = "Contoso sales"
      isMemberManagementRestricted = false
      membershipType               = "Assigned"
      visibility                   = null
    })
    error_message = "An assigned unit must send its name, a null description and visibility, the restriction flag and the membership type, and no dynamic keys."
  }

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "A null read-back of a property that was sent must not be drift."
  }

  assert {
    condition     = length(msgraph_resource_collection.members) == 0 && output.member_ids == null
    error_message = "With member_ids null the members must not be managed."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222" && output.directory_scope_id == "/administrativeUnits/22222222-2222-2222-2222-222222222222"
    error_message = "id must come from the resource, and directory_scope_id must be /administrativeUnits/{id}."
  }

  assert {
    condition     = output.display_name == "Contoso sales" && output.is_member_management_restricted == false && output.membership_type == "Assigned" && output.visibility == null
    error_message = "The outputs must expose the configured name, restriction, membership type and visibility."
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ is_member_management_restricted = false })
    error_message = "The replace trigger must hold the restriction flag, the one value an update cannot change."
  }
}

run "description_and_visibility_update_in_place" {
  command = apply

  variables {
    display_name = "Contoso sales and marketing"
    description  = "Sales and marketing administration"
    visibility   = "HiddenMembership"
  }

  # A new object would take this id; an in-place update keeps the old one.
  override_resource {
    target = msgraph_resource.this
    values = {
      id     = "22222222-2222-2222-2222-000000000001"
      output = {}
    }
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "A name, description and visibility change must update the unit in place and keep its id."
  }

  assert {
    condition     = msgraph_resource.this.body.displayName == "Contoso sales and marketing" && msgraph_resource.this.body.description == "Sales and marketing administration" && msgraph_resource.this.body.visibility == "HiddenMembership"
    error_message = "A configured name, description and visibility must be sent."
  }

  assert {
    condition     = output.visibility == "HiddenMembership"
    error_message = "visibility must be exposed."
  }
}

# The provider's PATCH carries only changed keys and Graph keeps what a PATCH
# omits, so clearing a value needs the key in the body. Whether Microsoft Graph
# accepts the null is not verified.
run "cleared_description_and_visibility_are_sent_as_null" {
  command = apply

  assert {
    condition     = contains(keys(msgraph_resource.this.body), "description") && msgraph_resource.this.body.description == null
    error_message = "A description that is no longer configured must still be in the body, as null."
  }

  assert {
    condition     = contains(keys(msgraph_resource.this.body), "visibility") && msgraph_resource.this.body.visibility == null
    error_message = "A visibility that is no longer configured must still be in the body, as null."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Clearing the description and visibility must update the unit in place and keep its id."
  }
}

# member_ids: null leaves the members alone, a list (even an empty one) is authoritative.
run "an_empty_member_list_manages_the_members" {
  command = apply

  variables {
    member_ids = []
  }

  assert {
    condition     = length(msgraph_resource_collection.members) == 1
    error_message = "An empty member_ids must create the member collection, so that it removes every member."
  }

  assert {
    condition     = msgraph_resource_collection.members[0].url == "directory/administrativeUnits/22222222-2222-2222-2222-222222222222/members/$ref" && msgraph_resource_collection.members[0].api_version == "v1.0"
    error_message = "The members must be managed through the unit's members/$ref collection on v1.0."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.members[0].reference_ids) == "[]" && jsonencode(output.member_ids) == "[]"
    error_message = "An empty member_ids must send an empty reference list and output an empty list, not null."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Managing the members must not change the unit."
  }
}

run "member_ids_are_sent_in_lower_case" {
  command = apply

  variables {
    member_ids = [
      "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA",
      "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb",
      "cccccccc-cccc-4ccc-8ccc-cccccccccccc",
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource_collection.members[0].reference_ids) == jsonencode([
      "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
      "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb",
      "cccccccc-cccc-4ccc-8ccc-cccccccccccc",
    ])
    error_message = "Every member id must be sent in lower case, in the configured order."
  }

  assert {
    condition     = jsonencode(output.member_ids) == jsonencode(msgraph_resource_collection.members[0].reference_ids)
    error_message = "member_ids must expose the managed ids as the collection holds them."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Changing the members must not change the unit."
  }
}

# The provider compares ids as exact strings; lower-casing them means a change of
# case alone plans no change.
run "a_change_of_case_in_member_ids_keeps_the_references" {
  command = apply

  variables {
    member_ids = [
      "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
      "BBBBBBBB-BBBB-4BBB-8BBB-BBBBBBBBBBBB",
      "CCCCCCCC-CCCC-4CCC-8CCC-CCCCCCCCCCCC",
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource_collection.members[0].reference_ids) == jsonencode([
      "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
      "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb",
      "cccccccc-cccc-4ccc-8ccc-cccccccccccc",
    ])
    error_message = "IDs that differ only in case must give the same references."
  }
}

# On a real tenant, destroying the collection removes the members it holds; the
# README describes how to stop managing them without removing them.
run "null_member_ids_drop_the_member_collection" {
  command = apply

  assert {
    condition     = length(msgraph_resource_collection.members) == 0 && output.member_ids == null
    error_message = "member_ids null must drop the member collection and output null."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Dropping the member collection must not change the unit."
  }
}

# Dynamic membership. Microsoft Learn documents membershipType, membershipRule
# and membershipRuleProcessingState for create and update on v1.0.
run "a_dynamic_unit_sends_the_rule_and_processes_it" {
  command = apply

  variables {
    membership_type = "Dynamic"
    membership_rule = "(user.department -eq \"Sales\")"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id     = "22222222-2222-2222-2222-000000000002"
      output = {}
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body) == jsonencode({
      description                   = null
      displayName                   = "Contoso sales"
      isMemberManagementRestricted  = false
      membershipRule                = "(user.department -eq \"Sales\")"
      membershipRuleProcessingState = "On"
      membershipType                = "Dynamic"
      visibility                    = null
    })
    error_message = "A dynamic unit must send its rule, and \"On\" as the processing state when none is set."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222" && output.membership_type == "Dynamic"
    error_message = "Changing to dynamic membership must update the unit in place and keep its id."
  }
}

run "a_paused_rule_is_sent_as_paused" {
  command = apply

  variables {
    membership_type                  = "Dynamic"
    membership_rule                  = "(device.deviceOSType -eq \"Windows\")"
    membership_rule_processing_state = "Paused"
  }

  assert {
    condition     = msgraph_resource.this.body.membershipRuleProcessingState == "Paused" && msgraph_resource.this.body.membershipRule == "(device.deviceOSType -eq \"Windows\")"
    error_message = "A configured rule and processing state must be sent as given."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "A rule change must update the unit in place and keep its id."
  }
}

# Microsoft Learn's example of the change back to assigned sends membershipType alone.
run "returning_to_assigned_sends_only_the_membership_type" {
  command = apply

  assert {
    condition     = msgraph_resource.this.body.membershipType == "Assigned" && !contains(keys(msgraph_resource.this.body), "membershipRule") && !contains(keys(msgraph_resource.this.body), "membershipRuleProcessingState")
    error_message = "An assigned unit must send membershipType \"Assigned\" and neither the rule nor its processing state."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222" && output.membership_type == "Assigned"
    error_message = "Changing back to assigned membership must update the unit in place and keep its id."
  }
}

# Restriction is immutable. The new unit is created first and the member
# collection follows its id.
run "changing_the_restriction_replaces_the_unit" {
  command = apply

  variables {
    is_member_management_restricted = true
    member_ids                      = ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"]
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id     = "22222222-2222-2222-2222-000000000003"
      output = {}
    }
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000003"
    error_message = "A change of is_member_management_restricted must replace the unit, so the new object's id is used."
  }

  assert {
    condition     = msgraph_resource.this.body.isMemberManagementRestricted == true && output.is_member_management_restricted == true
    error_message = "A restricted unit must send isMemberManagementRestricted true and expose it."
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ is_member_management_restricted = true })
    error_message = "The replace trigger must follow the restriction flag."
  }

  assert {
    condition     = msgraph_resource_collection.members[0].url == "directory/administrativeUnits/22222222-2222-2222-2222-000000000003/members/$ref"
    error_message = "The member collection must follow the replacement to the new unit."
  }

  assert {
    condition     = output.directory_scope_id == "/administrativeUnits/22222222-2222-2222-2222-000000000003"
    error_message = "directory_scope_id must follow the replacement."
  }
}

run "an_unchanged_restriction_keeps_the_unit" {
  command = apply

  variables {
    is_member_management_restricted = true
    member_ids                      = ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"]
    description                     = "Restricted sales administration"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id     = "22222222-2222-2222-2222-000000000004"
      output = {}
    }
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000003"
    error_message = "A description change on a restricted unit must update it in place and keep its id."
  }
}

# The member collection already exists here, so the replacement of the unit also
# replaces the collection, whose url changes.
run "a_replacement_moves_the_managed_members_to_the_new_unit" {
  command = apply

  variables {
    member_ids = ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"]
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id     = "22222222-2222-2222-2222-000000000005"
      output = {}
    }
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000005" && output.is_member_management_restricted == false
    error_message = "Removing the restriction must replace the unit."
  }

  assert {
    condition     = msgraph_resource_collection.members[0].url == "directory/administrativeUnits/22222222-2222-2222-2222-000000000005/members/$ref"
    error_message = "The existing member collection must be replaced with one on the new unit."
  }

  assert {
    condition = jsonencode(output.member_ids) == jsonencode([
      "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
      "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb",
    ])
    error_message = "The new unit must receive the managed members."
  }
}

# Names up to the documented 256 characters are accepted.
run "accepts_a_display_name_of_256_characters" {
  command = apply

  variables {
    is_member_management_restricted = true
    display_name                    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }

  assert {
    condition     = length(output.display_name) == 256
    error_message = "A 256 character display name must be accepted."
  }
}

# Validation. Each run changes one input and expects its variable to fail.
run "rejects_an_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}

run "rejects_a_blank_display_name" {
  command = plan

  variables {
    display_name = "   "
  }

  expect_failures = [var.display_name]
}

run "rejects_a_display_name_over_256_characters" {
  command = plan

  variables {
    display_name = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }

  expect_failures = [var.display_name]
}

run "rejects_an_unknown_visibility" {
  command = plan

  variables {
    visibility = "Public"
  }

  expect_failures = [var.visibility]
}

run "rejects_an_unknown_membership_type" {
  command = plan

  variables {
    membership_type = "dynamic"
  }

  expect_failures = [var.membership_type]
}

run "rejects_an_empty_membership_rule" {
  command = plan

  variables {
    membership_type = "Dynamic"
    membership_rule = " "
  }

  expect_failures = [var.membership_rule]
}

run "rejects_an_unknown_processing_state" {
  command = plan

  variables {
    membership_type                  = "Dynamic"
    membership_rule                  = "(user.department -eq \"Sales\")"
    membership_rule_processing_state = "Off"
  }

  expect_failures = [var.membership_rule_processing_state]
}

run "rejects_a_member_id_that_is_not_a_guid" {
  command = plan

  variables {
    member_ids = ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "not-a-guid"]
  }

  expect_failures = [var.member_ids]
}

# A null element must reach the validation message, not a function error.
run "rejects_a_null_member_id" {
  command = plan

  variables {
    member_ids = [null]
  }

  expect_failures = [var.member_ids]
}

run "rejects_a_member_id_named_twice_in_another_case" {
  command = plan

  variables {
    member_ids = ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"]
  }

  expect_failures = [var.member_ids]
}

# Preconditions. Each run combines inputs that are valid alone.
run "rejects_a_dynamic_unit_without_a_rule" {
  command = plan

  variables {
    membership_type = "Dynamic"
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_a_rule_on_an_assigned_unit" {
  command = plan

  variables {
    membership_rule = "(user.department -eq \"Sales\")"
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_a_processing_state_on_an_assigned_unit" {
  command = plan

  variables {
    membership_rule_processing_state = "On"
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_member_ids_on_a_dynamic_unit" {
  command = plan

  variables {
    membership_type = "Dynamic"
    membership_rule = "(user.department -eq \"Sales\")"
    member_ids      = ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"]
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_an_empty_member_list_on_a_dynamic_unit" {
  command = plan

  variables {
    membership_type = "Dynamic"
    membership_rule = "(user.department -eq \"Sales\")"
    member_ids      = []
  }

  expect_failures = [msgraph_resource.this]
}

# Three groups that the same apply creates. Their ids are unknown at plan time,
# and the list that holds them is known, so the member collection is counted at
# plan time and created after the groups, by data flow alone.
run "plans_groups_that_the_same_apply_creates_as_members" {
  command = plan

  module {
    source = "./tests/three_groups"
  }
}

run "adds_groups_that_the_same_apply_creates_as_members" {
  command = apply

  module {
    source = "./tests/three_groups"
  }

  assert {
    condition = jsonencode(output.member_ids) == jsonencode([
      "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
      "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb",
      "cccccccc-cccc-4ccc-8ccc-cccccccccccc",
    ])
    error_message = "The ids of groups created in the same apply must become the members, in lower case."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "The unit must be created."
  }
}
