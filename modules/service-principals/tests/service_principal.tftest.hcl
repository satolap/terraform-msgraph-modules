mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "66666666-6666-6666-6666-666666666666"
      output = {
        app_id       = "55555555-5555-5555-5555-555555555555"
        display_name = "Engineering Internal Tool"
      }
    }
  }
}

variables {
  app_id = "55555555-5555-5555-5555-555555555555"
}

run "creates_service_principal_with_defaults" {
  command = apply

  assert {
    condition     = msgraph_resource.service_principal.url == "servicePrincipals"
    error_message = "Service principal must be created against the servicePrincipals endpoint."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.appId == "55555555-5555-5555-5555-555555555555"
    error_message = "body.appId must come from var.app_id."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.accountEnabled == true
    error_message = "accountEnabled must default to true."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.appRoleAssignmentRequired == false
    error_message = "appRoleAssignmentRequired must default to false."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.service_principal.body), "tags")
    error_message = "tags must be omitted when empty."
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-666666666666"
    error_message = "id output must expose the service principal object id."
  }
}

run "passes_optional_properties" {
  command = apply

  variables {
    app_role_assignment_required  = true
    tags                          = ["WindowsAzureActiveDirectoryIntegratedApp"]
    preferred_single_sign_on_mode = "oidc"
  }

  assert {
    condition     = msgraph_resource.service_principal.body.appRoleAssignmentRequired == true
    error_message = "appRoleAssignmentRequired must be passed through."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.tags[0] == "WindowsAzureActiveDirectoryIntegratedApp"
    error_message = "tags must be passed through when set."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.preferredSingleSignOnMode == "oidc"
    error_message = "preferredSingleSignOnMode must be passed through when set."
  }
}

run "rejects_non_guid_app_id" {
  command = plan

  variables {
    app_id = "not-a-guid"
  }

  expect_failures = [var.app_id]
}

run "rejects_invalid_sso_mode" {
  command = plan

  variables {
    preferred_single_sign_on_mode = "kerberos"
  }

  expect_failures = [var.preferred_single_sign_on_mode]
}
