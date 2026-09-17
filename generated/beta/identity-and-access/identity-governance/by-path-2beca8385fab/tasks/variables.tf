variable "workflow_id" {
  description = "The unique identifier of workflow"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workflow_id)) > 0
    error_message = "workflow_id must not be empty."
  }
}

variable "workflow_version_version_number" {
  description = "The unique identifier of workflowVersion"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workflow_version_version_number)) > 0
    error_message = "workflow_version_version_number must not be empty."
  }
}

variable "arguments" {
  description = "Arguments included within the task.  For guidance to configure this property, see Configure the arguments for built-in Lifecycle Workflow tasks. Required."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["joiner", "leaver", "unknownFutureValue", "mover", "extensibility"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "continue_on_error" {
  description = "A Boolean value that specifies whether, if this task fails, the workflow stops, and subsequent tasks aren't run. Optional."
  type        = bool
  default     = null
}

variable "description" {
  description = "A string that describes the purpose of the task for administrative use. Optional."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A unique string that identifies the task. Required.Supports $filter(eq, ne) and orderBy."
  type        = string
  default     = null
}

variable "execution_sequence" {
  description = "An integer that states in what order the task runs in a workflow.Supports $orderby."
  type        = number
  default     = null
}

variable "is_enabled" {
  description = "A Boolean value that denotes whether the task is set to run or not. Optional.Supports $filter(eq, ne) and orderBy."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.identityGovernance.task"
  nullable    = false
}

variable "task_definition_id" {
  description = "A unique template identifier for the task. For more information about the tasks that Lifecycle Workflows currently supports and their unique identifiers, see Configure the arguments for built-in Lifecycle Workflow tasks. Required.Supports $filter(eq, ne)."
  type        = string
  default     = null
}

variable "task_processing_results" {
  description = "The result of processing the task."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.identityGovernance.taskProcessingResult")
    completedDateTime = optional(string)
    createdDateTime   = optional(string)
    failureReason     = optional(string)
    processingInfo    = optional(string)
    processingStatus  = optional(string)
    startedDateTime   = optional(string)
    subject = optional(object({
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
        alternativeNames                    = optional(any)
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
        notificationEmailAddresses          = optional(any)
        owners                              = optional(any)
        passwordCredentials                 = optional(any)
        permissionGrantPreApprovalPolicies  = optional(any)
        preferredSingleSignOnMode           = optional(string)
        preferredTokenSigningKeyEndDateTime = optional(string)
        preferredTokenSigningKeyThumbprint  = optional(string)
        publishedPermissionScopes           = optional(any)
        publisherName                       = optional(string)
        remoteDesktopSecurityConfiguration  = optional(any)
        replyUrls                           = optional(any)
        samlMetadataUrl                     = optional(string)
        samlSingleSignOnSettings            = optional(any)
        servicePrincipalNames               = optional(any)
        servicePrincipalType                = optional(string)
        synchronization                     = optional(any)
        tags                                = optional(any)
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
        disabledPlans = optional(any)
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
        roleScopeTagIds                   = optional(any)
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
        alternativeNames       = optional(any)
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
        hostnames              = optional(any)
        isManaged              = optional(bool)
        isRooted               = optional(bool)
        kind                   = optional(string)
        managementType         = optional(string)
        name                   = optional(string)
        operatingSystem        = optional(string)
        operatingSystemVersion = optional(string)
        physicalIds            = optional(any)
        platform               = optional(string)
        profileType            = optional(string)
        status                 = optional(string)
        systemLabels           = optional(any)
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
        groupTypes                    = optional(any)
        hasMembersWithLicenseErrors   = optional(bool)
        hideFromAddressLists          = optional(bool)
        hideFromOutlookClients        = optional(bool)
        infoCatalogs                  = optional(any)
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
        resourceBehaviorOptions       = optional(any)
        resourceProvisioningOptions   = optional(any)
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
        flaggedReasons                  = optional(any)
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
        roleScopeTagIds                             = optional(any)
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
        payload            = optional(any)
        priority           = optional(any)
        targetHostName     = optional(string)
        targetPolicy       = optional(any)
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
    task = optional(object({
      odata_type = optional(string, "#microsoft.graph.identityGovernance.task")
      arguments = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.keyValuePair")
        name       = optional(string)
        value      = optional(string)
      })))
      category              = optional(string)
      continueOnError       = optional(bool)
      description           = optional(string)
      displayName           = optional(string)
      executionSequence     = optional(number)
      isEnabled             = optional(bool)
      taskDefinitionId      = optional(string)
      taskProcessingResults = optional(any)
    }))
    workflowSubject = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
