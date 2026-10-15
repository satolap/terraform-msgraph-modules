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
    condition = alltrue([
      for key in ["tags", "appRoles", "web", "spa", "publicClient"] :
      !contains(keys(msgraph_resource.application.body), key)
    ])
    error_message = "Unspecified collections must all be omitted, preserving default request behavior."
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

run "explicit_empty_collections_are_clear_requests" {
  command = plan
  variables {
    tags                        = []
    app_roles                   = []
    web_redirect_uris           = []
    spa_redirect_uris           = []
    public_client_redirect_uris = []
  }
  assert {
    condition = alltrue([
      try(jsonencode(msgraph_resource.application.body.tags) == "[]", false),
      try(jsonencode(msgraph_resource.application.body.appRoles) == "[]", false),
      try(jsonencode(msgraph_resource.application.body.web.redirectUris) == "[]", false),
      try(jsonencode(msgraph_resource.application.body.spa.redirectUris) == "[]", false),
      try(jsonencode(msgraph_resource.application.body.publicClient.redirectUris) == "[]", false),
    ])
    error_message = "Explicit empty collections must remain in the request body."
  }
}

run "null_collections_are_omitted" {
  command = plan
  variables {
    tags                        = null
    app_roles                   = null
    web_redirect_uris           = null
    spa_redirect_uris           = null
    public_client_redirect_uris = null
  }
  assert {
    condition = alltrue([
      for key in ["tags", "appRoles", "web", "spa", "publicClient"] :
      !contains(keys(msgraph_resource.application.body), key)
    ])
    error_message = "Null inputs must omit optional collections, including their platform objects."
  }
  assert {
    condition     = length(output.app_role_ids) == 0
    error_message = "Omitted app roles must produce an empty role ID map."
  }
}

run "populated_collections_and_disabled_roles_are_preserved" {
  command = plan
  variables {
    tags                        = ["curated-test"]
    web_redirect_uris           = ["https://example.org/web"]
    spa_redirect_uris           = ["https://example.org/spa"]
    public_client_redirect_uris = ["https://example.org/native"]
    app_roles = [{
      id           = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
      display_name = "Retiring role"
      description  = "Disable before removing in a separate apply"
      value        = "RetiringRole"
      is_enabled   = false
    }]
  }
  assert {
    condition = (
      msgraph_resource.application.body.tags[0] == "curated-test" &&
      msgraph_resource.application.body.web.redirectUris[0] == "https://example.org/web" &&
      msgraph_resource.application.body.spa.redirectUris[0] == "https://example.org/spa" &&
      msgraph_resource.application.body.publicClient.redirectUris[0] == "https://example.org/native" &&
      msgraph_resource.application.body.appRoles[0].isEnabled == false
    )
    error_message = "Populated values and the explicit role-disabling stage must be retained."
  }
}
