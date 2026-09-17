# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "users"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aboutMe", "accountEnabled", "ageGroup", "appRoleAssignments", "assignedLicenses", "authentication", "authorizationInfo", "birthday", "chats", "city", "cloudClipboard", "companyName", "consentProvidedForMinor", "country", "customSecurityAttributes", "deletedDateTime", "department", "deviceEnrollmentLimit", "deviceManagementTroubleshootingEvents", "displayName", "employeeExperience", "employeeHireDate", "employeeId", "employeeLeaveDateTime", "employeeOrgData", "employeeType", "externalUserState", "externalUserStateChangeDateTime", "faxNumber", "followedSites", "givenName", "hireDate", "identities", "identityParentId", "inferenceClassification", "interests", "isResourceAccount", "jobTitle", "joinedTeams", "lastPasswordChangeDateTime", "mail", "mailNickname", "mailboxSettings", "managedAppRegistrations", "managedDevices", "mySite", "oauth2PermissionGrants", "officeLocation", "onPremisesImmutableId", "onPremisesProvisioningErrors", "onPremisesSyncBehavior", "onenote", "onlineMeetings", "otherMails", "outlook", "passwordPolicies", "passwordProfile", "pastProjects", "permissionGrants", "postalCode", "preferredDataLocation", "preferredLanguage", "preferredName", "presence", "print", "responsibilities", "schools", "scopedRoleMemberOf", "serviceProvisioningErrors", "settings", "showInAddressList", "skills", "sponsors", "state", "streetAddress", "surname", "todo", "transitiveMemberOf", "usageLocation", "userPrincipalName", "userType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    about_me                = "example"
    account_enabled         = false
    device_enrollment_limit = -2147483648
    app_role_assignments    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["aboutMe"]) == jsonencode("example")
    error_message = "aboutMe must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceEnrollmentLimit"]) == jsonencode(-2147483648)
    error_message = "deviceEnrollmentLimit must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appRoleAssignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appRoleAssignment" }])
    error_message = "appRoleAssignments must preserve typed values and omit nested nulls."
  }
}
