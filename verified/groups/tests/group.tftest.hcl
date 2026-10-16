mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "33333333-3333-3333-3333-333333333333"
      output = {
        display_name = "Engineering"
        mail         = null
      }
    }
  }
}

variables {
  display_name  = "Engineering"
  mail_nickname = "engineering"
}

run "creates_security_group_with_defaults" {
  command = apply

  assert {
    condition     = msgraph_resource.group.url == "groups"
    error_message = "Group must be created against the groups endpoint."
  }

  assert {
    condition     = msgraph_resource.group.body.securityEnabled == true && msgraph_resource.group.body.mailEnabled == false
    error_message = "Defaults must produce a plain security group."
  }

  assert {
    condition     = length(msgraph_resource.group.body.groupTypes) == 0
    error_message = "groupTypes must default to empty for a security group."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.group.body), "owners@odata.bind")
    error_message = "owners@odata.bind must be omitted when no owners are given."
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-333333333333"
    error_message = "id output must expose the resource id."
  }
}

run "binds_owners_and_members" {
  command = apply

  variables {
    owner_ids  = ["aaaaaaaa-0000-0000-0000-000000000001"]
    member_ids = ["aaaaaaaa-0000-0000-0000-000000000002", "aaaaaaaa-0000-0000-0000-000000000003"]
  }

  assert {
    condition     = msgraph_resource.group.body["owners@odata.bind"][0] == "https://graph.microsoft.com/v1.0/directoryObjects/aaaaaaaa-0000-0000-0000-000000000001"
    error_message = "Owners must be bound with fully qualified directoryObjects URLs."
  }

  assert {
    condition     = length(msgraph_resource.group.body["members@odata.bind"]) == 2
    error_message = "All members must be bound at creation."
  }
}

run "builds_dynamic_group_body" {
  command = apply

  variables {
    group_types     = ["DynamicMembership"]
    membership_rule = "user.department -eq \"Engineering\""
  }

  assert {
    condition     = msgraph_resource.group.body.membershipRule == "user.department -eq \"Engineering\""
    error_message = "membershipRule must be set for dynamic groups."
  }

  assert {
    condition     = msgraph_resource.group.body.membershipRuleProcessingState == "On"
    error_message = "membershipRuleProcessingState must be On for dynamic groups."
  }
}

run "rejects_dynamic_group_without_rule" {
  command = plan

  variables {
    group_types = ["DynamicMembership"]
  }

  expect_failures = [msgraph_resource.group]
}

run "rejects_invalid_mail_nickname" {
  command = plan

  variables {
    mail_nickname = "has space"
  }

  expect_failures = [var.mail_nickname]
}

run "rejects_invalid_visibility" {
  command = plan

  variables {
    visibility = "Secret"
  }

  expect_failures = [var.visibility]
}

run "rejects_invalid_group_type" {
  command = plan

  variables {
    group_types = ["Distribution"]
  }

  expect_failures = [var.group_types]
}

run "rejects_mail_enabled_security_group" {
  command = plan
  variables {
    mail_enabled = true
  }
  expect_failures = [msgraph_resource.group]
}

run "rejects_static_members_in_dynamic_group" {
  command = plan
  variables {
    group_types     = ["DynamicMembership"]
    membership_rule = "user.department -eq \"Engineering\""
    member_ids      = ["aaaaaaaa-0000-0000-0000-000000000001"]
  }
  expect_failures = [msgraph_resource.group]
}

run "rejects_dynamic_role_assignable_group" {
  command = plan
  variables {
    group_types           = ["DynamicMembership"]
    membership_rule       = "user.department -eq \"Engineering\""
    is_assignable_to_role = true
  }
  expect_failures = [msgraph_resource.group]
}

run "rejects_a_public_role_assignable_group" {
  command = plan
  variables {
    group_types           = ["Unified"]
    mail_enabled          = true
    visibility            = "Public"
    is_assignable_to_role = true
  }
  expect_failures = [msgraph_resource.group]
}

run "rejects_hidden_membership_on_a_security_group" {
  command = plan
  variables {
    visibility = "HiddenMembership"
  }
  expect_failures = [msgraph_resource.group]
}

run "accepts_a_private_role_assignable_microsoft_365_group" {
  command = plan
  variables {
    group_types           = ["Unified"]
    mail_enabled          = true
    visibility            = "Private"
    is_assignable_to_role = true
  }
  assert {
    condition     = msgraph_resource.group.body.isAssignableToRole && msgraph_resource.group.body.visibility == "Private"
    error_message = "A private role-assignable Microsoft 365 group is valid and must plan."
  }
}

run "creates_unified_group" {
  command = plan
  variables {
    group_types  = ["Unified"]
    mail_enabled = true
  }
  assert {
    condition     = msgraph_resource.group.body.mailEnabled
    error_message = "Microsoft 365 groups must be mail-enabled."
  }
}

run "accepts_a_period_in_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "help.desk"
  }
  assert {
    condition     = msgraph_resource.group.body.mailNickname == "help.desk"
    error_message = "A period is allowed in a mail nickname and must reach the body unchanged."
  }
}

run "rejects_an_at_sign_in_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "help@desk"
  }
  expect_failures = [var.mail_nickname]
}

run "rejects_a_backslash_in_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "help\\desk"
  }
  expect_failures = [var.mail_nickname]
}

run "rejects_a_bracket_in_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "help]desk"
  }
  expect_failures = [var.mail_nickname]
}

run "rejects_a_quote_in_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "help\"desk"
  }
  expect_failures = [var.mail_nickname]
}

run "rejects_an_angle_bracket_in_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "help<desk"
  }
  expect_failures = [var.mail_nickname]
}

run "rejects_a_non_ascii_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "gruppe-zürich"
  }
  expect_failures = [var.mail_nickname]
}

run "rejects_a_mail_nickname_longer_than_64_characters" {
  command = plan
  variables {
    mail_nickname = "a234567890123456789012345678901234567890123456789012345678901234x"
  }
  expect_failures = [var.mail_nickname]
}

run "accepts_a_64_character_mail_nickname" {
  command = plan
  variables {
    mail_nickname = "a234567890123456789012345678901234567890123456789012345678901234"
  }
  assert {
    condition     = length(msgraph_resource.group.body.mailNickname) == 64
    error_message = "A 64-character mail nickname is the documented maximum and must be accepted."
  }
}

# The runs below share one state in file order with the apply runs above. A
# replacement takes the id of the override_resource block; an in-place update
# keeps the id in the state.

run "restores_a_plain_security_group" {
  command = apply

  assert {
    condition     = output.id == "33333333-3333-3333-3333-333333333333"
    error_message = "Dropping dynamic membership must update the group in place."
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ is_assignable_to_role = false, hidden_membership = false })
    error_message = "The replace trigger must hold the role-assignable flag and whether membership is hidden."
  }
}

run "false_role_assignability_keeps_the_group" {
  command = apply

  variables {
    is_assignable_to_role = false
  }

  override_resource {
    target = msgraph_resource.group
    values = {
      id     = "33333333-3333-3333-3333-000000000001"
      output = { display_name = "Engineering", mail = null }
    }
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-333333333333"
    error_message = "Null and false both create a group that is not role-assignable, so a change between them must keep the group."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.group.body), "isAssignableToRole")
    error_message = "false is Graph's default and isAssignableToRole cannot be updated, so the body must omit it rather than PATCH it."
  }
}

run "role_assignability_replaces_the_group" {
  command = apply

  variables {
    is_assignable_to_role = true
  }

  override_resource {
    target = msgraph_resource.group
    values = {
      id     = "33333333-3333-3333-3333-000000000002"
      output = { display_name = "Engineering", mail = null }
    }
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-000000000002"
    error_message = "isAssignableToRole is set only at creation, so a change of is_assignable_to_role must replace the group."
  }

  assert {
    condition     = msgraph_resource.group.body.isAssignableToRole == true
    error_message = "The new group must be created role-assignable."
  }
}

run "other_changes_keep_a_role_assignable_group" {
  command = apply

  variables {
    is_assignable_to_role = true
    description           = "Role holders"
  }

  override_resource {
    target = msgraph_resource.group
    values = {
      id     = "33333333-3333-3333-3333-000000000003"
      output = { display_name = "Engineering", mail = null }
    }
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-000000000002"
    error_message = "A description change must update the group in place and keep its id."
  }
}

run "dropping_role_assignability_replaces_the_group" {
  command = apply

  override_resource {
    target = msgraph_resource.group
    values = {
      id     = "33333333-3333-3333-3333-000000000004"
      output = { display_name = "Engineering", mail = null }
    }
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-000000000004"
    error_message = "Removing is_assignable_to_role from a role-assignable group must replace it."
  }
}

run "private_microsoft_365_group" {
  command = apply

  variables {
    group_types  = ["Unified"]
    mail_enabled = true
    visibility   = "Private"
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-000000000004"
    error_message = "Public and Private visibility are updatable, so the group must be updated in place."
  }
}

run "hidden_membership_replaces_the_group" {
  command = apply

  variables {
    group_types  = ["Unified"]
    mail_enabled = true
    visibility   = "HiddenMembership"
  }

  override_resource {
    target = msgraph_resource.group
    values = {
      id     = "33333333-3333-3333-3333-000000000005"
      output = { display_name = "Engineering", mail = null }
    }
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-000000000005"
    error_message = "HiddenMembership is set only at creation, so a change to it must replace the group."
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ is_assignable_to_role = false, hidden_membership = true })
    error_message = "The replace trigger must follow the hidden membership."
  }
}

run "leaving_hidden_membership_replaces_the_group" {
  command = apply

  variables {
    group_types  = ["Unified"]
    mail_enabled = true
    visibility   = "Public"
  }

  override_resource {
    target = msgraph_resource.group
    values = {
      id     = "33333333-3333-3333-3333-000000000006"
      output = { display_name = "Engineering", mail = null }
    }
  }

  assert {
    condition     = output.id == "33333333-3333-3333-3333-000000000006"
    error_message = "A change from HiddenMembership to another visibility must replace the group."
  }
}
