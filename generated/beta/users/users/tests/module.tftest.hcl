# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "users"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aboutMe", "accountEnabled", "ageGroup", "analytics", "appConsentRequestsForApproval", "appRoleAssignedResources", "appRoleAssignments", "approvals", "assignedLicenses", "authentication", "authorizationInfo", "birthday", "chats", "city", "cloudClipboard", "cloudLicensing", "cloudRealtimeCommunicationInfo", "communications", "companyName", "consentProvidedForMinor", "country", "customSecurityAttributes", "deletedDateTime", "department", "deviceEnrollmentConfigurations", "deviceEnrollmentLimit", "deviceKeys", "deviceManagementTroubleshootingEvents", "devices", "displayName", "employeeHireDate", "employeeId", "employeeLeaveDateTime", "employeeOrgData", "employeeType", "extensions", "externalUserState", "externalUserStateChangeDateTime", "faxNumber", "followedSites", "givenName", "hireDate", "identities", "identityGovernance", "identityParentId", "inferenceClassification", "infoCatalogs", "informationProtection", "interests", "invitedBy", "isResourceAccount", "jobTitle", "joinedGroups", "licenseDetails", "mail", "mailNickname", "mailboxSettings", "managedAppLogCollectionRequests", "managedAppRegistrations", "managedDevices", "mobileAppIntentAndStates", "mobileAppTroubleshootingEvents", "mySite", "notifications", "oauth2PermissionGrants", "officeLocation", "onPremisesDistinguishedName", "onPremisesDomainName", "onPremisesImmutableId", "onPremisesProvisioningErrors", "onPremisesSamAccountName", "onPremisesSecurityIdentifier", "onPremisesSyncBehavior", "onPremisesUserPrincipalName", "onenote", "onlineMeetings", "otherMails", "passwordPolicies", "passwordProfile", "pastProjects", "pendingAccessReviewInstances", "permissionGrants", "postalCode", "preferredDataLocation", "preferredLanguage", "preferredName", "presence", "print", "profile", "responsibilities", "schools", "security", "serviceProvisioningErrors", "settings", "showInAddressList", "skills", "sponsors", "state", "streetAddress", "surname", "todo", "transitiveMemberOf", "usageLocation", "usageRights", "userPrincipalName", "userType", "virtualEvents", "windowsInformationProtectionDeviceRegistrations"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    about_me                          = "example"
    account_enabled                   = false
    device_enrollment_limit           = -2147483648
    app_consent_requests_for_approval = [{}]
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
    condition     = jsonencode(msgraph_resource.this.body["appConsentRequestsForApproval"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appConsentRequest" }])
    error_message = "appConsentRequestsForApproval must preserve typed values and omit nested nulls."
  }
}
