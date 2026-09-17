variable "device_count" {
  description = "The number of devices that have installed this application"
  type        = number
  default     = null
}

variable "managed_devices" {
  description = "The devices that have the discovered application installed"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedDevice")
    assignmentFilterEvaluationStatusDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.assignmentFilterEvaluationStatusDetails")
      payloadId  = optional(string)
    })))
    chassisType = optional(string)
    chromeOSDeviceInfo = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.chromeOSDeviceProperty")
      name       = optional(string)
      updatable  = optional(bool)
      value      = optional(string)
      valueType  = optional(string)
    })))
    cloudPcRemoteActionResults = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.cloudPcRemoteActionResult")
      actionName          = optional(string)
      lastUpdatedDateTime = optional(string)
      startDateTime       = optional(string)
      statusDetail        = optional(any)
      statusDetails       = optional(any)
    })))
    complianceState                       = optional(string)
    configurationManagerClientHealthState = optional(any)
    configurationManagerClientInformation = optional(any)
    detectedApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.detectedApp")
      deviceCount    = optional(number)
      managedDevices = optional(any)
      platform       = optional(string)
      publisher      = optional(string)
    })))
    deviceCategory = optional(any)
    deviceCompliancePolicyStates = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.deviceCompliancePolicyState")
      displayName       = optional(string)
      platformType      = optional(string)
      settingCount      = optional(number)
      settingStates     = optional(any)
      state             = optional(string)
      userId            = optional(string)
      userPrincipalName = optional(string)
      version           = optional(number)
    })))
    deviceConfigurationStates = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.deviceConfigurationState")
      displayName       = optional(string)
      platformType      = optional(string)
      settingCount      = optional(number)
      settingStates     = optional(any)
      state             = optional(string)
      userId            = optional(string)
      userPrincipalName = optional(string)
      version           = optional(number)
    })))
    deviceEnrollmentType                        = optional(string)
    deviceFirmwareConfigurationInterfaceManaged = optional(bool)
    deviceRegistrationState                     = optional(string)
    deviceType                                  = optional(string)
    exchangeAccessState                         = optional(string)
    exchangeAccessStateReason                   = optional(string)
    joinType                                    = optional(string)
    logCollectionRequests = optional(list(object({
      odata_type                   = optional(string, "#microsoft.graph.deviceLogCollectionResponse")
      enrolledByUser               = optional(string)
      errorCode                    = optional(number)
      expirationDateTimeUTC        = optional(string)
      initiatedByUserPrincipalName = optional(string)
      managedDeviceId              = optional(string)
      receivedDateTimeUTC          = optional(string)
      requestedDateTimeUTC         = optional(string)
      size                         = optional(any)
      sizeInKB                     = optional(any)
      status                       = optional(string)
    })))
    lostModeState = optional(string)
    managedDeviceMobileAppConfigurationStates = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationState")
      displayName       = optional(string)
      platformType      = optional(string)
      settingCount      = optional(number)
      settingStates     = optional(any)
      state             = optional(string)
      userId            = optional(string)
      userPrincipalName = optional(string)
      version           = optional(number)
    })))
    managedDeviceName          = optional(string)
    managedDeviceOwnerType     = optional(string)
    managementAgent            = optional(string)
    managementFeatures         = optional(string)
    managementState            = optional(string)
    notes                      = optional(string)
    ownerType                  = optional(string)
    partnerReportedThreatState = optional(string)
    processorArchitecture      = optional(string)
    roleScopeTagIds            = optional(list(string))
    securityBaselineStates = optional(list(object({
      odata_type                 = optional(string, "#microsoft.graph.securityBaselineState")
      displayName                = optional(string)
      securityBaselineTemplateId = optional(string)
      settingStates              = optional(any)
      state                      = optional(string)
      userPrincipalName          = optional(string)
    })))
    skuFamily = optional(string)
    users = optional(list(object({
      odata_type                                      = optional(string, "#microsoft.graph.user")
      aboutMe                                         = optional(string)
      accountEnabled                                  = optional(bool)
      ageGroup                                        = optional(string)
      analytics                                       = optional(any)
      appConsentRequestsForApproval                   = optional(any)
      appRoleAssignedResources                        = optional(any)
      appRoleAssignments                              = optional(any)
      approvals                                       = optional(any)
      assignedLicenses                                = optional(any)
      authentication                                  = optional(any)
      authorizationInfo                               = optional(any)
      birthday                                        = optional(string)
      chats                                           = optional(any)
      city                                            = optional(string)
      cloudClipboard                                  = optional(any)
      cloudLicensing                                  = optional(any)
      cloudRealtimeCommunicationInfo                  = optional(any)
      communications                                  = optional(any)
      companyName                                     = optional(string)
      consentProvidedForMinor                         = optional(string)
      country                                         = optional(string)
      customSecurityAttributes                        = optional(any)
      deletedDateTime                                 = optional(string)
      department                                      = optional(string)
      deviceEnrollmentConfigurations                  = optional(any)
      deviceEnrollmentLimit                           = optional(number)
      deviceKeys                                      = optional(any)
      deviceManagementTroubleshootingEvents           = optional(any)
      devices                                         = optional(any)
      displayName                                     = optional(string)
      employeeHireDate                                = optional(string)
      employeeId                                      = optional(string)
      employeeLeaveDateTime                           = optional(string)
      employeeOrgData                                 = optional(any)
      employeeType                                    = optional(string)
      extensions                                      = optional(any)
      externalUserState                               = optional(string)
      externalUserStateChangeDateTime                 = optional(string)
      faxNumber                                       = optional(string)
      followedSites                                   = optional(any)
      givenName                                       = optional(string)
      hireDate                                        = optional(string)
      identities                                      = optional(any)
      identityGovernance                              = optional(any)
      identityParentId                                = optional(string)
      inferenceClassification                         = optional(any)
      infoCatalogs                                    = optional(list(string))
      informationProtection                           = optional(any)
      interests                                       = optional(list(string))
      invitedBy                                       = optional(any)
      isResourceAccount                               = optional(bool)
      jobTitle                                        = optional(string)
      joinedGroups                                    = optional(any)
      licenseDetails                                  = optional(any)
      mail                                            = optional(string)
      mailNickname                                    = optional(string)
      mailboxSettings                                 = optional(any)
      managedAppLogCollectionRequests                 = optional(any)
      managedAppRegistrations                         = optional(any)
      managedDevices                                  = optional(any)
      mobileAppIntentAndStates                        = optional(any)
      mobileAppTroubleshootingEvents                  = optional(any)
      mySite                                          = optional(string)
      notifications                                   = optional(any)
      oauth2PermissionGrants                          = optional(any)
      officeLocation                                  = optional(string)
      onPremisesDistinguishedName                     = optional(string)
      onPremisesDomainName                            = optional(string)
      onPremisesImmutableId                           = optional(string)
      onPremisesProvisioningErrors                    = optional(any)
      onPremisesSamAccountName                        = optional(string)
      onPremisesSecurityIdentifier                    = optional(string)
      onPremisesSyncBehavior                          = optional(any)
      onPremisesUserPrincipalName                     = optional(string)
      onenote                                         = optional(any)
      onlineMeetings                                  = optional(any)
      otherMails                                      = optional(list(string))
      passwordPolicies                                = optional(string)
      passwordProfile                                 = optional(any)
      pastProjects                                    = optional(list(string))
      pendingAccessReviewInstances                    = optional(any)
      permissionGrants                                = optional(any)
      postalCode                                      = optional(string)
      preferredDataLocation                           = optional(string)
      preferredLanguage                               = optional(string)
      preferredName                                   = optional(string)
      presence                                        = optional(any)
      print                                           = optional(any)
      profile                                         = optional(any)
      responsibilities                                = optional(list(string))
      schools                                         = optional(list(string))
      security                                        = optional(any)
      serviceProvisioningErrors                       = optional(any)
      settings                                        = optional(any)
      showInAddressList                               = optional(bool)
      skills                                          = optional(list(string))
      sponsors                                        = optional(any)
      state                                           = optional(string)
      streetAddress                                   = optional(string)
      surname                                         = optional(string)
      todo                                            = optional(any)
      transitiveMemberOf                              = optional(any)
      usageLocation                                   = optional(string)
      usageRights                                     = optional(any)
      userPrincipalName                               = optional(string)
      userType                                        = optional(string)
      virtualEvents                                   = optional(any)
      windowsInformationProtectionDeviceRegistrations = optional(any)
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
