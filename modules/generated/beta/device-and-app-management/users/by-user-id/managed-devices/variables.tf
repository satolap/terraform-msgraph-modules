variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "assignment_filter_evaluation_status_details" {
  description = "Managed device mobile app configuration states for this device."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.assignmentFilterEvaluationStatusDetails")
    payloadId  = optional(string)
  }))
  default = null
}

variable "chassis_type" {
  description = "Chassis type."
  type        = string
  default     = null

  validation {
    condition     = var.chassis_type == null ? true : contains(["unknown", "desktop", "laptop", "worksWorkstation", "enterpriseServer", "phone", "tablet", "mobileOther", "mobileUnknown"], var.chassis_type)
    error_message = "chassis_type must be one of the documented enum values."
  }
}

variable "chrome_os_device_info" {
  description = "List of properties of the ChromeOS Device. Default is an empty list. To retrieve actual values GET call needs to be made, with device id and included in select parameter."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.chromeOSDeviceProperty")
    name       = optional(string)
    updatable  = optional(bool)
    value      = optional(string)
    valueType  = optional(string)
  }))
  default = null
}

variable "cloud_pc_remote_action_results" {
  description = "Microsoft Graph cloudPcRemoteActionResults property."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.cloudPcRemoteActionResult")
    actionName          = optional(string)
    lastUpdatedDateTime = optional(string)
    startDateTime       = optional(string)
    statusDetail        = optional(any)
    statusDetails       = optional(any)
  }))
  default = null
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

variable "configuration_manager_client_health_state" {
  description = "Configuration manager client health state, valid only for devices managed by MDM/ConfigMgr Agent"
  type        = any
  default     = null
}

variable "configuration_manager_client_information" {
  description = "Configuration manager client information, valid only for devices managed, duel-managed or tri-managed by ConfigMgr Agent"
  type        = any
  default     = null
}

variable "detected_apps" {
  description = "All applications currently installed on the device"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.detectedApp")
    deviceCount = optional(number)
    managedDevices = optional(list(object({
      odata_type                                  = optional(string, "#microsoft.graph.managedDevice")
      assignmentFilterEvaluationStatusDetails     = optional(any)
      chassisType                                 = optional(string)
      chromeOSDeviceInfo                          = optional(any)
      cloudPcRemoteActionResults                  = optional(any)
      complianceState                             = optional(string)
      configurationManagerClientHealthState       = optional(any)
      configurationManagerClientInformation       = optional(any)
      detectedApps                                = optional(any)
      deviceCategory                              = optional(any)
      deviceCompliancePolicyStates                = optional(any)
      deviceConfigurationStates                   = optional(any)
      deviceEnrollmentType                        = optional(string)
      deviceFirmwareConfigurationInterfaceManaged = optional(bool)
      deviceRegistrationState                     = optional(string)
      deviceType                                  = optional(string)
      exchangeAccessState                         = optional(string)
      exchangeAccessStateReason                   = optional(string)
      joinType                                    = optional(string)
      logCollectionRequests                       = optional(any)
      lostModeState                               = optional(string)
      managedDeviceMobileAppConfigurationStates   = optional(any)
      managedDeviceName                           = optional(string)
      managedDeviceOwnerType                      = optional(string)
      managementAgent                             = optional(string)
      managementFeatures                          = optional(string)
      managementState                             = optional(string)
      notes                                       = optional(string)
      ownerType                                   = optional(string)
      partnerReportedThreatState                  = optional(string)
      processorArchitecture                       = optional(string)
      roleScopeTagIds                             = optional(list(string))
      securityBaselineStates                      = optional(any)
      skuFamily                                   = optional(string)
      users                                       = optional(any)
    })))
    platform  = optional(string)
    publisher = optional(string)
  }))
  default = null
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
      settingInstanceId   = optional(string)
      settingName         = optional(string)
      sources             = optional(any)
      state               = optional(string)
      userEmail           = optional(string)
      userId              = optional(string)
      userName            = optional(string)
      userPrincipalName   = optional(string)
    })))
    state             = optional(string)
    userId            = optional(string)
    userPrincipalName = optional(string)
    version           = optional(number)
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
      settingInstanceId   = optional(string)
      settingName         = optional(string)
      sources             = optional(any)
      state               = optional(string)
      userEmail           = optional(string)
      userId              = optional(string)
      userName            = optional(string)
      userPrincipalName   = optional(string)
    })))
    state             = optional(string)
    userId            = optional(string)
    userPrincipalName = optional(string)
    version           = optional(number)
  }))
  default = null
}

variable "device_enrollment_type" {
  description = "Possible ways of adding a mobile device to management."
  type        = string
  default     = null

  validation {
    condition     = var.device_enrollment_type == null ? true : contains(["unknown", "userEnrollment", "deviceEnrollmentManager", "appleBulkWithUser", "appleBulkWithoutUser", "windowsAzureADJoin", "windowsBulkUserless", "windowsAutoEnrollment", "windowsBulkAzureDomainJoin", "windowsCoManagement", "windowsAzureADJoinUsingDeviceAuth", "appleUserEnrollment", "appleUserEnrollmentWithServiceAccount", "azureAdJoinUsingAzureVmExtension", "androidEnterpriseDedicatedDevice", "androidEnterpriseFullyManaged", "androidEnterpriseCorporateWorkProfile", "androidAOSPUserOwnedDeviceEnrollment", "androidAOSPUserlessDeviceEnrollment", "appleAccountDrivenUserEnrollment", "unknownFutureValue"], var.device_enrollment_type)
    error_message = "device_enrollment_type must be one of the documented enum values."
  }
}

variable "device_firmware_configuration_interface_managed" {
  description = "Indicates whether the device is DFCI managed. When TRUE the device is DFCI managed. When FALSE, the device is not DFCI managed. The default value is FALSE."
  type        = bool
  default     = null
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

variable "device_type" {
  description = "Device type."
  type        = string
  default     = null

  validation {
    condition     = var.device_type == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "windows10x", "androidnGMS", "chromeOS", "linux", "visionOS", "tvOS", "blackberry", "palm", "unknown", "cloudPC"], var.device_type)
    error_message = "device_type must be one of the documented enum values."
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

variable "join_type" {
  description = "Device enrollment join type."
  type        = string
  default     = null

  validation {
    condition     = var.join_type == null ? true : contains(["unknown", "azureADJoined", "azureADRegistered", "hybridAzureADJoined"], var.join_type)
    error_message = "join_type must be one of the documented enum values."
  }
}

variable "log_collection_requests" {
  description = "List of log collection requests"
  type = list(object({
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
  }))
  default = null
}

variable "lost_mode_state" {
  description = "State of lost mode, indicating if lost mode is enabled or disabled"
  type        = string
  default     = null

  validation {
    condition     = var.lost_mode_state == null ? true : contains(["disabled", "enabled"], var.lost_mode_state)
    error_message = "lost_mode_state must be one of the documented enum values."
  }
}

variable "managed_device_mobile_app_configuration_states" {
  description = "Managed device mobile app configuration states for this device."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationState")
    displayName  = optional(string)
    platformType = optional(string)
    settingCount = optional(number)
    settingStates = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationSettingState")
      currentValue        = optional(string)
      errorCode           = optional(number)
      errorDescription    = optional(string)
      instanceDisplayName = optional(string)
      setting             = optional(string)
      settingInstanceId   = optional(string)
      settingName         = optional(string)
      sources             = optional(any)
      state               = optional(string)
      userEmail           = optional(string)
      userId              = optional(string)
      userName            = optional(string)
      userPrincipalName   = optional(string)
    })))
    state             = optional(string)
    userId            = optional(string)
    userPrincipalName = optional(string)
    version           = optional(number)
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
  description = "Management agent type."
  type        = string
  default     = null

  validation {
    condition     = var.management_agent == null ? true : contains(["eas", "mdm", "easMdm", "intuneClient", "easIntuneClient", "configurationManagerClient", "configurationManagerClientMdm", "configurationManagerClientMdmEas", "unknown", "jamf", "googleCloudDevicePolicyController", "microsoft365ManagedMdm", "msSense", "intuneAosp", "google", "unknownFutureValue"], var.management_agent)
    error_message = "management_agent must be one of the documented enum values."
  }
}

variable "management_features" {
  description = "Device management features."
  type        = string
  default     = null

  validation {
    condition     = var.management_features == null ? true : contains(["none", "microsoftManagedDesktop"], var.management_features)
    error_message = "management_features must be one of the documented enum values."
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

variable "owner_type" {
  description = "Owner type of device."
  type        = string
  default     = null

  validation {
    condition     = var.owner_type == null ? true : contains(["unknown", "company", "personal"], var.owner_type)
    error_message = "owner_type must be one of the documented enum values."
  }
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

variable "processor_architecture" {
  description = "Processor architecture"
  type        = string
  default     = null

  validation {
    condition     = var.processor_architecture == null ? true : contains(["unknown", "x86", "x64", "arm", "arM64"], var.processor_architecture)
    error_message = "processor_architecture must be one of the documented enum values."
  }
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tag IDs for this Device instance."
  type        = list(string)
  default     = null
}

variable "security_baseline_states" {
  description = "Security baseline states for this device."
  type = list(object({
    odata_type                 = optional(string, "#microsoft.graph.securityBaselineState")
    displayName                = optional(string)
    securityBaselineTemplateId = optional(string)
    settingStates = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.securityBaselineSettingState")
      contributingPolicies = optional(any)
      errorCode            = optional(string)
      settingCategoryId    = optional(string)
      settingCategoryName  = optional(string)
      settingId            = optional(string)
      settingName          = optional(string)
      sourcePolicies       = optional(any)
      state                = optional(string)
    })))
    state             = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "sku_family" {
  description = "Device sku family"
  type        = string
  default     = null
}

variable "users" {
  description = "The primary users associated with the managed device."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.user")
    aboutMe        = optional(string)
    accountEnabled = optional(bool)
    ageGroup       = optional(string)
    analytics      = optional(any)
    appConsentRequestsForApproval = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appConsentRequest")
      appDisplayName      = optional(string)
      appId               = optional(string)
      consentType         = optional(string)
      pendingScopes       = optional(any)
      userConsentRequests = optional(any)
    })))
    appRoleAssignedResources = optional(list(object({
      odata_type                          = optional(string, "#microsoft.graph.servicePrincipal")
      accountEnabled                      = optional(bool)
      addIns                              = optional(any)
      alternativeNames                    = optional(list(string))
      appDescription                      = optional(string)
      appDisplayName                      = optional(string)
      appId                               = optional(string)
      appManagementPolicies               = optional(any)
      appOwnerOrganizationId              = optional(string)
      appRoleAssignedTo                   = optional(any)
      appRoleAssignmentRequired           = optional(bool)
      appRoleAssignments                  = optional(any)
      appRoles                            = optional(any)
      claimsMappingPolicies               = optional(any)
      claimsPolicy                        = optional(any)
      customSecurityAttributes            = optional(any)
      delegatedPermissionClassifications  = optional(any)
      deletedDateTime                     = optional(string)
      description                         = optional(string)
      disabledByMicrosoftStatus           = optional(string)
      displayName                         = optional(string)
      endpoints                           = optional(any)
      errorUrl                            = optional(string)
      federatedIdentityCredentials        = optional(any)
      homeRealmDiscoveryPolicies          = optional(any)
      homepage                            = optional(string)
      info                                = optional(any)
      isDisabled                          = optional(bool)
      keyCredentials                      = optional(any)
      licenseDetails                      = optional(any)
      loginUrl                            = optional(string)
      logoutUrl                           = optional(string)
      notes                               = optional(string)
      notificationEmailAddresses          = optional(list(string))
      owners                              = optional(any)
      passwordCredentials                 = optional(any)
      permissionGrantPreApprovalPolicies  = optional(any)
      preferredSingleSignOnMode           = optional(string)
      preferredTokenSigningKeyEndDateTime = optional(string)
      preferredTokenSigningKeyThumbprint  = optional(string)
      publishedPermissionScopes           = optional(any)
      publisherName                       = optional(string)
      remoteDesktopSecurityConfiguration  = optional(any)
      replyUrls                           = optional(list(string))
      samlMetadataUrl                     = optional(string)
      samlSingleSignOnSettings            = optional(any)
      servicePrincipalNames               = optional(list(string))
      servicePrincipalType                = optional(string)
      synchronization                     = optional(any)
      tags                                = optional(list(string))
      tokenEncryptionKeyId                = optional(string)
      tokenIssuancePolicies               = optional(any)
      tokenLifetimePolicies               = optional(any)
      transitiveMemberOf                  = optional(any)
      verifiedPublisher                   = optional(any)
    })))
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    approvals = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.approval")
      steps      = optional(any)
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
      operations              = optional(any)
      originalCreatedDateTime = optional(string)
      permissionGrants        = optional(any)
      pinnedMessages          = optional(any)
      tabs                    = optional(any)
      targetedMessages        = optional(any)
      topic                   = optional(string)
      viewpoint               = optional(any)
    })))
    city                           = optional(string)
    cloudClipboard                 = optional(any)
    cloudLicensing                 = optional(any)
    cloudRealtimeCommunicationInfo = optional(any)
    communications                 = optional(any)
    companyName                    = optional(string)
    consentProvidedForMinor        = optional(string)
    country                        = optional(string)
    customSecurityAttributes       = optional(any)
    deletedDateTime                = optional(string)
    department                     = optional(string)
    deviceEnrollmentConfigurations = optional(list(object({
      odata_type                        = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")
      assignments                       = optional(any)
      createdDateTime                   = optional(string)
      description                       = optional(string)
      deviceEnrollmentConfigurationType = optional(string)
      displayName                       = optional(string)
      lastModifiedDateTime              = optional(string)
      priority                          = optional(number)
      roleScopeTagIds                   = optional(list(string))
      version                           = optional(number)
    })))
    deviceEnrollmentLimit = optional(number)
    deviceKeys = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.deviceKey")
      deviceId    = optional(string)
      keyMaterial = optional(string)
      keyType     = optional(string)
    })))
    deviceManagementTroubleshootingEvents = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")
      additionalInformation       = optional(any)
      correlationId               = optional(string)
      eventDateTime               = optional(string)
      eventName                   = optional(string)
      troubleshootingErrorDetails = optional(any)
    })))
    devices = optional(list(object({
      odata_type             = optional(string, "#microsoft.graph.device")
      accountEnabled         = optional(bool)
      alternativeNames       = optional(list(string))
      alternativeSecurityIds = optional(any)
      commands               = optional(any)
      deletedDateTime        = optional(string)
      deviceCategory         = optional(string)
      deviceId               = optional(string)
      deviceMetadata         = optional(string)
      deviceOwnership        = optional(string)
      deviceVersion          = optional(number)
      displayName            = optional(string)
      domainName             = optional(string)
      enrollmentProfileName  = optional(string)
      enrollmentType         = optional(string)
      extensionAttributes    = optional(any)
      hostnames              = optional(list(string))
      isManaged              = optional(bool)
      isRooted               = optional(bool)
      kind                   = optional(string)
      managementType         = optional(string)
      name                   = optional(string)
      operatingSystem        = optional(string)
      operatingSystemVersion = optional(string)
      physicalIds            = optional(list(string))
      platform               = optional(string)
      profileType            = optional(string)
      status                 = optional(string)
      systemLabels           = optional(list(string))
      transitiveMemberOf     = optional(any)
      usageRights            = optional(any)
    })))
    displayName           = optional(string)
    employeeHireDate      = optional(string)
    employeeId            = optional(string)
    employeeLeaveDateTime = optional(string)
    employeeOrgData       = optional(any)
    employeeType          = optional(string)
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type             = optional(string, "#microsoft.graph.site")
      analytics              = optional(any)
      columns                = optional(any)
      contentModels          = optional(any)
      contentTypes           = optional(any)
      createdByUser          = optional(any)
      deleted                = optional(any)
      description            = optional(string)
      documentProcessingJobs = optional(any)
      drive                  = optional(any)
      drives                 = optional(any)
      extensions             = optional(any)
      externalColumns        = optional(any)
      informationProtection  = optional(any)
      isPersonalSite         = optional(bool)
      items                  = optional(any)
      lastModifiedByUser     = optional(any)
      lists                  = optional(any)
      locale                 = optional(string)
      lockState              = optional(any)
      name                   = optional(string)
      onenote                = optional(any)
      operations             = optional(any)
      ownerIdentityToResolve = optional(any)
      pageTemplates          = optional(any)
      pages                  = optional(any)
      parentReference        = optional(any)
      permissions            = optional(any)
      recycleBin             = optional(any)
      shareByEmailEnabled    = optional(bool)
      sites                  = optional(any)
      template               = optional(any)
      termStore              = optional(any)
    })))
    givenName = optional(string)
    hireDate  = optional(string)
    identities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.objectIdentity")
      issuer           = optional(string)
      issuerAssignedId = optional(string)
      signInType       = optional(string)
    })))
    identityGovernance      = optional(any)
    identityParentId        = optional(string)
    inferenceClassification = optional(any)
    infoCatalogs            = optional(list(string))
    informationProtection   = optional(any)
    interests               = optional(list(string))
    invitedBy               = optional(any)
    isResourceAccount       = optional(bool)
    jobTitle                = optional(string)
    joinedGroups = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.group")
      acceptedSenders               = optional(any)
      accessType                    = optional(any)
      allowExternalSenders          = optional(bool)
      appRoleAssignments            = optional(any)
      assignedLabels                = optional(any)
      autoSubscribeNewMembers       = optional(bool)
      classification                = optional(string)
      cloudLicensing                = optional(any)
      conversations                 = optional(any)
      deletedDateTime               = optional(string)
      description                   = optional(string)
      displayName                   = optional(string)
      events                        = optional(any)
      groupTypes                    = optional(list(string))
      hasMembersWithLicenseErrors   = optional(bool)
      hideFromAddressLists          = optional(bool)
      hideFromOutlookClients        = optional(bool)
      infoCatalogs                  = optional(list(string))
      isAssignableToRole            = optional(bool)
      isFavorite                    = optional(bool)
      isSubscribedByMail            = optional(bool)
      mailEnabled                   = optional(bool)
      mailNickname                  = optional(string)
      members                       = optional(any)
      membershipRule                = optional(string)
      membershipRuleProcessingState = optional(string)
      onPremisesExtensionAttributes = optional(any)
      onPremisesProvisioningErrors  = optional(any)
      onPremisesSyncBehavior        = optional(any)
      onenote                       = optional(any)
      organizationId                = optional(string)
      owners                        = optional(any)
      permissionGrants              = optional(any)
      photo                         = optional(any)
      preferredDataLocation         = optional(string)
      preferredLanguage             = optional(string)
      rejectedSenders               = optional(any)
      resourceBehaviorOptions       = optional(list(string))
      resourceProvisioningOptions   = optional(list(string))
      securityEnabled               = optional(bool)
      serviceProvisioningErrors     = optional(any)
      settings                      = optional(any)
      sites                         = optional(any)
      team                          = optional(any)
      theme                         = optional(string)
      threads                       = optional(any)
      transitiveMemberOf            = optional(any)
      transitiveMembers             = optional(any)
      unseenConversationsCount      = optional(number)
      unseenCount                   = optional(number)
      unseenMessagesCount           = optional(number)
      visibility                    = optional(string)
      welcomeMessageEnabled         = optional(bool)
      writebackConfiguration        = optional(any)
    })))
    licenseDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.licenseDetails")
    })))
    mail            = optional(string)
    mailNickname    = optional(string)
    mailboxSettings = optional(any)
    managedAppLogCollectionRequests = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")
      userLogUploadConsent = optional(string)
      version              = optional(string)
    })))
    managedAppRegistrations = optional(list(object({
      odata_type                      = optional(string, "#microsoft.graph.managedAppRegistration")
      appIdentifier                   = optional(any)
      applicationVersion              = optional(string)
      appliedPolicies                 = optional(any)
      azureADDeviceId                 = optional(string)
      createdDateTime                 = optional(string)
      deviceManufacturer              = optional(string)
      deviceModel                     = optional(string)
      deviceName                      = optional(string)
      deviceTag                       = optional(string)
      deviceType                      = optional(string)
      flaggedReasons                  = optional(list(string))
      intendedPolicies                = optional(any)
      lastSyncDateTime                = optional(string)
      managedAppLogCollectionRequests = optional(any)
      managedDeviceId                 = optional(string)
      managementSdkVersion            = optional(string)
      operations                      = optional(any)
      platformVersion                 = optional(string)
      userId                          = optional(string)
      version                         = optional(string)
    })))
    managedDevices = optional(list(object({
      odata_type                                  = optional(string, "#microsoft.graph.managedDevice")
      assignmentFilterEvaluationStatusDetails     = optional(any)
      chassisType                                 = optional(string)
      chromeOSDeviceInfo                          = optional(any)
      cloudPcRemoteActionResults                  = optional(any)
      complianceState                             = optional(string)
      configurationManagerClientHealthState       = optional(any)
      configurationManagerClientInformation       = optional(any)
      detectedApps                                = optional(any)
      deviceCategory                              = optional(any)
      deviceCompliancePolicyStates                = optional(any)
      deviceConfigurationStates                   = optional(any)
      deviceEnrollmentType                        = optional(string)
      deviceFirmwareConfigurationInterfaceManaged = optional(bool)
      deviceRegistrationState                     = optional(string)
      deviceType                                  = optional(string)
      exchangeAccessState                         = optional(string)
      exchangeAccessStateReason                   = optional(string)
      joinType                                    = optional(string)
      logCollectionRequests                       = optional(any)
      lostModeState                               = optional(string)
      managedDeviceMobileAppConfigurationStates   = optional(any)
      managedDeviceName                           = optional(string)
      managedDeviceOwnerType                      = optional(string)
      managementAgent                             = optional(string)
      managementFeatures                          = optional(string)
      managementState                             = optional(string)
      notes                                       = optional(string)
      ownerType                                   = optional(string)
      partnerReportedThreatState                  = optional(string)
      processorArchitecture                       = optional(string)
      roleScopeTagIds                             = optional(list(string))
      securityBaselineStates                      = optional(any)
      skuFamily                                   = optional(string)
      users                                       = optional(any)
    })))
    mobileAppIntentAndStates = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.mobileAppIntentAndState")
      managedDeviceIdentifier = optional(string)
      mobileAppList           = optional(any)
      userId                  = optional(string)
    })))
    mobileAppTroubleshootingEvents = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")
      additionalInformation       = optional(any)
      appLogCollectionRequests    = optional(any)
      applicationId               = optional(string)
      correlationId               = optional(string)
      deviceId                    = optional(string)
      eventDateTime               = optional(string)
      eventName                   = optional(string)
      history                     = optional(any)
      managedDeviceIdentifier     = optional(string)
      troubleshootingErrorDetails = optional(any)
      userId                      = optional(string)
    })))
    mySite = optional(string)
    notifications = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.notification")
      displayTimeToLive  = optional(number)
      expirationDateTime = optional(string)
      groupName          = optional(string)
      payload = optional(object({
        odata_type    = optional(string, "#microsoft.graph.payloadTypes")
        rawContent    = optional(string)
        visualContent = optional(any)
      }))
      priority       = optional(any)
      targetHostName = optional(string)
      targetPolicy   = optional(any)
    })))
    oauth2PermissionGrants = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.oAuth2PermissionGrant")
      clientId    = optional(string)
      consentType = optional(string)
      expiryTime  = optional(string)
      principalId = optional(string)
      resourceId  = optional(string)
      scope       = optional(string)
      startTime   = optional(string)
    })))
    officeLocation              = optional(string)
    onPremisesDistinguishedName = optional(string)
    onPremisesDomainName        = optional(string)
    onPremisesImmutableId       = optional(string)
    onPremisesProvisioningErrors = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
      category             = optional(string)
      occurredDateTime     = optional(string)
      propertyCausingError = optional(string)
      value                = optional(string)
    })))
    onPremisesSamAccountName     = optional(string)
    onPremisesSecurityIdentifier = optional(string)
    onPremisesSyncBehavior       = optional(any)
    onPremisesUserPrincipalName  = optional(string)
    onenote                      = optional(any)
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
      anonymizeIdentityForRoles            = optional(any)
      broadcastRecording                   = optional(string)
      broadcastSettings                    = optional(any)
      capabilities                         = optional(any)
      chatInfo                             = optional(any)
      chatRestrictions                     = optional(any)
      endDateTime                          = optional(string)
      expiryDateTime                       = optional(string)
      externalId                           = optional(string)
      isBroadcast                          = optional(bool)
      isEndToEndEncryptionEnabled          = optional(bool)
      isEntryExitAnnounced                 = optional(bool)
      joinMeetingIdSettings                = optional(any)
      joinUrl                              = optional(string)
      lobbyBypassSettings                  = optional(any)
      meetingOptionsWebUrl                 = optional(string)
      meetingSpokenLanguageTag             = optional(string)
      meetingTemplateId                    = optional(string)
      participants                         = optional(any)
      recordAutomatically                  = optional(bool)
      registration                         = optional(any)
      sensitivityLabelAssignment           = optional(any)
      shareMeetingChatHistoryDefault       = optional(any)
      startDateTime                        = optional(string)
      subject                              = optional(string)
      watermarkProtection                  = optional(any)
    })))
    otherMails       = optional(list(string))
    passwordPolicies = optional(string)
    passwordProfile  = optional(any)
    pastProjects     = optional(list(string))
    pendingAccessReviewInstances = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.accessReviewInstance")
      decisions         = optional(any)
      definition        = optional(any)
      fallbackReviewers = optional(any)
      reviewers         = optional(any)
      stages            = optional(any)
    })))
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
    profile               = optional(any)
    responsibilities      = optional(list(string))
    schools               = optional(list(string))
    security              = optional(any)
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
    usageLocation = optional(string)
    usageRights = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.usageRight")
      catalogId         = optional(string)
      serviceIdentifier = optional(string)
      state             = optional(string)
    })))
    userPrincipalName = optional(string)
    userType          = optional(string)
    virtualEvents     = optional(any)
    windowsInformationProtectionDeviceRegistrations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")
      deviceMacAddress     = optional(string)
      deviceName           = optional(string)
      deviceRegistrationId = optional(string)
      deviceType           = optional(string)
      lastCheckInDateTime  = optional(string)
      userId               = optional(string)
    })))
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["aadRegistered", "activationLockBypassCode", "androidSecurityPatchLevel", "autopilotEnrolled", "azureADDeviceId", "azureADRegistered", "azureActiveDirectoryDeviceId", "bootstrapTokenEscrowed", "complianceGracePeriodExpirationDateTime", "configurationManagerClientEnabledFeatures", "deviceActionResults", "deviceCategoryDisplayName", "deviceHealthAttestationState", "deviceHealthScriptStates", "deviceName", "easActivated", "easActivationDateTime", "easDeviceId", "emailAddress", "enrolledByUserPrincipalName", "enrolledDateTime", "enrollmentProfileName", "ethernetMacAddress", "exchangeLastSuccessfulSyncDateTime", "freeStorageSpaceInBytes", "hardwareInformation", "iccid", "id", "imei", "isEncrypted", "isSupervised", "jailBroken", "lastSyncDateTime", "managementCertificateExpirationDate", "manufacturer", "meid", "model", "operatingSystem", "osVersion", "phoneNumber", "physicalMemoryInBytes", "preferMdmOverGroupPolicyAppliedDateTime", "remoteAssistanceSessionErrorDetails", "remoteAssistanceSessionUrl", "requireUserEnrollmentApproval", "retireAfterDateTime", "securityPatchLevel", "serialNumber", "skuNumber", "specificationVersion", "subscriberCarrier", "totalStorageSpaceInBytes", "udid", "userDisplayName", "userId", "userPrincipalName", "usersLoggedOn", "wiFiMacAddress", "windowsActiveMalwareCount", "windowsProtectionState", "windowsRemediatedMalwareCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
