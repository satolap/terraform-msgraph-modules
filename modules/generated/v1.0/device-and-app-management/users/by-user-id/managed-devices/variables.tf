variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "compliance_state" {
  description = "Compliance state."
  type        = string
  default     = null

  validation {
    condition     = var.compliance_state == null ? true : contains(["unknown", "compliant", "noncompliant", "conflict", "error", "inGracePeriod", "configManager"], var.compliance_state)
    error_message = "compliance_state must be one of the documented enum values."
  }
}

variable "device_category" {
  description = "Device category"
  type        = any
  default     = null
}

variable "device_compliance_policy_states" {
  description = "Device compliance policy states for this device."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.deviceCompliancePolicyState")
    displayName  = optional(string)
    platformType = optional(string)
    settingCount = optional(number)
    settingStates = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.deviceCompliancePolicySettingState")
      currentValue        = optional(string)
      errorCode           = optional(number)
      errorDescription    = optional(string)
      instanceDisplayName = optional(string)
      setting             = optional(string)
      settingName         = optional(string)
      sources             = optional(any)
      state               = optional(string)
      userEmail           = optional(string)
      userId              = optional(string)
      userName            = optional(string)
      userPrincipalName   = optional(string)
    })))
    state   = optional(string)
    version = optional(number)
  }))
  default = null
}

variable "device_configuration_states" {
  description = "Device configuration states for this device."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.deviceConfigurationState")
    displayName  = optional(string)
    platformType = optional(string)
    settingCount = optional(number)
    settingStates = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.deviceConfigurationSettingState")
      currentValue        = optional(string)
      errorCode           = optional(number)
      errorDescription    = optional(string)
      instanceDisplayName = optional(string)
      setting             = optional(string)
      settingName         = optional(string)
      sources             = optional(any)
      state               = optional(string)
      userEmail           = optional(string)
      userId              = optional(string)
      userName            = optional(string)
      userPrincipalName   = optional(string)
    })))
    state   = optional(string)
    version = optional(number)
  }))
  default = null
}

variable "device_enrollment_type" {
  description = "Possible ways of adding a mobile device to management."
  type        = string
  default     = null

  validation {
    condition     = var.device_enrollment_type == null ? true : contains(["unknown", "userEnrollment", "deviceEnrollmentManager", "appleBulkWithUser", "appleBulkWithoutUser", "windowsAzureADJoin", "windowsBulkUserless", "windowsAutoEnrollment", "windowsBulkAzureDomainJoin", "windowsCoManagement", "windowsAzureADJoinUsingDeviceAuth", "appleUserEnrollment", "appleUserEnrollmentWithServiceAccount", "unknownFutureValue"], var.device_enrollment_type)
    error_message = "device_enrollment_type must be one of the documented enum values."
  }
}

variable "device_registration_state" {
  description = "Device registration status."
  type        = string
  default     = null

  validation {
    condition     = var.device_registration_state == null ? true : contains(["notRegistered", "registered", "revoked", "keyConflict", "approvalPending", "certificateReset", "notRegisteredPendingEnrollment", "unknown"], var.device_registration_state)
    error_message = "device_registration_state must be one of the documented enum values."
  }
}

variable "exchange_access_state" {
  description = "Device Exchange Access State."
  type        = string
  default     = null

  validation {
    condition     = var.exchange_access_state == null ? true : contains(["none", "unknown", "allowed", "blocked", "quarantined"], var.exchange_access_state)
    error_message = "exchange_access_state must be one of the documented enum values."
  }
}

variable "exchange_access_state_reason" {
  description = "Device Exchange Access State Reason."
  type        = string
  default     = null

  validation {
    condition     = var.exchange_access_state_reason == null ? true : contains(["none", "unknown", "exchangeGlobalRule", "exchangeIndividualRule", "exchangeDeviceRule", "exchangeUpgrade", "exchangeMailboxPolicy", "other", "compliant", "notCompliant", "notEnrolled", "unknownLocation", "mfaRequired", "azureADBlockDueToAccessPolicy", "compromisedPassword", "deviceNotKnownWithManagedApp"], var.exchange_access_state_reason)
    error_message = "exchange_access_state_reason must be one of the documented enum values."
  }
}

variable "log_collection_requests" {
  description = "List of log collection requests"
  type = list(object({
    odata_type                   = optional(string, "#microsoft.graph.deviceLogCollectionResponse")
    enrolledByUser               = optional(string)
    expirationDateTimeUTC        = optional(string)
    initiatedByUserPrincipalName = optional(string)
    managedDeviceId              = optional(string)
    receivedDateTimeUTC          = optional(string)
    requestedDateTimeUTC         = optional(string)
    sizeInKB                     = optional(any)
    status                       = optional(string)
  }))
  default = null
}

variable "managed_device_name" {
  description = "Automatically generated name to identify a device. Can be overwritten to a user friendly name."
  type        = string
  default     = null
}

variable "managed_device_owner_type" {
  description = "Owner type of device."
  type        = string
  default     = null

  validation {
    condition     = var.managed_device_owner_type == null ? true : contains(["unknown", "company", "personal", "unknownFutureValue"], var.managed_device_owner_type)
    error_message = "managed_device_owner_type must be one of the documented enum values."
  }
}

variable "management_agent" {
  description = "Microsoft Graph managementAgent property."
  type        = string
  default     = null

  validation {
    condition     = var.management_agent == null ? true : contains(["eas", "mdm", "easMdm", "intuneClient", "easIntuneClient", "configurationManagerClient", "configurationManagerClientMdm", "configurationManagerClientMdmEas", "unknown", "jamf", "googleCloudDevicePolicyController", "microsoft365ManagedMdm", "msSense"], var.management_agent)
    error_message = "management_agent must be one of the documented enum values."
  }
}

variable "management_state" {
  description = "Management state of device in Microsoft Intune."
  type        = string
  default     = null

  validation {
    condition     = var.management_state == null ? true : contains(["managed", "retirePending", "retireFailed", "wipePending", "wipeFailed", "unhealthy", "deletePending", "retireIssued", "wipeIssued", "wipeCanceled", "retireCanceled", "discovered", "unknownFutureValue"], var.management_state)
    error_message = "management_state must be one of the documented enum values."
  }
}

variable "notes" {
  description = "Notes on the device created by IT Admin. Default is null. To retrieve actual values GET call needs to be made, with device id and included in select parameter. Supports: $select. $Search is not supported."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedDevice"
  nullable    = false
}

variable "partner_reported_threat_state" {
  description = "Available health states for the Device Health API"
  type        = string
  default     = null

  validation {
    condition     = var.partner_reported_threat_state == null ? true : contains(["unknown", "activated", "deactivated", "secured", "lowSeverity", "mediumSeverity", "highSeverity", "unresponsive", "compromised", "misconfigured"], var.partner_reported_threat_state)
    error_message = "partner_reported_threat_state must be one of the documented enum values."
  }
}

variable "users" {
  description = "The primary users associated with the managed device."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.user")
    aboutMe        = optional(string)
    accountEnabled = optional(bool)
    ageGroup       = optional(string)
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    assignedLicenses = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.assignedLicense")
      disabledPlans = optional(list(string))
      skuId         = optional(string)
    })))
    authentication    = optional(any)
    authorizationInfo = optional(any)
    birthday          = optional(string)
    chats = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.chat")
      chatType                = optional(string)
      installedApps           = optional(any)
      lastMessagePreview      = optional(any)
      members                 = optional(any)
      messages                = optional(any)
      migrationMode           = optional(any)
      originalCreatedDateTime = optional(string)
      permissionGrants        = optional(any)
      pinnedMessages          = optional(any)
      tabs                    = optional(any)
      targetedMessages        = optional(any)
      topic                   = optional(string)
      viewpoint               = optional(any)
    })))
    city                     = optional(string)
    cloudClipboard           = optional(any)
    companyName              = optional(string)
    consentProvidedForMinor  = optional(string)
    country                  = optional(string)
    customSecurityAttributes = optional(any)
    deletedDateTime          = optional(string)
    department               = optional(string)
    deviceEnrollmentLimit    = optional(number)
    deviceManagementTroubleshootingEvents = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")
      correlationId = optional(string)
      eventDateTime = optional(string)
    })))
    displayName                     = optional(string)
    employeeExperience              = optional(any)
    employeeHireDate                = optional(string)
    employeeId                      = optional(string)
    employeeLeaveDateTime           = optional(string)
    employeeOrgData                 = optional(any)
    employeeType                    = optional(string)
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.site")
      analytics       = optional(any)
      columns         = optional(any)
      contentTypes    = optional(any)
      description     = optional(string)
      drive           = optional(any)
      drives          = optional(any)
      error           = optional(any)
      externalColumns = optional(any)
      items           = optional(any)
      lists           = optional(any)
      name            = optional(string)
      onenote         = optional(any)
      operations      = optional(any)
      pages           = optional(any)
      parentReference = optional(any)
      permissions     = optional(any)
      sites           = optional(any)
      termStore       = optional(any)
      termStores      = optional(any)
    })))
    givenName = optional(string)
    hireDate  = optional(string)
    identities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.objectIdentity")
      issuer           = optional(string)
      issuerAssignedId = optional(string)
      signInType       = optional(string)
    })))
    identityParentId        = optional(string)
    inferenceClassification = optional(any)
    interests               = optional(list(string))
    isResourceAccount       = optional(bool)
    jobTitle                = optional(string)
    joinedTeams = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.team")
      allChannels       = optional(any)
      channels          = optional(any)
      classification    = optional(string)
      createdDateTime   = optional(string)
      description       = optional(string)
      displayName       = optional(string)
      firstChannelName  = optional(string)
      funSettings       = optional(any)
      group             = optional(any)
      guestSettings     = optional(any)
      incomingChannels  = optional(any)
      installedApps     = optional(any)
      internalId        = optional(string)
      memberSettings    = optional(any)
      members           = optional(any)
      messagingSettings = optional(any)
      operations        = optional(any)
      permissionGrants  = optional(any)
      photo             = optional(any)
      primaryChannel    = optional(any)
      schedule          = optional(any)
      specialization    = optional(any)
      summary           = optional(any)
      tags              = optional(any)
      template          = optional(any)
      tenantId          = optional(string)
      visibility        = optional(any)
      webUrl            = optional(string)
    })))
    lastPasswordChangeDateTime = optional(string)
    mail                       = optional(string)
    mailNickname               = optional(string)
    mailboxSettings            = optional(any)
    managedAppRegistrations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.managedAppRegistration")
      appIdentifier        = optional(any)
      applicationVersion   = optional(string)
      appliedPolicies      = optional(any)
      createdDateTime      = optional(string)
      deviceName           = optional(string)
      deviceTag            = optional(string)
      deviceType           = optional(string)
      flaggedReasons       = optional(list(string))
      intendedPolicies     = optional(any)
      lastSyncDateTime     = optional(string)
      managementSdkVersion = optional(string)
      operations           = optional(any)
      platformVersion      = optional(string)
      userId               = optional(string)
      version              = optional(string)
    })))
    managedDevices = optional(list(object({
      odata_type                   = optional(string, "#microsoft.graph.managedDevice")
      complianceState              = optional(string)
      deviceCategory               = optional(any)
      deviceCompliancePolicyStates = optional(any)
      deviceConfigurationStates    = optional(any)
      deviceEnrollmentType         = optional(string)
      deviceRegistrationState      = optional(string)
      exchangeAccessState          = optional(string)
      exchangeAccessStateReason    = optional(string)
      logCollectionRequests        = optional(any)
      managedDeviceName            = optional(string)
      managedDeviceOwnerType       = optional(string)
      managementAgent              = optional(string)
      managementState              = optional(string)
      notes                        = optional(string)
      partnerReportedThreatState   = optional(string)
      users                        = optional(any)
    })))
    mySite = optional(string)
    oauth2PermissionGrants = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.oAuth2PermissionGrant")
      clientId    = optional(string)
      consentType = optional(string)
      principalId = optional(string)
      resourceId  = optional(string)
      scope       = optional(string)
    })))
    officeLocation        = optional(string)
    onPremisesImmutableId = optional(string)
    onPremisesProvisioningErrors = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
      category             = optional(string)
      occurredDateTime     = optional(string)
      propertyCausingError = optional(string)
      value                = optional(string)
    })))
    onPremisesSyncBehavior = optional(any)
    onenote                = optional(any)
    onlineMeetings = optional(list(object({
      odata_type                           = optional(string, "#microsoft.graph.onlineMeeting")
      allowAttendeeToEnableCamera          = optional(bool)
      allowAttendeeToEnableMic             = optional(bool)
      allowBreakoutRooms                   = optional(bool)
      allowCopyingAndSharingMeetingContent = optional(bool)
      allowLiveShare                       = optional(any)
      allowMeetingChat                     = optional(any)
      allowParticipantsToChangeName        = optional(bool)
      allowPowerPointSharing               = optional(bool)
      allowRecording                       = optional(bool)
      allowTeamworkReactions               = optional(bool)
      allowTranscription                   = optional(bool)
      allowWhiteboard                      = optional(bool)
      allowedLobbyAdmitters                = optional(any)
      allowedPresenters                    = optional(any)
      broadcastSettings                    = optional(any)
      chatInfo                             = optional(any)
      chatRestrictions                     = optional(any)
      endDateTime                          = optional(string)
      expiryDateTime                       = optional(string)
      externalId                           = optional(string)
      isBroadcast                          = optional(bool)
      isEndToEndEncryptionEnabled          = optional(bool)
      isEntryExitAnnounced                 = optional(bool)
      joinMeetingIdSettings                = optional(any)
      lobbyBypassSettings                  = optional(any)
      meetingOptionsWebUrl                 = optional(string)
      meetingSpokenLanguageTag             = optional(string)
      meetingTemplateId                    = optional(string)
      participants                         = optional(any)
      recordAutomatically                  = optional(bool)
      sensitivityLabelAssignment           = optional(any)
      shareMeetingChatHistoryDefault       = optional(any)
      startDateTime                        = optional(string)
      subject                              = optional(string)
      watermarkProtection                  = optional(any)
    })))
    otherMails       = optional(list(string))
    outlook          = optional(any)
    passwordPolicies = optional(string)
    passwordProfile  = optional(any)
    pastProjects     = optional(list(string))
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    postalCode            = optional(string)
    preferredDataLocation = optional(string)
    preferredLanguage     = optional(string)
    preferredName         = optional(string)
    presence              = optional(any)
    print                 = optional(any)
    responsibilities      = optional(list(string))
    schools               = optional(list(string))
    scopedRoleMemberOf = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.scopedRoleMembership")
      administrativeUnitId = optional(string)
      roleId               = optional(string)
      roleMemberInfo = optional(object({
        odata_type  = optional(string, "#microsoft.graph.identity")
        displayName = optional(string)
        id          = optional(string)
      }))
    })))
    serviceProvisioningErrors = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.serviceProvisioningError")
      createdDateTime = optional(string)
      isResolved      = optional(bool)
      serviceInstance = optional(string)
    })))
    settings          = optional(any)
    showInAddressList = optional(bool)
    skills            = optional(list(string))
    sponsors = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    state         = optional(string)
    streetAddress = optional(string)
    surname       = optional(string)
    todo          = optional(any)
    transitiveMemberOf = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    usageLocation     = optional(string)
    userPrincipalName = optional(string)
    userType          = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activationLockBypassCode", "androidSecurityPatchLevel", "azureADDeviceId", "azureADRegistered", "complianceGracePeriodExpirationDateTime", "configurationManagerClientEnabledFeatures", "deviceActionResults", "deviceCategoryDisplayName", "deviceHealthAttestationState", "deviceName", "easActivated", "easActivationDateTime", "easDeviceId", "emailAddress", "enrolledDateTime", "enrollmentProfileName", "ethernetMacAddress", "exchangeLastSuccessfulSyncDateTime", "freeStorageSpaceInBytes", "iccid", "id", "imei", "isEncrypted", "isSupervised", "jailBroken", "lastSyncDateTime", "managementCertificateExpirationDate", "manufacturer", "meid", "model", "operatingSystem", "osVersion", "phoneNumber", "physicalMemoryInBytes", "remoteAssistanceSessionErrorDetails", "remoteAssistanceSessionUrl", "requireUserEnrollmentApproval", "serialNumber", "subscriberCarrier", "totalStorageSpaceInBytes", "udid", "userDisplayName", "userId", "userPrincipalName", "wiFiMacAddress", "windowsProtectionState"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
