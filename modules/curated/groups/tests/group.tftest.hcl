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
