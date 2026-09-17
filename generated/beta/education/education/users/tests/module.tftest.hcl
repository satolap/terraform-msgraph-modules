# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "education/users"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountEnabled", "assignedLicenses", "assignments", "businessPhones", "classes", "createdBy", "department", "displayName", "externalSource", "externalSourceDetail", "givenName", "mailNickname", "mailingAddress", "middleName", "mobilePhone", "officeLocation", "onPremisesInfo", "passwordPolicies", "passwordProfile", "preferredLanguage", "primaryRole", "refreshTokensValidFromDateTime", "relatedContacts", "residenceAddress", "rubrics", "schools", "showInAddressList", "student", "surname", "taughtClasses", "teacher", "usageLocation", "user", "userPrincipalName", "userType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    department        = "example"
    account_enabled   = false
    assigned_licenses = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["department"]) == jsonencode("example")
    error_message = "department must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedLicenses"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.assignedLicense" }])
    error_message = "assignedLicenses must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    external_source = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.external_source]
}
