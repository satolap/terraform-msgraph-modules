variable "device_count" {
  description = "The number of devices that have installed this application"
  type        = number
  default     = null
}

variable "managed_devices" {
  description = "The devices that have the discovered application installed"
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.managedDevice")
    complianceState = optional(string)
    deviceCategory  = optional(any)
    deviceCompliancePolicyStates = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.deviceCompliancePolicyState")
      displayName   = optional(string)
      platformType  = optional(string)
      settingCount  = optional(number)
      settingStates = optional(any)
      state         = optional(string)
      version       = optional(number)
    })))
    deviceConfigurationStates = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.deviceConfigurationState")
      displayName   = optional(string)
      platformType  = optional(string)
      settingCount  = optional(number)
      settingStates = optional(any)
      state         = optional(string)
      version       = optional(number)
    })))
    deviceEnrollmentType      = optional(string)
    deviceRegistrationState   = optional(string)
    exchangeAccessState       = optional(string)
    exchangeAccessStateReason = optional(string)
    logCollectionRequests = optional(list(object({
      odata_type                   = optional(string, "#microsoft.graph.deviceLogCollectionResponse")
      enrolledByUser               = optional(string)
      expirationDateTimeUTC        = optional(string)
      initiatedByUserPrincipalName = optional(string)
      managedDeviceId              = optional(string)
      receivedDateTimeUTC          = optional(string)
      requestedDateTimeUTC         = optional(string)
      sizeInKB                     = optional(any)
      status                       = optional(string)
    })))
    managedDeviceName          = optional(string)
    managedDeviceOwnerType     = optional(string)
    managementAgent            = optional(string)
    managementState            = optional(string)
    notes                      = optional(string)
    partnerReportedThreatState = optional(string)
    users = optional(list(object({
      odata_type                            = optional(string, "#microsoft.graph.user")
      aboutMe                               = optional(string)
      accountEnabled                        = optional(bool)
      ageGroup                              = optional(string)
      appRoleAssignments                    = optional(any)
      assignedLicenses                      = optional(any)
      authentication                        = optional(any)
      authorizationInfo                     = optional(any)
      birthday                              = optional(string)
      chats                                 = optional(any)
      city                                  = optional(string)
      cloudClipboard                        = optional(any)
      companyName                           = optional(string)
      consentProvidedForMinor               = optional(string)
      country                               = optional(string)
      customSecurityAttributes              = optional(any)
      deletedDateTime                       = optional(string)
      department                            = optional(string)
      deviceEnrollmentLimit                 = optional(number)
      deviceManagementTroubleshootingEvents = optional(any)
      displayName                           = optional(string)
      employeeExperience                    = optional(any)
      employeeHireDate                      = optional(string)
      employeeId                            = optional(string)
      employeeLeaveDateTime                 = optional(string)
      employeeOrgData                       = optional(any)
      employeeType                          = optional(string)
      externalUserState                     = optional(string)
      externalUserStateChangeDateTime       = optional(string)
      faxNumber                             = optional(string)
      followedSites                         = optional(any)
      givenName                             = optional(string)
      hireDate                              = optional(string)
      identities                            = optional(any)
      identityParentId                      = optional(string)
      inferenceClassification               = optional(any)
      interests                             = optional(list(string))
      isResourceAccount                     = optional(bool)
      jobTitle                              = optional(string)
      joinedTeams                           = optional(any)
      lastPasswordChangeDateTime            = optional(string)
      mail                                  = optional(string)
      mailNickname                          = optional(string)
      mailboxSettings                       = optional(any)
      managedAppRegistrations               = optional(any)
      managedDevices                        = optional(any)
      mySite                                = optional(string)
      oauth2PermissionGrants                = optional(any)
      officeLocation                        = optional(string)
      onPremisesImmutableId                 = optional(string)
      onPremisesProvisioningErrors          = optional(any)
      onPremisesSyncBehavior                = optional(any)
      onenote                               = optional(any)
      onlineMeetings                        = optional(any)
      otherMails                            = optional(list(string))
      outlook                               = optional(any)
      passwordPolicies                      = optional(string)
      passwordProfile                       = optional(any)
      pastProjects                          = optional(list(string))
      permissionGrants                      = optional(any)
      postalCode                            = optional(string)
      preferredDataLocation                 = optional(string)
      preferredLanguage                     = optional(string)
      preferredName                         = optional(string)
      presence                              = optional(any)
      print                                 = optional(any)
      responsibilities                      = optional(list(string))
      schools                               = optional(list(string))
      scopedRoleMemberOf                    = optional(any)
      serviceProvisioningErrors             = optional(any)
      settings                              = optional(any)
      showInAddressList                     = optional(bool)
      skills                                = optional(list(string))
      sponsors                              = optional(any)
      state                                 = optional(string)
      streetAddress                         = optional(string)
      surname                               = optional(string)
      todo                                  = optional(any)
      transitiveMemberOf                    = optional(any)
      usageLocation                         = optional(string)
      userPrincipalName                     = optional(string)
      userType                              = optional(string)
    })))
  }))
  default   = null
  sensitive = true
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.detectedApp"
  nullable    = false
}

variable "platform" {
  description = "Indicates the operating system / platform of the discovered application.  Some possible values are Windows, iOS, macOS. The default value is unknown (0)."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["unknown", "windows", "windowsMobile", "windowsHolographic", "ios", "macOS", "chromeOS", "androidOSP", "androidDeviceAdministrator", "androidWorkProfile", "androidDedicatedAndFullyManaged", "unknownFutureValue"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "publisher" {
  description = "Indicates the publisher of the discovered application. For example: 'Microsoft'.  The default value is an empty string."
  type        = string
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id", "sizeInByte", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
