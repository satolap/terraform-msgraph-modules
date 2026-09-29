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
    statusDetail = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudPcStatusDetail")
      additionalInformation = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.keyValuePair")
        name       = optional(string)
        value      = optional(string)
      })))
      code    = optional(string)
      message = optional(string)
    }))
    statusDetails = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudPcStatusDetails")
      additionalInformation = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.keyValuePair")
        name       = optional(string)
        value      = optional(string)
      })))
      code    = optional(string)
      message = optional(string)
    }))
  }))
  default = null
}

variable "configuration_manager_client_health_state" {
  description = "Configuration manager client health state, valid only for devices managed by MDM/ConfigMgr Agent"
  type = object({
    odata_type       = optional(string, "#microsoft.graph.configurationManagerClientHealthState")
    errorCode        = optional(number)
    lastSyncDateTime = optional(string)
    state            = optional(string)
  })
  default = null
}

variable "configuration_manager_client_information" {
  description = "Configuration manager client information, valid only for devices managed, duel-managed or tri-managed by ConfigMgr Agent"
  type = object({
    odata_type       = optional(string, "#microsoft.graph.configurationManagerClientInformation")
    clientIdentifier = optional(string)
    clientVersion    = optional(string)
    isBlocked        = optional(bool)
  })
  default = null
}

variable "detected_apps" {
  description = "All applications currently installed on the device"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.detectedApp")
    deviceCount = optional(number)
    managedDevices = optional(list(object({
      odata_type                              = optional(string, "#microsoft.graph.managedDevice")
      assignmentFilterEvaluationStatusDetails = optional(any)
      chromeOSDeviceInfo                      = optional(any)
      cloudPcRemoteActionResults              = optional(any)
      configurationManagerClientHealthState = optional(object({
        odata_type       = optional(string, "#microsoft.graph.configurationManagerClientHealthState")
        errorCode        = optional(number)
        lastSyncDateTime = optional(string)
        state            = optional(string)
      }))
      configurationManagerClientInformation = optional(object({
        odata_type       = optional(string, "#microsoft.graph.configurationManagerClientInformation")
        clientIdentifier = optional(string)
        clientVersion    = optional(string)
        isBlocked        = optional(bool)
      }))
      detectedApps                                = optional(any)
      deviceCategory                              = optional(any)
      deviceCompliancePolicyStates                = optional(any)
      deviceConfigurationStates                   = optional(any)
      deviceFirmwareConfigurationInterfaceManaged = optional(bool)
      joinType                                    = optional(string)
      logCollectionRequests                       = optional(any)
      managedDeviceMobileAppConfigurationStates   = optional(any)
      managedDeviceName                           = optional(string)
      managedDeviceOwnerType                      = optional(string)
      managementFeatures                          = optional(string)
      notes                                       = optional(string)
      ownerType                                   = optional(string)
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

variable "device_firmware_configuration_interface_managed" {
  description = "Indicates whether the device is DFCI managed. When TRUE the device is DFCI managed. When FALSE, the device is not DFCI managed. The default value is FALSE."
  type        = bool
  default     = null
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

variable "management_features" {
  description = "Device management features."
  type        = string
  default     = null

  validation {
    condition     = var.management_features == null ? true : contains(["none", "microsoftManagedDesktop"], var.management_features)
    error_message = "management_features must be one of the documented enum values."
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
    appRoleAssignedResources = optional(any)
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
    authentication = optional(any)
    authorizationInfo = optional(object({
      odata_type         = optional(string, "#microsoft.graph.authorizationInfo")
      certificateUserIds = optional(list(string))
    }))
    birthday = optional(string)
    chats = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.chat")
      chatType                = optional(string)
      installedApps           = optional(any)
      lastMessagePreview      = optional(any)
      members                 = optional(any)
      messages                = optional(any)
      migrationMode           = optional(string)
      operations              = optional(any)
      originalCreatedDateTime = optional(string)
      permissionGrants        = optional(any)
      pinnedMessages          = optional(any)
      tabs                    = optional(any)
      targetedMessages        = optional(any)
      topic                   = optional(string)
      viewpoint = optional(object({
        odata_type              = optional(string, "#microsoft.graph.chatViewpoint")
        isHidden                = optional(bool)
        lastMessageReadDateTime = optional(string)
      }))
    })))
    city           = optional(string)
    cloudClipboard = optional(any)
    cloudLicensing = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.userCloudLicensing")
      assignmentErrors = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.cloudLicensing.assignmentError")
        assignedTo         = optional(any)
        code               = optional(string)
        message            = optional(string)
        occurrenceDateTime = optional(string)
      })))
      assignments = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.cloudLicensing.assignment")
        allotment              = optional(any)
        assignedTo             = optional(any)
        disabledServicePlanIds = optional(any)
      })))
      usageRights = optional(list(object({
        odata_type                = optional(string, "#microsoft.graph.cloudLicensing.usageRight")
        allotments                = optional(any)
        assignments               = optional(any)
        externalServiceIdentifier = optional(string)
      })))
      waitingMembers = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.cloudLicensing.waitingMember")
        allotment            = optional(any)
        assignedTo           = optional(any)
        waitingSinceDateTime = optional(string)
      })))
    }))
    cloudRealtimeCommunicationInfo = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")
    }))
    communications                 = optional(any)
    companyName                    = optional(string)
    consentProvidedForMinor        = optional(string)
    country                        = optional(string)
    customSecurityAttributes       = optional(any)
    deletedDateTime                = optional(string)
    department                     = optional(string)
    deviceEnrollmentConfigurations = optional(any)
    deviceEnrollmentLimit          = optional(number)
    deviceKeys = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.deviceKey")
      deviceId    = optional(string)
      keyMaterial = optional(string)
      keyType     = optional(string)
    })))
    deviceManagementTroubleshootingEvents = optional(any)
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
      extensionAttributes = optional(object({
        odata_type           = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")
        extensionAttribute1  = optional(string)
        extensionAttribute10 = optional(string)
        extensionAttribute11 = optional(string)
        extensionAttribute12 = optional(string)
        extensionAttribute13 = optional(string)
        extensionAttribute14 = optional(string)
        extensionAttribute15 = optional(string)
        extensionAttribute2  = optional(string)
        extensionAttribute3  = optional(string)
        extensionAttribute4  = optional(string)
        extensionAttribute5  = optional(string)
        extensionAttribute6  = optional(string)
        extensionAttribute7  = optional(string)
        extensionAttribute8  = optional(string)
        extensionAttribute9  = optional(string)
      }))
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
    employeeOrgData = optional(object({
      odata_type = optional(string, "#microsoft.graph.employeeOrgData")
      costCenter = optional(string)
      division   = optional(string)
    }))
    employeeType                    = optional(string)
    extensions                      = optional(any)
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.site")
      analytics     = optional(any)
      columns       = optional(any)
      contentModels = optional(any)
      contentTypes  = optional(any)
      createdByUser = optional(any)
      deleted = optional(object({
        odata_type = optional(string, "#microsoft.graph.deleted")
        state      = optional(string)
      }))
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
      lockState              = optional(string)
      name                   = optional(string)
      onenote                = optional(any)
      operations             = optional(any)
      ownerIdentityToResolve = optional(object({
        odata_type = optional(string, "#microsoft.graph.identityInput")
        alias      = optional(string)
        email      = optional(string)
        objectId   = optional(string)
      }))
      pageTemplates = optional(any)
      pages         = optional(any)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      permissions         = optional(any)
      recycleBin          = optional(any)
      shareByEmailEnabled = optional(bool)
      sites               = optional(any)
      template            = optional(string)
      termStore           = optional(any)
    })))
    givenName = optional(string)
    hireDate  = optional(string)
    identities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.objectIdentity")
      issuer           = optional(string)
      issuerAssignedId = optional(string)
      signInType       = optional(string)
    })))
    identityGovernance = optional(object({
      odata_type = optional(string, "#microsoft.graph.identityGovernanceUserSettings")
      approverDelegate = optional(object({
        odata_type = optional(string, "#microsoft.graph.approverDelegate")
        delegate   = optional(any)
        schedule = optional(object({
          odata_type    = optional(string, "#microsoft.graph.requestSchedule")
          expiration    = optional(any)
          recurrence    = optional(any)
          startDateTime = optional(string)
        }))
      }))
    }))
    identityParentId        = optional(string)
    inferenceClassification = optional(any)
    infoCatalogs            = optional(list(string))
    informationProtection   = optional(any)
    interests               = optional(list(string))
    invitedBy               = optional(any)
    isResourceAccount       = optional(bool)
    jobTitle                = optional(string)
    joinedGroups = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.group")
      acceptedSenders         = optional(any)
      accessType              = optional(string)
      allowExternalSenders    = optional(bool)
      appRoleAssignments      = optional(any)
      assignedLabels          = optional(any)
      autoSubscribeNewMembers = optional(bool)
      classification          = optional(string)
      cloudLicensing = optional(object({
        odata_type  = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")
        assignments = optional(any)
        usageRights = optional(any)
      }))
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
      onPremisesExtensionAttributes = optional(object({
        odata_type           = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")
        extensionAttribute1  = optional(string)
        extensionAttribute10 = optional(string)
        extensionAttribute11 = optional(string)
        extensionAttribute12 = optional(string)
        extensionAttribute13 = optional(string)
        extensionAttribute14 = optional(string)
        extensionAttribute15 = optional(string)
        extensionAttribute2  = optional(string)
        extensionAttribute3  = optional(string)
        extensionAttribute4  = optional(string)
        extensionAttribute5  = optional(string)
        extensionAttribute6  = optional(string)
        extensionAttribute7  = optional(string)
        extensionAttribute8  = optional(string)
        extensionAttribute9  = optional(string)
      }))
      onPremisesProvisioningErrors = optional(any)
      onPremisesSyncBehavior       = optional(any)
      onenote                      = optional(any)
      organizationId               = optional(string)
      owners                       = optional(any)
      permissionGrants             = optional(any)
      photo                        = optional(any)
      preferredDataLocation        = optional(string)
      preferredLanguage            = optional(string)
      rejectedSenders              = optional(any)
      resourceBehaviorOptions      = optional(list(string))
      resourceProvisioningOptions  = optional(list(string))
      securityEnabled              = optional(bool)
      serviceProvisioningErrors    = optional(any)
      settings                     = optional(any)
      sites                        = optional(any)
      team                         = optional(any)
      theme                        = optional(string)
      threads                      = optional(any)
      transitiveMemberOf           = optional(any)
      transitiveMembers            = optional(any)
      unseenConversationsCount     = optional(number)
      unseenCount                  = optional(number)
      unseenMessagesCount          = optional(number)
      visibility                   = optional(string)
      welcomeMessageEnabled        = optional(bool)
      writebackConfiguration = optional(object({
        odata_type          = optional(string, "#microsoft.graph.groupWritebackConfiguration")
        isEnabled           = optional(bool)
        onPremisesGroupType = optional(string)
      }))
    })))
    licenseDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.licenseDetails")
    })))
    mail         = optional(string)
    mailNickname = optional(string)
    mailboxSettings = optional(object({
      odata_type = optional(string, "#microsoft.graph.mailboxSettings")
      automaticRepliesSetting = optional(object({
        odata_type           = optional(string, "#microsoft.graph.automaticRepliesSetting")
        externalAudience     = optional(string)
        externalReplyMessage = optional(string)
        internalReplyMessage = optional(string)
        scheduledEndDateTime = optional(object({
          odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
          dateTime   = optional(string)
          timeZone   = optional(string)
        }))
        scheduledStartDateTime = optional(object({
          odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
          dateTime   = optional(string)
          timeZone   = optional(string)
        }))
        status = optional(string)
      }))
      dateFormat                            = optional(string)
      delegateMeetingMessageDeliveryOptions = optional(string)
      language = optional(object({
        odata_type  = optional(string, "#microsoft.graph.localeInfo")
        displayName = optional(string)
        locale      = optional(string)
      }))
      timeFormat    = optional(string)
      timeZone      = optional(string)
      userPurposeV2 = optional(string)
      workingHours = optional(object({
        odata_type = optional(string, "#microsoft.graph.workingHours")
        daysOfWeek = optional(list(string))
        endTime    = optional(string)
        startTime  = optional(string)
        timeZone   = optional(any)
      }))
    }))
    managedAppLogCollectionRequests = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")
      userLogUploadConsent = optional(string)
      version              = optional(string)
    })))
    managedAppRegistrations = optional(any)
    managedDevices = optional(list(object({
      odata_type                              = optional(string, "#microsoft.graph.managedDevice")
      assignmentFilterEvaluationStatusDetails = optional(any)
      chromeOSDeviceInfo                      = optional(any)
      cloudPcRemoteActionResults              = optional(any)
      configurationManagerClientHealthState = optional(object({
        odata_type       = optional(string, "#microsoft.graph.configurationManagerClientHealthState")
        errorCode        = optional(number)
        lastSyncDateTime = optional(string)
        state            = optional(string)
      }))
      configurationManagerClientInformation = optional(object({
        odata_type       = optional(string, "#microsoft.graph.configurationManagerClientInformation")
        clientIdentifier = optional(string)
        clientVersion    = optional(string)
        isBlocked        = optional(bool)
      }))
      detectedApps                                = optional(any)
      deviceCategory                              = optional(any)
      deviceCompliancePolicyStates                = optional(any)
      deviceConfigurationStates                   = optional(any)
      deviceFirmwareConfigurationInterfaceManaged = optional(bool)
      joinType                                    = optional(string)
      logCollectionRequests                       = optional(any)
      managedDeviceMobileAppConfigurationStates   = optional(any)
      managedDeviceName                           = optional(string)
      managedDeviceOwnerType                      = optional(string)
      managementFeatures                          = optional(string)
      notes                                       = optional(string)
      ownerType                                   = optional(string)
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
      odata_type               = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")
      additionalInformation    = optional(any)
      appLogCollectionRequests = optional(any)
      applicationId            = optional(string)
      correlationId            = optional(string)
      deviceId                 = optional(string)
      eventDateTime            = optional(string)
      eventName                = optional(string)
      history                  = optional(any)
      managedDeviceIdentifier  = optional(string)
      troubleshootingErrorDetails = optional(object({
        odata_type     = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorDetails")
        context        = optional(string)
        failure        = optional(string)
        failureDetails = optional(string)
        remediation    = optional(string)
        resources      = optional(any)
      }))
      userId = optional(string)
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
      priority       = optional(string)
      targetHostName = optional(string)
      targetPolicy = optional(object({
        odata_type    = optional(string, "#microsoft.graph.targetPolicyEndpoints")
        platformTypes = optional(any)
      }))
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
      allowLiveShare                       = optional(string)
      allowMeetingChat                     = optional(string)
      allowParticipantsToChangeName        = optional(bool)
      allowPowerPointSharing               = optional(bool)
      allowRecording                       = optional(bool)
      allowTeamworkReactions               = optional(bool)
      allowTranscription                   = optional(bool)
      allowWhiteboard                      = optional(bool)
      allowedLobbyAdmitters                = optional(string)
      allowedPresenters                    = optional(string)
      anonymizeIdentityForRoles            = optional(list(string))
      broadcastRecording                   = optional(string)
      broadcastSettings = optional(object({
        odata_type                 = optional(string, "#microsoft.graph.broadcastMeetingSettings")
        allowedAudience            = optional(string)
        captions                   = optional(any)
        isAttendeeReportEnabled    = optional(bool)
        isQuestionAndAnswerEnabled = optional(bool)
        isRecordingEnabled         = optional(bool)
        isVideoOnDemandEnabled     = optional(bool)
      }))
      capabilities = optional(list(string))
      chatInfo = optional(object({
        odata_type          = optional(string, "#microsoft.graph.chatInfo")
        messageId           = optional(string)
        replyChainMessageId = optional(string)
        threadId            = optional(string)
      }))
      chatRestrictions = optional(object({
        odata_type    = optional(string, "#microsoft.graph.chatRestrictions")
        allowTextOnly = optional(bool)
      }))
      endDateTime                 = optional(string)
      expiryDateTime              = optional(string)
      externalId                  = optional(string)
      isBroadcast                 = optional(bool)
      isEndToEndEncryptionEnabled = optional(bool)
      isEntryExitAnnounced        = optional(bool)
      joinMeetingIdSettings = optional(object({
        odata_type         = optional(string, "#microsoft.graph.joinMeetingIdSettings")
        isPasscodeRequired = optional(bool)
      }))
      joinUrl = optional(string)
      lobbyBypassSettings = optional(object({
        odata_type            = optional(string, "#microsoft.graph.lobbyBypassSettings")
        isDialInBypassEnabled = optional(bool)
        scope                 = optional(string)
      }))
      meetingOptionsWebUrl     = optional(string)
      meetingSpokenLanguageTag = optional(string)
      meetingTemplateId        = optional(string)
      participants = optional(object({
        odata_type   = optional(string, "#microsoft.graph.meetingParticipants")
        attendees    = optional(any)
        contributors = optional(any)
        organizer    = optional(any)
        producers    = optional(any)
      }))
      recordAutomatically = optional(bool)
      registration        = optional(any)
      sensitivityLabelAssignment = optional(object({
        odata_type         = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")
        sensitivityLabelId = optional(string)
      }))
      shareMeetingChatHistoryDefault = optional(string)
      startDateTime                  = optional(string)
      subject                        = optional(string)
      watermarkProtection = optional(object({
        odata_type                 = optional(string, "#microsoft.graph.watermarkProtectionValues")
        isEnabledForContentSharing = optional(bool)
        isEnabledForVideo          = optional(bool)
      }))
    })))
    otherMails       = optional(list(string))
    passwordPolicies = optional(string)
    passwordProfile = optional(object({
      odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
      forceChangePasswordNextSignIn        = optional(bool)
      forceChangePasswordNextSignInWithMfa = optional(bool)
      password                             = optional(string)
    }))
    pastProjects = optional(list(string))
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
    print = optional(object({
      odata_type = optional(string, "#microsoft.graph.userPrint")
      recentPrinterShares = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.printerShare")
        allowAllUsers   = optional(bool)
        allowedGroups   = optional(any)
        allowedUsers    = optional(any)
        capabilities    = optional(any)
        defaults        = optional(any)
        displayName     = optional(string)
        isAcceptingJobs = optional(bool)
        jobs            = optional(any)
        location        = optional(any)
        manufacturer    = optional(string)
        model           = optional(string)
        name            = optional(string)
        printer         = optional(any)
        status          = optional(any)
        viewPoint       = optional(any)
      })))
    }))
    profile                   = optional(any)
    responsibilities          = optional(list(string))
    schools                   = optional(list(string))
    security                  = optional(any)
    serviceProvisioningErrors = optional(any)
    settings                  = optional(any)
    showInAddressList         = optional(bool)
    skills                    = optional(list(string))
    sponsors                  = optional(any)
    state                     = optional(string)
    streetAddress             = optional(string)
    surname                   = optional(string)
    todo                      = optional(any)
    transitiveMemberOf        = optional(any)
    usageLocation             = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["aadRegistered", "activationLockBypassCode", "androidSecurityPatchLevel", "autopilotEnrolled", "azureADDeviceId", "azureADRegistered", "azureActiveDirectoryDeviceId", "bootstrapTokenEscrowed", "chassisType", "complianceGracePeriodExpirationDateTime", "complianceState", "configurationManagerClientEnabledFeatures", "deviceActionResults", "deviceCategoryDisplayName", "deviceEnrollmentType", "deviceHealthAttestationState", "deviceHealthScriptStates", "deviceName", "deviceRegistrationState", "deviceType", "easActivated", "easActivationDateTime", "easDeviceId", "emailAddress", "enrolledByUserPrincipalName", "enrolledDateTime", "enrollmentProfileName", "ethernetMacAddress", "exchangeAccessState", "exchangeAccessStateReason", "exchangeLastSuccessfulSyncDateTime", "freeStorageSpaceInBytes", "hardwareInformation", "iccid", "id", "imei", "isEncrypted", "isSupervised", "jailBroken", "lastSyncDateTime", "lostModeState", "managementAgent", "managementCertificateExpirationDate", "managementState", "manufacturer", "meid", "model", "operatingSystem", "osVersion", "partnerReportedThreatState", "phoneNumber", "physicalMemoryInBytes", "preferMdmOverGroupPolicyAppliedDateTime", "processorArchitecture", "remoteAssistanceSessionErrorDetails", "remoteAssistanceSessionUrl", "requireUserEnrollmentApproval", "retireAfterDateTime", "securityPatchLevel", "serialNumber", "skuNumber", "specificationVersion", "subscriberCarrier", "totalStorageSpaceInBytes", "udid", "userDisplayName", "userId", "userPrincipalName", "usersLoggedOn", "wiFiMacAddress", "windowsActiveMalwareCount", "windowsProtectionState", "windowsRemediatedMalwareCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
