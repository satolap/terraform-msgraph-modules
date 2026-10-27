# Generated from the shared Graph contracts by the conformance check; do not edit.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "33333333-3333-3333-3333-333333333333"
      output = {
        display_name = "Engineering"
        mail         = null
        mail_enabled = false
        group_types  = []
      }
    }
  }
}

variables {
  display_name  = "Engineering"
  mail_nickname = "engineering"
}

# A role-assignable group must have visibility Private or leave it unset; Microsoft Graph refuses the replacement after the old group is deleted.
run "allows_isassignabletorole_visibility" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = true
    mail_enabled          = true
    visibility            = "Private"
  }
}

run "allows_isassignabletorole_visibility_absent" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = true
    mail_enabled          = true
    visibility            = null
  }
}

run "refuses_isassignabletorole_visibility_public" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = true
    mail_enabled          = true
    visibility            = "Public"
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_visibility_public" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = false
    mail_enabled          = true
    visibility            = "Public"
  }
}

run "refuses_isassignabletorole_visibility_hiddenmembership" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = true
    mail_enabled          = true
    visibility            = "HiddenMembership"
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_visibility_hiddenmembership" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = false
    mail_enabled          = true
    visibility            = "HiddenMembership"
  }
}

# A role-assignable group must have security_enabled = true.
run "allows_isassignabletorole_securityenabled" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = true
    mail_enabled          = true
    security_enabled      = true
  }
}

run "refuses_isassignabletorole_securityenabled" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = true
    mail_enabled          = true
    security_enabled      = false
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_securityenabled" {
  command = plan

  variables {
    group_types           = ["Unified"]
    is_assignable_to_role = false
    mail_enabled          = true
    security_enabled      = false
  }
}

# A role-assignable group cannot have dynamic membership.
run "allows_isassignabletorole_grouptypes" {
  command = plan

  variables {
    group_types           = []
    is_assignable_to_role = true
    membership_rule       = "user.department -eq \"Sales\""
  }
}

run "refuses_isassignabletorole_grouptypes" {
  command = plan

  variables {
    group_types           = ["DynamicMembership"]
    is_assignable_to_role = true
    membership_rule       = "user.department -eq \"Sales\""
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_grouptypes" {
  command = plan

  variables {
    group_types           = ["DynamicMembership"]
    is_assignable_to_role = false
    membership_rule       = "user.department -eq \"Sales\""
  }
}
