mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "22222222-2222-2222-2222-222222222222"
      output = {
        display_name        = "Jane Doe"
        user_principal_name = "jane@contoso.onmicrosoft.com"
      }
    }
  }
}

run "rejects_password_profile_override" {
  command = plan
  variables {
    additional_properties = {
      passwordProfile = { password = "unprotected", forceChangePasswordNextSignIn = false }
    }
  }
  expect_failures = [var.additional_properties]
}

run "rejects_non_object_additional_properties" {
  command = plan
  variables {
    additional_properties = ["invalid"]
  }
  expect_failures = [var.additional_properties]
}

variables {
  user_principal_name = "jane@contoso.onmicrosoft.com"
  display_name        = "Jane Doe"
  mail_nickname       = "jane"
  password            = "Sup3r-Secret-Pass!"
}

run "creates_user" {
  command = apply

  assert {
    condition     = msgraph_resource.user.url == "users"
    error_message = "User must be created against the users endpoint."
  }

  assert {
    condition     = msgraph_resource.user.body.userPrincipalName == "jane@contoso.onmicrosoft.com"
    error_message = "body.userPrincipalName must come from var.user_principal_name."
  }

  assert {
    condition     = msgraph_resource.user.body.passwordProfile.password == "Sup3r-Secret-Pass!"
    error_message = "passwordProfile.password must carry the initial password."
  }

  assert {
    condition     = msgraph_resource.user.body.passwordProfile.forceChangePasswordNextSignIn == true
    error_message = "forceChangePasswordNextSignIn must default to true."
  }

  assert {
    condition     = msgraph_resource.user.body.accountEnabled == true
    error_message = "accountEnabled must default to true."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.user.body), "givenName")
    error_message = "Optional properties left null must be omitted from the body."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "id output must expose the resource id."
  }
}

run "merges_optional_and_additional_properties" {
  command = apply

  variables {
    given_name     = "Jane"
    surname        = "Doe"
    usage_location = "US"

    # mixed value types prove additional_properties is typed as `any`
    additional_properties = {
      companyName       = "Contoso"
      showInAddressList = false
    }
  }

  assert {
    condition     = msgraph_resource.user.body.givenName == "Jane"
    error_message = "givenName must be included when set."
  }

  assert {
    condition     = msgraph_resource.user.body.usageLocation == "US"
    error_message = "usageLocation must be included when set."
  }

  assert {
    condition     = msgraph_resource.user.body.companyName == "Contoso"
    error_message = "additional_properties must be merged into the body."
  }

  assert {
    condition     = msgraph_resource.user.body.showInAddressList == false
    error_message = "additional_properties must support non-string values."
  }
}

run "rejects_invalid_upn" {
  command = plan

  variables {
    user_principal_name = "not-a-upn"
  }

  expect_failures = [var.user_principal_name]
}

run "rejects_invalid_usage_location" {
  command = plan

  variables {
    usage_location = "usa"
  }

  expect_failures = [var.usage_location]
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}
