# v4.0.0 spelled the app_roles attributes in snake_case. Terraform drops an unknown object
# attribute silently, so the guard rejects an old name that carries a value.
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

variables {
  displayName = "Engineering Internal Tool"
}

run "app_roles_with_the_graph_names_are_accepted" {
  command = plan
  variables {
    app_roles = [{
      id                 = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
      displayName        = "Contributor"
      description        = "Can contribute"
      value              = "Contributor"
      allowedMemberTypes = ["Application"]
      isEnabled          = false
    }]
  }
}

run "rejects_the_legacy_allowed_member_types" {
  command = plan
  variables {
    app_roles = [{
      id                   = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
      displayName          = "Contributor"
      description          = "Can contribute"
      value                = "Contributor"
      allowed_member_types = ["Application"]
    }]
  }
  expect_failures = [var.app_roles]
}

run "rejects_the_legacy_is_enabled" {
  command = plan
  variables {
    app_roles = [{
      id          = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
      displayName = "Contributor"
      description = "Can contribute"
      value       = "Contributor"
      is_enabled  = false
    }]
  }
  expect_failures = [var.app_roles]
}

run "an_explicit_null_legacy_value_is_accepted" {
  command = plan
  variables {
    app_roles = [{
      id                   = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab"
      displayName          = "Contributor"
      description          = "Can contribute"
      value                = "Contributor"
      allowed_member_types = null
      is_enabled           = null
    }]
  }
}
