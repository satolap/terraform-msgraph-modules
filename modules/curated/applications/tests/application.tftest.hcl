mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "44444444-4444-4444-4444-444444444444"
      output = {
        app_id       = "55555555-5555-5555-5555-555555555555"
        display_name = "Engineering Internal Tool"
      }
    }
  }
}

run "rejects_duplicate_role_ids" {
  command = plan
  variables {
    app_roles = [
      { id = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab", display_name = "Read", description = "Read", value = "Read" },
      { id = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab", display_name = "Write", description = "Write", value = "Write" },
    ]
  }
  expect_failures = [var.app_roles]
}

run "rejects_empty_allowed_member_types" {
  command = plan
  variables {
    app_roles = [
      { id = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab", display_name = "Read", description = "Read", value = "Read", allowed_member_types = [] },
    ]
  }
  expect_failures = [var.app_roles]
}

variables {
  display_name = "Engineering Internal Tool"
}

run "creates_application_with_defaults" {
  command = apply

  assert {
    condition     = msgraph_resource.application.url == "applications"
    error_message = "Application must be created against the applications endpoint."
  }

  assert {
    condition     = msgraph_resource.application.body.signInAudience == "AzureADMyOrg"
    error_message = "signInAudience must default to AzureADMyOrg."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.application.body), "appRoles")
    error_message = "appRoles must be omitted when none are defined."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.application.body), "web")
    error_message = "web platform must be omitted when no redirect URIs are given."
  }

  assert {
    condition     = output.app_id == "55555555-5555-5555-5555-555555555555"
    error_message = "app_id output must expose the response appId."
  }
}

run "builds_app_roles" {
  command = apply

  variables {
    app_roles = [
      {
        id           = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
        display_name = "Contributor"
        description  = "Can contribute"
        value        = "Contributor"
      },
    ]
    web_redirect_uris = ["https://tool.contoso.com/auth"]
  }

  assert {
    condition     = msgraph_resource.application.body.appRoles[0].id == "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
    error_message = "App role id must be passed through."
  }

  assert {
    condition     = msgraph_resource.application.body.appRoles[0].allowedMemberTypes[0] == "User"
    error_message = "allowedMemberTypes must default to [\"User\"]."
  }

  assert {
    condition     = msgraph_resource.application.body.appRoles[0].isEnabled == true
    error_message = "App roles must default to enabled."
  }

  assert {
    condition     = msgraph_resource.application.body.web.redirectUris[0] == "https://tool.contoso.com/auth"
    error_message = "Web redirect URIs must be nested under web.redirectUris."
  }

  assert {
    condition     = output.app_role_ids["Contributor"] == "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
    error_message = "app_role_ids output must map role value to its GUID."
  }
}

run "rejects_non_guid_app_role_id" {
  command = plan

  variables {
    app_roles = [
      {
        id           = "not-a-guid"
        display_name = "Contributor"
        description  = "Can contribute"
        value        = "Contributor"
      },
    ]
  }

  expect_failures = [var.app_roles]
}

run "rejects_invalid_allowed_member_type" {
  command = plan

  variables {
    app_roles = [
      {
        id                   = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
        display_name         = "Contributor"
        description          = "Can contribute"
        value                = "Contributor"
        allowed_member_types = ["Device"]
      },
    ]
  }

  expect_failures = [var.app_roles]
}

run "rejects_invalid_sign_in_audience" {
  command = plan

  variables {
    sign_in_audience = "Everyone"
  }

  expect_failures = [var.sign_in_audience]
}
