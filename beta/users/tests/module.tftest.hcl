# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
  }

  assert {
    condition     = msgraph_resource.this.url == "users"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aboutMe", "ageGroup", "analytics", "appConsentRequestsForApproval", "appRoleAssignedResources", "appRoleAssignments", "approvals", "assignedLicenses", "authentication", "authorizationInfo", "birthday", "businessPhones", "chats", "city", "cloudClipboard", "cloudLicensing", "cloudRealtimeCommunicationInfo", "communications", "companyName", "consentProvidedForMinor", "country", "customSecurityAttributes", "deletedDateTime", "department", "deviceEnrollmentConfigurations", "deviceEnrollmentLimit", "deviceKeys", "deviceManagementTroubleshootingEvents", "devices", "employeeHireDate", "employeeId", "employeeLeaveDateTime", "employeeOrgData", "employeeType", "extensions", "externalUserState", "externalUserStateChangeDateTime", "faxNumber", "followedSites", "givenName", "hireDate", "identities", "identityGovernance", "identityParentId", "inferenceClassification", "infoCatalogs", "informationProtection", "interests", "invitedBy", "isResourceAccount", "jobTitle", "joinedGroups", "licenseDetails", "mail", "mailboxSettings", "managedAppLogCollectionRequests", "managedAppRegistrations", "managedDevices", "mobileAppIntentAndStates", "mobileAppTroubleshootingEvents", "mobilePhone", "mySite", "notifications", "oauth2PermissionGrants", "officeLocation", "onPremisesDistinguishedName", "onPremisesDomainName", "onPremisesExtensionAttributes", "onPremisesImmutableId", "onPremisesProvisioningErrors", "onPremisesSamAccountName", "onPremisesSecurityIdentifier", "onPremisesSyncBehavior", "onPremisesUserPrincipalName", "onenote", "onlineMeetings", "otherMails", "passwordPolicies", "pastProjects", "pendingAccessReviewInstances", "permissionGrants", "postalCode", "preferredDataLocation", "preferredLanguage", "preferredName", "presence", "print", "profile", "responsibilities", "schools", "security", "serviceProvisioningErrors", "settings", "showInAddressList", "skills", "sponsors", "state", "streetAddress", "surname", "todo", "transitiveMemberOf", "usageLocation", "usageRights", "userType", "virtualEvents", "windowsInformationProtectionDeviceRegistrations"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    account_enabled                   = false
    display_name                      = "example"
    mail_nickname                     = "example"
    password_profile                  = { "forceChangePasswordNextSignIn" = null }
    user_principal_name               = "example"
    about_me                          = "example"
    is_resource_account               = false
    device_enrollment_limit           = -2147483648
    authorization_info                = { "certificateUserIds" = null }
    app_consent_requests_for_approval = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mailNickname"]) == jsonencode("example")
    error_message = "mailNickname must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["passwordProfile"]) == jsonencode({ "@odata.type" = "#microsoft.graph.passwordProfile" })
    error_message = "passwordProfile must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userPrincipalName"]) == jsonencode("example")
    error_message = "userPrincipalName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["aboutMe"]) == jsonencode("example")
    error_message = "aboutMe must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isResourceAccount"]) == jsonencode(false)
    error_message = "isResourceAccount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceEnrollmentLimit"]) == jsonencode(-2147483648)
    error_message = "deviceEnrollmentLimit must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["authorizationInfo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.authorizationInfo" })
    error_message = "authorizationInfo must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appConsentRequestsForApproval"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appConsentRequest" }])
    error_message = "appConsentRequestsForApproval must preserve typed values and omit nested nulls."
  }
}

run "profile_in_additional_properties" {
  command = plan

  variables {
    additional_properties = { "accountEnabled" = false, "displayName" = "example", "mailNickname" = "example", "passwordProfile" = { "@odata.type" = "#microsoft.graph.passwordProfile" }, "userPrincipalName" = "example" }
  }

  assert {
    condition     = alltrue([for key in ["accountEnabled", "displayName", "mailNickname", "passwordProfile", "userPrincipalName"] : contains(keys(msgraph_resource.this.body), key)])
    error_message = "A creation profile in additional_properties must reach the Graph request."
  }
}

run "missing_profile" {
  command = plan

  expect_failures = [msgraph_resource.this]
}
