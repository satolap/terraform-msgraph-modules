# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      output = { response = {} }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = { response = {} }
    }
  }
}

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

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    select_response     = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["analytics", "appConsentRequestsForApproval", "appRoleAssignedResources", "appRoleAssignments", "approvals", "authentication", "chats", "cloudClipboard", "communications", "deviceEnrollmentConfigurations", "deviceManagementTroubleshootingEvents", "devices", "extensions", "followedSites", "inferenceClassification", "informationProtection", "invitedBy", "joinedGroups", "licenseDetails", "managedAppLogCollectionRequests", "managedAppRegistrations", "managedDevices", "mobileAppIntentAndStates", "mobileAppTroubleshootingEvents", "notifications", "oauth2PermissionGrants", "onPremisesSyncBehavior", "onenote", "onlineMeetings", "pendingAccessReviewInstances", "permissionGrants", "presence", "profile", "security", "settings", "sponsors", "todo", "transitiveMemberOf", "usageRights", "virtualEvents", "windowsInformationProtectionDeviceRegistrations"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
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

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    timeouts            = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    timeouts            = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    timeouts            = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    timeouts            = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}

# Offline clearing tests: the reviewed properties are cleared by a separate update-only sidecar.

run "clear_properties_default_has_no_sidecar" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
  }

  assert {
    condition     = length(msgraph_update_resource.clear) == 0
    error_message = "Without clear_properties no clearing request exists."
  }

  assert {
    condition     = length(data.msgraph_resource.after_writes) == 0
    error_message = "Without clear_properties no ordered read exists."
  }
}

run "clear_properties_send_json_null" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    clear_properties    = ["ageGroup", "consentProvidedForMinor"]
  }

  assert {
    condition     = length(msgraph_update_resource.clear) == 1
    error_message = "Listing a name must create the clearing request."
  }

  assert {
    condition     = length(data.msgraph_resource.after_writes) == 1
    error_message = "Listing a name must create the ordered read."
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.clear[0].body) == jsonencode({ "ageGroup" = null, "consentProvidedForMinor" = null })
    error_message = "The clearing request must send exactly the listed names as JSON null."
  }

  assert {
    condition     = msgraph_update_resource.clear[0].update_method == "PATCH"
    error_message = "The clearing request must PATCH."
  }

  assert {
    condition     = msgraph_update_resource.clear[0].ignore_missing_property == false
    error_message = "The clearing request must not ignore a missing property."
  }

  assert {
    condition     = data.msgraph_resource.after_writes[0].query_parameters == null
    error_message = "The ordered output GET must remain unselected by default."
  }

  assert {
    condition     = alltrue([for name in ["ageGroup", "consentProvidedForMinor"] : !contains(keys(msgraph_resource.this.body), name)])
    error_message = "A cleared property must not be in the request of the main resource."
  }
}

run "clear_properties_refuse_an_unreviewed_name" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    clear_properties    = ["__graphmodules_unreviewed__"]
  }

  expect_failures = [var.clear_properties]
}

run "clear_properties_refuse_a_null_name" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    clear_properties    = [null]
  }

  expect_failures = [var.clear_properties]
}

run "clear_properties_refuse_a_repeated_name" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    clear_properties    = ["ageGroup", "ageGroup"]
  }

  expect_failures = [var.clear_properties]
}

run "clear_properties_selected_response_is_opt_in" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    clear_properties    = ["ageGroup", "consentProvidedForMinor"]
    select_response     = true
  }

  assert {
    condition     = data.msgraph_resource.after_writes[0].query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["analytics", "appConsentRequestsForApproval", "appRoleAssignedResources", "appRoleAssignments", "approvals", "authentication", "chats", "cloudClipboard", "communications", "deviceEnrollmentConfigurations", "deviceManagementTroubleshootingEvents", "devices", "extensions", "followedSites", "inferenceClassification", "informationProtection", "invitedBy", "joinedGroups", "licenseDetails", "managedAppLogCollectionRequests", "managedAppRegistrations", "managedDevices", "mobileAppIntentAndStates", "mobileAppTroubleshootingEvents", "notifications", "oauth2PermissionGrants", "onPremisesSyncBehavior", "onenote", "onlineMeetings", "pendingAccessReviewInstances", "permissionGrants", "presence", "profile", "security", "settings", "sponsors", "todo", "transitiveMemberOf", "usageRights", "virtualEvents", "windowsInformationProtectionDeviceRegistrations"], name)])], var.clear_properties))))
    error_message = "Only the selection opt-in may narrow the ordered output GET; cleared names must be included."
  }
}

run "clear_property_refuses_a_typed_value" {
  command = plan

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    age_group           = "example"
    clear_properties    = ["ageGroup"]
  }

  expect_failures = [msgraph_resource.this]
}

run "clear_property_refuses_an_additional_properties_value" {
  command = plan

  variables {
    account_enabled       = false
    display_name          = "example"
    mail_nickname         = "example"
    password_profile      = {}
    user_principal_name   = "example"
    additional_properties = { "ageGroup" = "example" }
    clear_properties      = ["ageGroup"]
  }

  expect_failures = [msgraph_resource.this]
}

# Apply runs: the clearing request follows clear_properties and the object is only ever updated in place.

run "clear_properties_apply_creates_the_request" {
  command = apply

  variables {
    account_enabled     = false
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    clear_properties    = ["ageGroup"]
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.clear[0].body) == jsonencode({ "ageGroup" = null })
    error_message = "The first apply must send the listed name as null."
  }
}

run "clear_properties_apply_after_an_input_change" {
  command = apply

  variables {
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    account_enabled     = true
    clear_properties    = ["ageGroup"]
  }

  assert {
    condition     = msgraph_resource.this.id == run.clear_properties_apply_creates_the_request.id
    error_message = "A changed input must update the object in place."
  }

  assert {
    condition     = length(msgraph_update_resource.clear) == 1
    error_message = "The clearing request must remain while a name is listed."
  }
}

run "clear_properties_apply_adds_a_name" {
  command = apply

  variables {
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    account_enabled     = true
    clear_properties    = ["ageGroup", "consentProvidedForMinor"]
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.clear[0].body) == jsonencode({ "ageGroup" = null, "consentProvidedForMinor" = null })
    error_message = "Listing a second name must send both as null."
  }
}

run "clear_properties_apply_stops_clearing" {
  command = apply

  variables {
    display_name        = "example"
    mail_nickname       = "example"
    password_profile    = {}
    user_principal_name = "example"
    account_enabled     = true
  }

  assert {
    condition     = length(msgraph_update_resource.clear) == 0
    error_message = "An empty clear_properties must remove the clearing request."
  }

  assert {
    condition     = length(data.msgraph_resource.after_writes) == 0
    error_message = "An empty clear_properties must remove the ordered read."
  }

  assert {
    condition     = msgraph_resource.this.id == run.clear_properties_apply_adds_a_name.id
    error_message = "Stopping must not replace the object."
  }
}
