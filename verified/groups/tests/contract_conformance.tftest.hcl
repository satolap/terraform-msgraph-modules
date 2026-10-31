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
  displayName  = "Engineering"
  mailNickname = "engineering"
}

# A role-assignable group must have visibility Private or leave it unset; Microsoft Graph refuses the replacement after the old group is deleted.
run "allows_isassignabletorole_visibility" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = true
    mailEnabled        = true
    visibility         = "Private"
  }
}

run "allows_isassignabletorole_visibility_absent" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = true
    mailEnabled        = true
    visibility         = null
  }
}

run "refuses_isassignabletorole_visibility_public" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = true
    mailEnabled        = true
    visibility         = "Public"
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_visibility_public" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = false
    mailEnabled        = true
    visibility         = "Public"
  }
}

run "refuses_isassignabletorole_visibility_hiddenmembership" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = true
    mailEnabled        = true
    visibility         = "HiddenMembership"
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_visibility_hiddenmembership" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = false
    mailEnabled        = true
    visibility         = "HiddenMembership"
  }
}

# A role-assignable group must have security_enabled = true.
run "allows_isassignabletorole_securityenabled" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = true
    mailEnabled        = true
    securityEnabled    = true
  }
}

run "refuses_isassignabletorole_securityenabled" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = true
    mailEnabled        = true
    securityEnabled    = false
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_securityenabled" {
  command = plan

  variables {
    groupTypes         = ["Unified"]
    isAssignableToRole = false
    mailEnabled        = true
    securityEnabled    = false
  }
}

# A role-assignable group cannot have dynamic membership.
run "allows_isassignabletorole_grouptypes" {
  command = plan

  variables {
    groupTypes         = []
    isAssignableToRole = true
    membershipRule     = "user.department -eq \"Sales\""
  }
}

run "refuses_isassignabletorole_grouptypes" {
  command = plan

  variables {
    groupTypes         = ["DynamicMembership"]
    isAssignableToRole = true
    membershipRule     = "user.department -eq \"Sales\""
  }

  expect_failures = [msgraph_resource.group]
}

run "unrelated_isassignabletorole_grouptypes" {
  command = plan

  variables {
    groupTypes         = ["DynamicMembership"]
    isAssignableToRole = false
    membershipRule     = "user.department -eq \"Sales\""
  }
}
