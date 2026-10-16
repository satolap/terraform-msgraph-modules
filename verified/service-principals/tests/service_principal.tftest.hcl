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
    error_message = "tags must be omitted when unspecified."
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

run "explicit_empty_tags_are_a_clear_request" {
  command = plan
  variables {
    tags = []
  }
  assert {
    condition     = try(jsonencode(msgraph_resource.service_principal.body.tags) == "[]", false)
    error_message = "Explicit empty tags must remain in the service-principal body."
  }
}

run "null_tags_are_omitted" {
  command = plan
  variables {
    tags = null
  }
  assert {
    condition     = !contains(keys(msgraph_resource.service_principal.body), "tags")
    error_message = "Null tags must omit the property."
  }
}

# The runs below share one state in file order with the apply runs above. A
# replacement takes the id of the override_resource block; an in-place update
# keeps the id in the state.

run "keeps_the_service_principal_for_in_place_changes" {
  command = apply

  variables {
    notes = "Owned by the platform team"
  }

  override_resource {
    target = msgraph_resource.service_principal
    values = {
      id     = "66666666-6666-6666-6666-000000000001"
      output = { app_id = "55555555-5555-5555-5555-555555555555", display_name = "Engineering Internal Tool" }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-666666666666"
    error_message = "A notes change must update the service principal in place and keep its id."
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ app_id = "55555555-5555-5555-5555-555555555555" })
    error_message = "The replace trigger must hold the application id."
  }
}

run "a_new_app_id_replaces_the_service_principal" {
  command = apply

  variables {
    app_id = "AAAAAAAA-5555-5555-5555-555555555555"
  }

  override_resource {
    target = msgraph_resource.service_principal
    values = {
      id     = "66666666-6666-6666-6666-000000000002"
      output = { app_id = "aaaaaaaa-5555-5555-5555-555555555555", display_name = "Other Tool" }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000002"
    error_message = "A different application id must replace the service principal."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.appId == "AAAAAAAA-5555-5555-5555-555555555555"
    error_message = "The replacement must be created with the new appId; ignore_changes must not apply to a create."
  }
}

run "a_case_change_of_app_id_keeps_the_service_principal" {
  command = apply

  variables {
    app_id = "aaaaaaaa-5555-5555-5555-555555555555"
  }

  override_resource {
    target = msgraph_resource.service_principal
    values = {
      id     = "66666666-6666-6666-6666-000000000003"
      output = { app_id = "aaaaaaaa-5555-5555-5555-555555555555", display_name = "Other Tool" }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000002"
    error_message = "A GUID has no case, so changing only the case of app_id must keep the service principal."
  }

  assert {
    condition     = msgraph_resource.service_principal.body.appId == "AAAAAAAA-5555-5555-5555-555555555555"
    error_message = "An in-place update must not change appId, which Graph cannot update, so the stored body keeps the old case."
  }
}
