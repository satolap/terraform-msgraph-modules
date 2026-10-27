mock_provider "msgraph" {}
variables {
  clientId    = "AAAAAAAA-1111-1111-1111-111111111111"
  resourceId  = "BBBBBBBB-2222-2222-2222-222222222222"
  consentType = "Principal"
  principalId = "CCCCCCCC-3333-3333-3333-333333333333"
  scopes      = ["User.Read", "Group.Read.All", "User.Read"]
}
run "constructs_principal_grant_and_scope_only_patch" {
  command = plan
  assert {
    condition = jsonencode(msgraph_resource_action.grant.body) == jsonencode({
      clientId    = "aaaaaaaa-1111-1111-1111-111111111111"
      resourceId  = "bbbbbbbb-2222-2222-2222-222222222222"
      principalId = "cccccccc-3333-3333-3333-333333333333"
      consentType = "Principal"
      scope       = "Group.Read.All User.Read"
    })
    error_message = "The create body must use object IDs and deterministic deduplicated scopes."
  }
  assert {
    condition     = jsonencode(msgraph_update_resource.scope.body) == jsonencode({ scope = "Group.Read.All User.Read" })
    error_message = "PATCH must contain scope only."
  }
}
run "explicit_admin_consent" {
  command = plan
  variables {
    consentType                = "AllPrincipals"
    principalId                = null
    acknowledge_all_principals = true
  }
  assert {
    condition     = msgraph_resource_action.grant.body.principalId == null
    error_message = "AllPrincipals must send a null principalId."
  }
}
run "rejects_admin_consent_needs_acknowledgement" {
  command = plan
  variables {
    consentType = "AllPrincipals"
    principalId = null
  }
  expect_failures = [msgraph_resource_action.grant]
}
run "rejects_principal_needs_user" {
  command = plan
  variables {
    principalId = null
  }
  expect_failures = [msgraph_resource_action.grant]
}
run "rejects_admin_consent_refuses_user" {
  command = plan
  variables {
    consentType                = "AllPrincipals"
    acknowledge_all_principals = true
  }
  expect_failures = [msgraph_resource_action.grant]
}
run "rejects_invalid_consent_type" {
  command = plan
  variables {
    consentType = "principal"
  }
  expect_failures = [var.consentType]
}
run "rejects_invalid_client_id" {
  command = plan
  variables {
    clientId = "not-an-object-id"
  }
  expect_failures = [var.clientId]
}
run "rejects_invalid_resource_id" {
  command = plan
  variables {
    resourceId = "not-an-object-id"
  }
  expect_failures = [var.resourceId]
}
run "rejects_invalid_principal_id" {
  command = plan
  variables {
    principalId = "not-an-object-id"
  }
  expect_failures = [var.principalId]
}
run "rejects_empty_scopes" {
  command = plan
  variables {
    scopes = []
  }
  expect_failures = [var.scopes]
}
run "rejects_null_scope" {
  command = plan
  variables {
    scopes = [null]
  }
  expect_failures = [var.scopes]
}
run "rejects_empty_scope_name" {
  command = plan
  variables {
    scopes = [""]
  }
  expect_failures = [var.scopes]
}
run "rejects_embedded_space" {
  command = plan
  variables {
    scopes = ["User.Read Group.Read.All"]
  }
  expect_failures = [var.scopes]
}
run "rejects_leading_space" {
  command = plan
  variables {
    scopes = [" User.Read"]
  }
  expect_failures = [var.scopes]
}
run "rejects_embedded_tab" {
  command = plan
  variables {
    scopes = ["User.\tRead"]
  }
  expect_failures = [var.scopes]
}
run "rejects_embedded_newline" {
  command = plan
  variables {
    scopes = ["User.\nRead"]
  }
  expect_failures = [var.scopes]
}
run "rejects_unicode_whitespace" {
  command = plan
  variables {
    scopes = ["User.\u00a0Read"]
  }
  expect_failures = [var.scopes]
}
run "rejects_too_long" {
  command = plan
  variables {
    scopes = [join("", concat([for n in range(770) : "aaaaa"], ["a"]))]
  }
  expect_failures = [var.scopes]
}
run "rejects_separator_counts_towards_limit" {
  command = plan
  variables {
    scopes = [join("", [for n in range(385) : "aaaaa"]), join("", [for n in range(385) : "bbbbb"])]
  }
  expect_failures = [var.scopes]
}
run "accepts_scope_length_boundary" {
  command = plan
  variables { scopes = [join("", [for n in range(770) : "aaaaa"])] }
}
