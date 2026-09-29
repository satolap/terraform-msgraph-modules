variable "about_me" {
  description = "A freeform text entry field for users to describe themselves. Requires $select to retrieve."
  type        = string
  default     = null
}

variable "account_enabled" {
  description = "true if the account is enabled; otherwise, false. This property is required when creating the object. Supports $filter (eq, ne, not, and in). This property is subject to sensitive action restrictions; only specific privileged administrator roles can update it."
  type        = bool
  default     = null
}

variable "age_group" {
  description = "Sets the age group of the user. Allowed values: null, Minor, NotAdult, and Adult. For more information, see legal age group property definitions. Supports $filter (eq, ne, not, and in)."
  type        = string
  default     = null
}

variable "analytics" {
  description = "Microsoft Graph analytics property."
  type        = any
  default     = null
}

variable "app_consent_requests_for_approval" {
  description = "Microsoft Graph appConsentRequestsForApproval property."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.appConsentRequest")
    appDisplayName = optional(string)
    appId          = optional(string)
    consentType    = optional(string)
    pendingScopes = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.appConsentRequestScope")
      displayName = optional(string)
    })))
    userConsentRequests = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.userConsentRequest")
      approval          = optional(any)
      approvalId        = optional(string)
      completedDateTime = optional(string)
      createdBy         = optional(any)
      createdDateTime   = optional(string)
      customData        = optional(string)
      reason            = optional(string)
      status            = optional(string)
    })))
  }))
  default = null
}

variable "app_role_assigned_resources" {
  description = "Microsoft Graph appRoleAssignedResources property."
  type        = any
  default     = null
  sensitive   = true
}

variable "app_role_assignments" {
  description = "Represents the app roles a user has been granted for an application. Supports $expand."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
    appRoleId           = optional(string)
    deletedDateTime     = optional(string)
    principalId         = optional(string)
    resourceDisplayName = optional(string)
    resourceId          = optional(string)
  }))
  default = null
}

variable "approvals" {
  description = "Microsoft Graph approvals property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.approval")
    steps = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.approvalStep")
      justification = optional(string)
      reviewResult  = optional(string)
    })))
  }))
  default = null
}

variable "assigned_licenses" {
  description = "The licenses that are assigned to the user, including inherited (group-based) licenses. This property doesn't differentiate between directly assigned and inherited licenses. Use the licenseAssignmentStates property to identify the directly assigned and inherited licenses. Not nullable. Supports $filter (eq, not, /$count eq 0, /$count ne 0)."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.assignedLicense")
    disabledPlans = optional(list(string))
    skuId         = optional(string)
  }))
  default = null
}

variable "authentication" {
  description = "The authentication methods that are supported for the user."
  type        = any
  default     = null
}

variable "authorization_info" {
  description = "Identifiers that can be used to identify and authenticate a user in non-Azure AD environments. This property can store identifiers for smartcard-based certificates that users use to access on-premises Active Directory deployments or federated access. It can also be used to store the Subject Alternate Name (SAN) that's associated with a Common Access Card (CAC). Nullable.Supports $filter (eq and startsWith)."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.authorizationInfo")
    certificateUserIds = optional(list(string))
  })
  default = null
}

variable "birthday" {
  description = "The birthday of the user. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z Requires $select to retrieve."
  type        = string
  default     = null
}

variable "business_phones" {
  description = "The telephone numbers for the user. Only one number can be set for this property. Read-only for users synced from on-premises directory. Supports $filter (eq, not, ge, le, startsWith). This property is subject to sensitive action restrictions; only specific privileged administrator roles can update it."
  type        = list(string)
  default     = null
}

variable "chats" {
  description = "Microsoft Graph chats property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.chat")
    chatType           = optional(string)
    installedApps      = optional(any)
    lastMessagePreview = optional(any)
    members            = optional(any)
    messages           = optional(any)
    migrationMode      = optional(string)
    operations = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.teamsAsyncOperation")
      attemptsCount   = optional(number)
      createdDateTime = optional(string)
      error = optional(object({
        odata_type = optional(string, "#microsoft.graph.operationError")
        code       = optional(string)
        message    = optional(string)
      }))
      lastActionDateTime     = optional(string)
      operationType          = optional(string)
      status                 = optional(string)
      targetResourceId       = optional(string)
      targetResourceLocation = optional(string)
    })))
    originalCreatedDateTime = optional(string)
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    pinnedMessages = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")
      message    = optional(any)
    })))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName    = optional(string)
      messageId      = optional(string)
      sortOrderIndex = optional(string)
      teamsApp       = optional(any)
      teamsAppId     = optional(string)
    })))
    targetedMessages = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.targetedChatMessage")
      attachments = optional(any)
      body = optional(object({
        odata_type             = optional(string, "#microsoft.graph.chatMessageBody")
        content                = optional(string)
        contentType            = optional(string)
        messageBodyContentType = optional(string)
      }))
      channelIdentity = optional(object({
        odata_type = optional(string, "#microsoft.graph.channelIdentity")
        channelId  = optional(string)
        teamId     = optional(string)
      }))
      chatId          = optional(string)
      createdDateTime = optional(string)
      from = optional(object({
        odata_type  = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")
        application = optional(any)
        device      = optional(any)
        user        = optional(any)
      }))
      hasReplies     = optional(bool)
      hostedContents = optional(any)
      importance     = optional(string)
      locale         = optional(string)
      mentions       = optional(any)
      messageHistory = optional(any)
      messageType    = optional(string)
      onBehalfOf = optional(object({
        odata_type  = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")
        application = optional(any)
        device      = optional(any)
        user        = optional(any)
      }))
      policyViolation = optional(object({
        odata_type        = optional(string, "#microsoft.graph.chatMessagePolicyViolation")
        dlpAction         = optional(string)
        justificationText = optional(string)
        policyTip         = optional(any)
        userAction        = optional(string)
        verdictDetails    = optional(string)
      }))
      reactions = optional(any)
      recipient = optional(any)
      replies   = optional(any)
      subject   = optional(string)
      summary   = optional(string)
    })))
    topic = optional(string)
    viewpoint = optional(object({
      odata_type              = optional(string, "#microsoft.graph.chatViewpoint")
      isHidden                = optional(bool)
      lastMessageReadDateTime = optional(string)
    }))
  }))
  default = null
}

variable "city" {
  description = "The city where the user is located. Maximum length is 128 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "cloud_clipboard" {
  description = "Microsoft Graph cloudClipboard property."
  type        = any
  default     = null
}

variable "cloud_licensing" {
  description = "The relationships of a user to cloud licensing resources."
  type = object({
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
      disabledServicePlanIds = optional(list(string))
    })))
    usageRights = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")
      allotments = optional(list(object({
        odata_type                = optional(string, "#microsoft.graph.cloudLicensing.allotment")
        assignableTo              = optional(string)
        assignments               = optional(any)
        externalServiceIdentifier = optional(string)
        subscriptions             = optional(any)
        waitingMembers            = optional(any)
      })))
      assignments = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.cloudLicensing.assignment")
        allotment              = optional(any)
        assignedTo             = optional(any)
        disabledServicePlanIds = optional(any)
      })))
      externalServiceIdentifier = optional(string)
    })))
    waitingMembers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.waitingMember")
      allotment = optional(object({
        odata_type                = optional(string, "#microsoft.graph.cloudLicensing.allotment")
        assignableTo              = optional(string)
        assignments               = optional(any)
        externalServiceIdentifier = optional(string)
        subscriptions             = optional(any)
        waitingMembers            = optional(any)
      }))
      assignedTo           = optional(any)
      waitingSinceDateTime = optional(string)
    })))
  })
  default = null
}

variable "cloud_realtime_communication_info" {
  description = "Microsoft realtime communication information related to the user.  Supports $filter (eq, ne,not)."
  type = object({
    odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")
  })
  default = null
}

variable "communications" {
  description = "The user's communications settings on Teams."
  type        = any
  default     = null
}

variable "company_name" {
  description = "The name of the company the user is associated with. This property can be useful for describing the company that an external user comes from. The maximum length is 64 characters.Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "consent_provided_for_minor" {
  description = "Sets whether consent has been obtained for minors. Allowed values: null, Granted, Denied and NotRequired. Refer to the legal age group property definitions for further information. Supports $filter (eq, ne, not, and in)."
  type        = string
  default     = null
}

variable "country" {
  description = "The country or region where the user is located; for example, US or UK. Maximum length is 128 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "custom_security_attributes" {
  description = "An open complex type that holds the value of a custom security attribute that is assigned to a directory object. Nullable. Requires $select to retrieve. Supports $filter (eq, ne, not, startsWith). The filter value is case-sensitive. To read this property, the calling app must be assigned the CustomSecAttributeAssignment.Read.All permission. To write this property, the calling app must be assigned the CustomSecAttributeAssignment.ReadWrite.All permissions. To read or write this property in delegated scenarios, the admin must be assigned the Attribute Assignment Administrator role. Supports $filter (eq, ne, not , ge, le, in)."
  type        = any
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "department" {
  description = "The name of the department where the user works. Maximum length is 64 characters.Supports $filter (eq, ne, not , ge, le, in, and eq on null values)."
  type        = string
  default     = null
}

variable "device_enrollment_configurations" {
  description = "Get enrollment configurations targeted to the user"
  type        = any
  default     = null
}

variable "device_enrollment_limit" {
  description = "The limit on the maximum number of devices that the user is permitted to enroll. Allowed values are 5 or 1000."
  type        = number
  default     = null
}

variable "device_keys" {
  description = "Microsoft Graph deviceKeys property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.deviceKey")
    deviceId    = optional(string)
    keyMaterial = optional(string)
    keyType     = optional(string)
  }))
  default = null
}

variable "device_management_troubleshooting_events" {
  description = "The list of troubleshooting events for this user."
  type        = any
  default     = null
}

variable "devices" {
  description = "Microsoft Graph devices property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.device")
    accountEnabled   = optional(bool)
    alternativeNames = optional(list(string))
    alternativeSecurityIds = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.alternativeSecurityId")
      identityProvider = optional(string)
      key              = optional(string)
      type             = optional(number)
    })))
    commands = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.command")
      appServiceName    = optional(string)
      error             = optional(string)
      packageFamilyName = optional(string)
      payload           = optional(any)
      permissionTicket  = optional(string)
      postBackUri       = optional(string)
      responsepayload   = optional(any)
      status            = optional(string)
      type              = optional(string)
    })))
    deletedDateTime       = optional(string)
    deviceCategory        = optional(string)
    deviceId              = optional(string)
    deviceMetadata        = optional(string)
    deviceOwnership       = optional(string)
    deviceVersion         = optional(number)
    displayName           = optional(string)
    domainName            = optional(string)
    enrollmentProfileName = optional(string)
    enrollmentType        = optional(string)
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
    usageRights = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.usageRight")
      catalogId         = optional(string)
      serviceIdentifier = optional(string)
      state             = optional(string)
    })))
  }))
  default = null
}

variable "display_name" {
  description = "The name displayed in the address book for the user. This value is usually the combination of the user's first name, middle initial, and last name. This property is required when a user is created, and it cannot be cleared during updates. Maximum length is 256 characters. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values), $orderby, and $search."
  type        = string
  default     = null
}

variable "employee_hire_date" {
  description = "The date and time when the user was hired or will start work if there is a future hire. Supports $filter (eq, ne, not , ge, le, in)."
  type        = string
  default     = null
}

variable "employee_id" {
  description = "The employee identifier assigned to the user by the organization. The maximum length is 16 characters.Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "employee_leave_date_time" {
  description = "The date and time when the user left or will leave the organization. To read this property, the calling app must be assigned the User-LifeCycleInfo.Read.All permission. To write this property, the calling app must be assigned the User.Read.All and User-LifeCycleInfo.ReadWrite.All permissions. To read this property in delegated scenarios, the admin needs at least one of the following Microsoft Entra roles: Lifecycle Workflows Administrator (least privilege), Global Reader. To write this property in delegated scenarios, the admin needs the Global Administrator role. Supports $filter (eq, ne, not , ge, le, in). For more information, see Configure the employeeLeaveDateTime property for a user."
  type        = string
  default     = null
}

variable "employee_org_data" {
  description = "Represents organization data (for example, division and costCenter) associated with a user. Supports $filter (eq, ne, not , ge, le, in)."
  type = object({
    odata_type = optional(string, "#microsoft.graph.employeeOrgData")
    costCenter = optional(string)
    division   = optional(string)
  })
  default = null
}

variable "employee_type" {
  description = "Captures enterprise worker type. For example, Employee, Contractor, Consultant, or Vendor. Supports $filter (eq, ne, not , ge, le, in, startsWith)."
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the user. Supports $expand. Nullable."
  type        = any
  default     = null
}

variable "external_user_state" {
  description = "For an external user invited to the tenant using the invitation API, this property represents the invited user's invitation status. For invited users, the state can be PendingAcceptance or Accepted, or null for all other users. Supports $filter (eq, ne, not , in)."
  type        = string
  default     = null
}

variable "external_user_state_change_date_time" {
  description = "Shows the timestamp for the latest change to the externalUserState property. Supports $filter (eq, ne, not , in)."
  type        = string
  default     = null
}

variable "fax_number" {
  description = "The fax number of the user. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "followed_sites" {
  description = "Microsoft Graph followedSites property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.site")
    analytics  = optional(any)
    columns = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.columnDefinition")
      boolean    = optional(any)
      calculated = optional(object({
        odata_type = optional(string, "#microsoft.graph.calculatedColumn")
        format     = optional(string)
        formula    = optional(string)
        outputType = optional(string)
      }))
      choice = optional(object({
        odata_type     = optional(string, "#microsoft.graph.choiceColumn")
        allowTextEntry = optional(bool)
        choices        = optional(any)
        displayAs      = optional(string)
      }))
      columnGroup           = optional(string)
      contentApprovalStatus = optional(any)
      currency = optional(object({
        odata_type = optional(string, "#microsoft.graph.currencyColumn")
        locale     = optional(string)
      }))
      dateTime = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeColumn")
        displayAs  = optional(string)
        format     = optional(string)
      }))
      defaultValue = optional(object({
        odata_type = optional(string, "#microsoft.graph.defaultColumnValue")
        formula    = optional(string)
        value      = optional(string)
      }))
      description         = optional(string)
      displayName         = optional(string)
      enforceUniqueValues = optional(bool)
      geolocation         = optional(any)
      hidden              = optional(bool)
      hyperlinkOrPicture = optional(object({
        odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")
        isPicture  = optional(bool)
      }))
      indexed      = optional(bool)
      isDeletable  = optional(bool)
      isSealed     = optional(bool)
      isSearchable = optional(bool)
      lookup = optional(object({
        odata_type            = optional(string, "#microsoft.graph.lookupColumn")
        allowMultipleValues   = optional(bool)
        allowUnlimitedLength  = optional(bool)
        columnName            = optional(string)
        listId                = optional(string)
        primaryLookupColumnId = optional(string)
      }))
      name = optional(string)
      number = optional(object({
        odata_type    = optional(string, "#microsoft.graph.numberColumn")
        decimalPlaces = optional(string)
        displayAs     = optional(string)
        maximum       = optional(any)
        minimum       = optional(any)
      }))
      personOrGroup = optional(object({
        odata_type             = optional(string, "#microsoft.graph.personOrGroupColumn")
        allowMultipleSelection = optional(bool)
        chooseFromType         = optional(string)
        displayAs              = optional(string)
      }))
      propagateChanges = optional(bool)
      readOnly         = optional(bool)
      required         = optional(bool)
      sourceColumn     = optional(any)
      sourceContentType = optional(object({
        odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
        id         = optional(string)
        name       = optional(string)
      }))
      term = optional(object({
        odata_type             = optional(string, "#microsoft.graph.termColumn")
        allowMultipleValues    = optional(bool)
        parentTerm             = optional(any)
        showFullyQualifiedName = optional(bool)
        termSet                = optional(any)
      }))
      text = optional(object({
        odata_type                  = optional(string, "#microsoft.graph.textColumn")
        allowMultipleLines          = optional(bool)
        appendChangesToExistingText = optional(bool)
        linesForEditing             = optional(number)
        maxLength                   = optional(number)
        textType                    = optional(string)
      }))
      thumbnail = optional(any)
      validation = optional(object({
        odata_type      = optional(string, "#microsoft.graph.columnValidation")
        defaultLanguage = optional(string)
        descriptions    = optional(any)
        formula         = optional(string)
      }))
    })))
    contentModels = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.contentModel")
      modelType  = optional(string)
      name       = optional(string)
    })))
    contentTypes = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.contentType")
      associatedHubsUrls = optional(list(string))
      base               = optional(any)
      baseTypes          = optional(any)
      columnLinks        = optional(any)
      columnPositions    = optional(any)
      columns            = optional(any)
      description        = optional(string)
      documentSet = optional(object({
        odata_type                  = optional(string, "#microsoft.graph.documentSet")
        allowedContentTypes         = optional(any)
        defaultContents             = optional(any)
        propagateWelcomePageChanges = optional(bool)
        sharedColumns               = optional(any)
        shouldPrefixNameToFile      = optional(bool)
        welcomePageColumns          = optional(any)
        welcomePageUrl              = optional(string)
      }))
      documentTemplate = optional(object({
        odata_type  = optional(string, "#microsoft.graph.documentSetContent")
        contentType = optional(any)
        fileName    = optional(string)
        folderName  = optional(string)
      }))
      group  = optional(string)
      hidden = optional(bool)
      inheritedFrom = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      isBuiltIn = optional(bool)
      name      = optional(string)
      order = optional(object({
        odata_type = optional(string, "#microsoft.graph.contentTypeOrder")
        default    = optional(bool)
        position   = optional(number)
      }))
      parentId         = optional(string)
      propagateChanges = optional(bool)
      readOnly         = optional(bool)
      sealed           = optional(bool)
    })))
    createdByUser = optional(any)
    deleted = optional(object({
      odata_type = optional(string, "#microsoft.graph.deleted")
      state      = optional(string)
    }))
    description = optional(string)
    documentProcessingJobs = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.documentProcessingJob")
      jobType          = optional(string)
      listItemUniqueId = optional(string)
      status           = optional(string)
    })))
    drive = optional(any)
    drives = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.drive")
      activities         = optional(any)
      bundles            = optional(any)
      createdByUser      = optional(any)
      description        = optional(string)
      following          = optional(any)
      lastModifiedByUser = optional(any)
      name               = optional(string)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      sharePointIds = optional(object({
        odata_type       = optional(string, "#microsoft.graph.sharepointIds")
        listId           = optional(string)
        listItemId       = optional(string)
        listItemUniqueId = optional(string)
        siteId           = optional(string)
        siteUrl          = optional(string)
        tenantId         = optional(string)
        webId            = optional(string)
      }))
    })))
    extensions = optional(any)
    externalColumns = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.columnDefinition")
      boolean    = optional(any)
      calculated = optional(object({
        odata_type = optional(string, "#microsoft.graph.calculatedColumn")
        format     = optional(string)
        formula    = optional(string)
        outputType = optional(string)
      }))
      choice = optional(object({
        odata_type     = optional(string, "#microsoft.graph.choiceColumn")
        allowTextEntry = optional(bool)
        choices        = optional(any)
        displayAs      = optional(string)
      }))
      columnGroup           = optional(string)
      contentApprovalStatus = optional(any)
      currency = optional(object({
        odata_type = optional(string, "#microsoft.graph.currencyColumn")
        locale     = optional(string)
      }))
      dateTime = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeColumn")
        displayAs  = optional(string)
        format     = optional(string)
      }))
      defaultValue = optional(object({
        odata_type = optional(string, "#microsoft.graph.defaultColumnValue")
        formula    = optional(string)
        value      = optional(string)
      }))
      description         = optional(string)
      displayName         = optional(string)
      enforceUniqueValues = optional(bool)
      geolocation         = optional(any)
      hidden              = optional(bool)
      hyperlinkOrPicture = optional(object({
        odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")
        isPicture  = optional(bool)
      }))
      indexed      = optional(bool)
      isDeletable  = optional(bool)
      isSealed     = optional(bool)
      isSearchable = optional(bool)
      lookup = optional(object({
        odata_type            = optional(string, "#microsoft.graph.lookupColumn")
        allowMultipleValues   = optional(bool)
        allowUnlimitedLength  = optional(bool)
        columnName            = optional(string)
        listId                = optional(string)
        primaryLookupColumnId = optional(string)
      }))
      name = optional(string)
      number = optional(object({
        odata_type    = optional(string, "#microsoft.graph.numberColumn")
        decimalPlaces = optional(string)
        displayAs     = optional(string)
        maximum       = optional(any)
        minimum       = optional(any)
      }))
      personOrGroup = optional(object({
        odata_type             = optional(string, "#microsoft.graph.personOrGroupColumn")
        allowMultipleSelection = optional(bool)
        chooseFromType         = optional(string)
        displayAs              = optional(string)
      }))
      propagateChanges = optional(bool)
      readOnly         = optional(bool)
      required         = optional(bool)
      sourceColumn     = optional(any)
      sourceContentType = optional(object({
        odata_type = optional(string, "#microsoft.graph.contentTypeInfo")
        id         = optional(string)
        name       = optional(string)
      }))
      term = optional(object({
        odata_type             = optional(string, "#microsoft.graph.termColumn")
        allowMultipleValues    = optional(bool)
        parentTerm             = optional(any)
        showFullyQualifiedName = optional(bool)
        termSet                = optional(any)
      }))
      text = optional(object({
        odata_type                  = optional(string, "#microsoft.graph.textColumn")
        allowMultipleLines          = optional(bool)
        appendChangesToExistingText = optional(bool)
        linesForEditing             = optional(number)
        maxLength                   = optional(number)
        textType                    = optional(string)
      }))
      thumbnail = optional(any)
      validation = optional(object({
        odata_type      = optional(string, "#microsoft.graph.columnValidation")
        defaultLanguage = optional(string)
        descriptions    = optional(any)
        formula         = optional(string)
      }))
    })))
    informationProtection = optional(any)
    isPersonalSite        = optional(bool)
    items                 = optional(any)
    lastModifiedByUser    = optional(any)
    lists = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.list")
      activities         = optional(any)
      columns            = optional(any)
      contentTypes       = optional(any)
      createdByUser      = optional(any)
      description        = optional(string)
      displayName        = optional(string)
      drive              = optional(any)
      items              = optional(any)
      lastModifiedByUser = optional(any)
      list = optional(object({
        odata_type          = optional(string, "#microsoft.graph.listInfo")
        contentTypesEnabled = optional(bool)
        hidden              = optional(bool)
        template            = optional(string)
      }))
      name       = optional(string)
      operations = optional(any)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      subscriptions = optional(any)
    })))
    locale    = optional(string)
    lockState = optional(string)
    name      = optional(string)
    onenote   = optional(any)
    operations = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.richLongRunningOperation")
      createdDateTime = optional(string)
      error = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicError")
        code       = optional(string)
        details    = optional(any)
        innerError = optional(any)
        message    = optional(string)
        target     = optional(string)
      }))
      lastActionDateTime = optional(string)
      percentageComplete = optional(number)
      resourceId         = optional(string)
      resourceLocation   = optional(string)
      status             = optional(string)
      statusDetail       = optional(string)
      type               = optional(string)
    })))
    ownerIdentityToResolve = optional(object({
      odata_type = optional(string, "#microsoft.graph.identityInput")
      alias      = optional(string)
      email      = optional(string)
      objectId   = optional(string)
    }))
    pageTemplates = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.pageTemplate")
      canvasLayout       = optional(any)
      createdByUser      = optional(any)
      description        = optional(string)
      lastModifiedByUser = optional(any)
      name               = optional(string)
      pageLayout         = optional(string)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      publishingState = optional(object({
        odata_type   = optional(string, "#microsoft.graph.publicationFacet")
        checkedOutBy = optional(any)
      }))
      title = optional(string)
      titleArea = optional(object({
        odata_type              = optional(string, "#microsoft.graph.titleArea")
        alternativeText         = optional(string)
        enableGradientEffect    = optional(bool)
        imageWebUrl             = optional(string)
        layout                  = optional(string)
        serverProcessedContent  = optional(any)
        showAuthor              = optional(bool)
        showPublishedDate       = optional(bool)
        showTextBlockAboveTitle = optional(bool)
        textAboveTitle          = optional(string)
        textAlignment           = optional(string)
      }))
      webParts = optional(any)
    })))
    pages = optional(any)
    parentReference = optional(object({
      odata_type = optional(string, "#microsoft.graph.itemReference")
      driveType  = optional(string)
      shareId    = optional(string)
      siteId     = optional(string)
    }))
    permissions = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.permission")
      expirationDateTime = optional(string)
    })))
    recycleBin          = optional(any)
    shareByEmailEnabled = optional(bool)
    sites               = optional(any)
    template            = optional(string)
    termStore           = optional(any)
  }))
  default = null
}

variable "given_name" {
  description = "The given name (first name) of the user. Maximum length is 64 characters. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "hire_date" {
  description = "The hire date of the user. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.  Requires $select to retrieve.  Note: This property is specific to SharePoint Online. We recommend using the native employeeHireDate property to set and update hire date values using Microsoft Graph APIs."
  type        = string
  default     = null
}

variable "identities" {
  description = "Represents the identities that can be used to sign in to this user account. An identity can be provided by Microsoft (also known as a local account), by organizations, or by social identity providers such as Facebook, Google, and Microsoft and tied to a user account. It may contain multiple items with the same signInType value.  Supports $filter (eq) with limitations."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.objectIdentity")
    issuer           = optional(string)
    issuerAssignedId = optional(string)
    signInType       = optional(string)
  }))
  default = null
}

variable "identity_governance" {
  description = "The identity governance settings for the user, including the approver delegate configuration. Nullable. Returned only on $select. Supports $expand."
  type = object({
    odata_type = optional(string, "#microsoft.graph.identityGovernanceUserSettings")
    approverDelegate = optional(object({
      odata_type = optional(string, "#microsoft.graph.approverDelegate")
      delegate   = optional(any)
      schedule = optional(object({
        odata_type = optional(string, "#microsoft.graph.requestSchedule")
        expiration = optional(object({
          odata_type  = optional(string, "#microsoft.graph.expirationPattern")
          duration    = optional(string)
          endDateTime = optional(string)
          type        = optional(string)
        }))
        recurrence = optional(object({
          odata_type = optional(string, "#microsoft.graph.patternedRecurrence")
          pattern = optional(object({
            odata_type     = optional(string, "#microsoft.graph.recurrencePattern")
            dayOfMonth     = optional(number)
            daysOfWeek     = optional(any)
            firstDayOfWeek = optional(string)
            index          = optional(string)
            interval       = optional(number)
            month          = optional(number)
            type           = optional(string)
          }))
          range = optional(object({
            odata_type          = optional(string, "#microsoft.graph.recurrenceRange")
            endDate             = optional(string)
            numberOfOccurrences = optional(number)
            recurrenceTimeZone  = optional(string)
            startDate           = optional(string)
            type                = optional(string)
          }))
        }))
        startDateTime = optional(string)
      }))
    }))
  })
  default = null
}

variable "identity_parent_id" {
  description = "The object ID of the parent identity for agent users. Always null for regular user accounts. For agentUser resources, this property references the object ID of the associated agent identity."
  type        = string
  default     = null
}

variable "inference_classification" {
  description = "Relevance classification of the user's messages based on explicit designations that override inferred relevance or importance."
  type        = any
  default     = null
}

variable "info_catalogs" {
  description = "Identifies the info segments assigned to the user.  Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "information_protection" {
  description = "Microsoft Graph informationProtection property."
  type        = any
  default     = null
}

variable "interests" {
  description = "A list for users to describe their interests. Requires $select to retrieve."
  type        = list(string)
  default     = null
}

variable "invited_by" {
  description = "The user or service principal that invited the user."
  type        = any
  default     = null
}

variable "is_resource_account" {
  description = "Do not use. Reserved for future use."
  type        = bool
  default     = null
}

variable "job_title" {
  description = "The user's job title. Maximum length is 128 characters. Supports $filter (eq, ne, not , ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "joined_groups" {
  description = "Microsoft Graph joinedGroups property."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.group")
    acceptedSenders      = optional(any)
    accessType           = optional(string)
    allowExternalSenders = optional(bool)
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    assignedLabels = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.assignedLabel")
      labelId    = optional(string)
    })))
    autoSubscribeNewMembers = optional(bool)
    classification          = optional(string)
    cloudLicensing = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")
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
    }))
    conversations = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.conversation")
      hasAttachments        = optional(bool)
      lastDeliveredDateTime = optional(string)
      preview               = optional(string)
      topic                 = optional(string)
      uniqueSenders         = optional(list(string))
    })))
    deletedDateTime = optional(string)
    description     = optional(string)
    displayName     = optional(string)
    events = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.event")
      allowNewTimeProposals = optional(bool)
      attendees             = optional(any)
      body = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      bodyPreview          = optional(string)
      cancelledOccurrences = optional(list(string))
      categories           = optional(list(string))
      createdDateTime      = optional(string)
      end = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
        dateTime   = optional(string)
        timeZone   = optional(string)
      }))
      exceptionOccurrences  = optional(any)
      extensions            = optional(any)
      hasAttachments        = optional(bool)
      hideAttendees         = optional(bool)
      importance            = optional(string)
      isAllDay              = optional(bool)
      isCancelled           = optional(bool)
      isDraft               = optional(bool)
      isOnlineMeeting       = optional(bool)
      isOrganizer           = optional(bool)
      isReminderOn          = optional(bool)
      lastModifiedDateTime  = optional(string)
      location              = optional(any)
      locations             = optional(any)
      occurrenceId          = optional(string)
      onlineMeetingProvider = optional(string)
      organizer             = optional(any)
      originalEndTimeZone   = optional(string)
      originalStart         = optional(string)
      originalStartTimeZone = optional(string)
      recurrence = optional(object({
        odata_type = optional(string, "#microsoft.graph.patternedRecurrence")
        pattern    = optional(any)
        range      = optional(any)
      }))
      reminderMinutesBeforeStart = optional(number)
      responseRequested          = optional(bool)
      responseStatus = optional(object({
        odata_type = optional(string, "#microsoft.graph.responseStatus")
        response   = optional(string)
        time       = optional(string)
      }))
      sensitivity    = optional(string)
      seriesMasterId = optional(string)
      showAs         = optional(string)
      start = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
        dateTime   = optional(string)
        timeZone   = optional(string)
      }))
      subject       = optional(string)
      transactionId = optional(string)
      uid           = optional(string)
      webLink       = optional(string)
    })))
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
    onPremisesProvisioningErrors = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
      category             = optional(string)
      occurredDateTime     = optional(string)
      propertyCausingError = optional(string)
      value                = optional(string)
    })))
    onPremisesSyncBehavior = optional(any)
    onenote                = optional(any)
    organizationId         = optional(string)
    owners                 = optional(any)
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    photo                       = optional(any)
    preferredDataLocation       = optional(string)
    preferredLanguage           = optional(string)
    rejectedSenders             = optional(any)
    resourceBehaviorOptions     = optional(list(string))
    resourceProvisioningOptions = optional(list(string))
    securityEnabled             = optional(bool)
    serviceProvisioningErrors   = optional(any)
    settings = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.directorySetting")
      values     = optional(any)
    })))
    sites = optional(list(object({
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
    team  = optional(any)
    theme = optional(string)
    threads = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.conversationThread")
      ccRecipients          = optional(any)
      hasAttachments        = optional(bool)
      isLocked              = optional(bool)
      lastDeliveredDateTime = optional(string)
      posts                 = optional(any)
      preview               = optional(string)
      toRecipients          = optional(any)
      topic                 = optional(string)
      uniqueSenders         = optional(list(string))
    })))
    transitiveMemberOf       = optional(any)
    transitiveMembers        = optional(any)
    unseenConversationsCount = optional(number)
    unseenCount              = optional(number)
    unseenMessagesCount      = optional(number)
    visibility               = optional(string)
    welcomeMessageEnabled    = optional(bool)
    writebackConfiguration = optional(object({
      odata_type          = optional(string, "#microsoft.graph.groupWritebackConfiguration")
      isEnabled           = optional(bool)
      onPremisesGroupType = optional(string)
    }))
  }))
  default = null
}

variable "license_details" {
  description = "Microsoft Graph licenseDetails property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.licenseDetails")
  }))
  default = null
}

variable "mail" {
  description = "The SMTP address for the user, for example, admin@contoso.com. Changes to this property also update the user's proxyAddresses collection to include the value as an SMTP address. This property can't contain accent characters.  NOTE: We don't recommend updating this property for Azure AD B2C user profiles. Use the otherMails property instead.  Supports $filter (eq, ne, not, ge, le, in, startsWith, endsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "mail_nickname" {
  description = "The mail alias for the user. This property must be specified when a user is created. Maximum length is 64 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "mailbox_settings" {
  description = "Settings for the primary mailbox of the signed-in user. You can get or update settings for sending automatic replies to incoming messages, locale, and time zone. For more information, see User preferences for languages and regional formats. Requires $select to retrieve."
  type = object({
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
  })
  default = null
}

variable "managed_app_log_collection_requests" {
  description = "Zero or more log collection requests triggered for the user."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")
    userLogUploadConsent = optional(string)
    version              = optional(string)
  }))
  default = null
}

variable "managed_app_registrations" {
  description = "Zero or more managed app registrations that belong to the user."
  type        = any
  default     = null
}

variable "managed_devices" {
  description = "The managed devices associated with the user."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedDevice")
    assignmentFilterEvaluationStatusDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.assignmentFilterEvaluationStatusDetails")
      payloadId  = optional(string)
    })))
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
      statusDetail = optional(object({
        odata_type            = optional(string, "#microsoft.graph.cloudPcStatusDetail")
        additionalInformation = optional(any)
        code                  = optional(string)
        message               = optional(string)
      }))
      statusDetails = optional(object({
        odata_type            = optional(string, "#microsoft.graph.cloudPcStatusDetails")
        additionalInformation = optional(any)
        code                  = optional(string)
        message               = optional(string)
      }))
    })))
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
    deviceFirmwareConfigurationInterfaceManaged = optional(bool)
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
    managedDeviceName      = optional(string)
    managedDeviceOwnerType = optional(string)
    managementFeatures     = optional(string)
    notes                  = optional(string)
    ownerType              = optional(string)
    roleScopeTagIds        = optional(list(string))
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
      odata_type                    = optional(string, "#microsoft.graph.user")
      aboutMe                       = optional(string)
      accountEnabled                = optional(bool)
      ageGroup                      = optional(string)
      analytics                     = optional(any)
      appConsentRequestsForApproval = optional(any)
      appRoleAssignedResources      = optional(any)
      appRoleAssignments            = optional(any)
      approvals                     = optional(any)
      assignedLicenses              = optional(any)
      authentication                = optional(any)
      authorizationInfo = optional(object({
        odata_type         = optional(string, "#microsoft.graph.authorizationInfo")
        certificateUserIds = optional(any)
      }))
      birthday       = optional(string)
      chats          = optional(any)
      city           = optional(string)
      cloudClipboard = optional(any)
      cloudLicensing = optional(object({
        odata_type       = optional(string, "#microsoft.graph.cloudLicensing.userCloudLicensing")
        assignmentErrors = optional(any)
        assignments      = optional(any)
        usageRights      = optional(any)
        waitingMembers   = optional(any)
      }))
      cloudRealtimeCommunicationInfo = optional(object({
        odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")
      }))
      communications                        = optional(any)
      companyName                           = optional(string)
      consentProvidedForMinor               = optional(string)
      country                               = optional(string)
      customSecurityAttributes              = optional(any)
      deletedDateTime                       = optional(string)
      department                            = optional(string)
      deviceEnrollmentConfigurations        = optional(any)
      deviceEnrollmentLimit                 = optional(number)
      deviceKeys                            = optional(any)
      deviceManagementTroubleshootingEvents = optional(any)
      devices                               = optional(any)
      displayName                           = optional(string)
      employeeHireDate                      = optional(string)
      employeeId                            = optional(string)
      employeeLeaveDateTime                 = optional(string)
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
      followedSites                   = optional(any)
      givenName                       = optional(string)
      hireDate                        = optional(string)
      identities                      = optional(any)
      identityGovernance = optional(object({
        odata_type       = optional(string, "#microsoft.graph.identityGovernanceUserSettings")
        approverDelegate = optional(any)
      }))
      identityParentId        = optional(string)
      inferenceClassification = optional(any)
      infoCatalogs            = optional(list(string))
      informationProtection   = optional(any)
      interests               = optional(list(string))
      invitedBy               = optional(any)
      isResourceAccount       = optional(bool)
      jobTitle                = optional(string)
      joinedGroups            = optional(any)
      licenseDetails          = optional(any)
      mail                    = optional(string)
      mailNickname            = optional(string)
      mailboxSettings = optional(object({
        odata_type                            = optional(string, "#microsoft.graph.mailboxSettings")
        automaticRepliesSetting               = optional(any)
        dateFormat                            = optional(string)
        delegateMeetingMessageDeliveryOptions = optional(string)
        language                              = optional(any)
        timeFormat                            = optional(string)
        timeZone                              = optional(string)
        userPurposeV2                         = optional(string)
        workingHours                          = optional(any)
      }))
      managedAppLogCollectionRequests = optional(any)
      managedAppRegistrations         = optional(any)
      managedDevices                  = optional(any)
      mobileAppIntentAndStates        = optional(any)
      mobileAppTroubleshootingEvents  = optional(any)
      mySite                          = optional(string)
      notifications                   = optional(any)
      oauth2PermissionGrants          = optional(any)
      officeLocation                  = optional(string)
      onPremisesDistinguishedName     = optional(string)
      onPremisesDomainName            = optional(string)
      onPremisesImmutableId           = optional(string)
      onPremisesProvisioningErrors    = optional(any)
      onPremisesSamAccountName        = optional(string)
      onPremisesSecurityIdentifier    = optional(string)
      onPremisesSyncBehavior          = optional(any)
      onPremisesUserPrincipalName     = optional(string)
      onenote                         = optional(any)
      onlineMeetings                  = optional(any)
      otherMails                      = optional(list(string))
      passwordPolicies                = optional(string)
      passwordProfile = optional(object({
        odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
        forceChangePasswordNextSignIn        = optional(bool)
        forceChangePasswordNextSignInWithMfa = optional(bool)
        password                             = optional(string)
      }))
      pastProjects                 = optional(list(string))
      pendingAccessReviewInstances = optional(any)
      permissionGrants             = optional(any)
      postalCode                   = optional(string)
      preferredDataLocation        = optional(string)
      preferredLanguage            = optional(string)
      preferredName                = optional(string)
      presence                     = optional(any)
      print = optional(object({
        odata_type          = optional(string, "#microsoft.graph.userPrint")
        recentPrinterShares = optional(any)
      }))
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

variable "mobile_app_intent_and_states" {
  description = "The list of troubleshooting events for this user."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.mobileAppIntentAndState")
    managedDeviceIdentifier = optional(string)
    mobileAppList = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.mobileAppIntentAndStateDetail")
      applicationId        = optional(string)
      displayName          = optional(string)
      displayVersion       = optional(string)
      installState         = optional(string)
      mobileAppIntent      = optional(string)
      supportedDeviceTypes = optional(any)
    })))
    userId = optional(string)
  }))
  default = null
}

variable "mobile_app_troubleshooting_events" {
  description = "The list of mobile app troubleshooting events for this user."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")
    additionalInformation = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValuePair")
      name       = optional(string)
      value      = optional(string)
    })))
    appLogCollectionRequests = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.appLogCollectionRequest")
      completedDateTime = optional(string)
      customLogFolders  = optional(list(string))
      errorMessage      = optional(string)
      status            = optional(string)
    })))
    applicationId           = optional(string)
    correlationId           = optional(string)
    deviceId                = optional(string)
    eventDateTime           = optional(string)
    eventName               = optional(string)
    history                 = optional(any)
    managedDeviceIdentifier = optional(string)
    troubleshootingErrorDetails = optional(object({
      odata_type     = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorDetails")
      context        = optional(string)
      failure        = optional(string)
      failureDetails = optional(string)
      remediation    = optional(string)
      resources = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorResource")
        link       = optional(string)
        text       = optional(string)
      })))
    }))
    userId = optional(string)
  }))
  default = null
}

variable "mobile_phone" {
  description = "The primary cellular telephone number for the user. Read-only for users synced from the on-premises directory.  Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values) and $search. This property is subject to sensitive action restrictions; only specific privileged administrator roles can update it."
  type        = string
  default     = null
}

variable "my_site" {
  description = "The URL for the user's site. Requires $select to retrieve."
  type        = string
  default     = null
}

variable "notifications" {
  description = "Microsoft Graph notifications property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.notification")
    displayTimeToLive  = optional(number)
    expirationDateTime = optional(string)
    groupName          = optional(string)
    payload = optional(object({
      odata_type = optional(string, "#microsoft.graph.payloadTypes")
      rawContent = optional(string)
      visualContent = optional(object({
        odata_type = optional(string, "#microsoft.graph.visualProperties")
        body       = optional(string)
        title      = optional(string)
      }))
    }))
    priority       = optional(string)
    targetHostName = optional(string)
    targetPolicy = optional(object({
      odata_type    = optional(string, "#microsoft.graph.targetPolicyEndpoints")
      platformTypes = optional(list(string))
    }))
  }))
  default = null
}

variable "oauth2_permission_grants" {
  description = "Microsoft Graph oauth2PermissionGrants property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.oAuth2PermissionGrant")
    clientId    = optional(string)
    consentType = optional(string)
    expiryTime  = optional(string)
    principalId = optional(string)
    resourceId  = optional(string)
    scope       = optional(string)
    startTime   = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.user"
  nullable    = false
}

variable "office_location" {
  description = "The office location in the user's place of business. Maximum length is 128 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "on_premises_distinguished_name" {
  description = "Contains the on-premises Active Directory distinguished name or DN."
  type        = string
  default     = null
}

variable "on_premises_domain_name" {
  description = "Contains the on-premises domainFQDN, also called dnsDomainName synchronized from the on-premises directory."
  type        = string
  default     = null
}

variable "on_premises_extension_attributes" {
  description = "Contains extensionAttributes1-15 for the user. These extension attributes are also known as Exchange custom attributes 1-15. Each attribute can store up to 1024 characters. For an onPremisesSyncEnabled user, the source of authority for this set of properties is the on-premises and is read-only. For a cloud-only user (where onPremisesSyncEnabled is false), these properties can be set during the creation or update of a user object.  For a cloud-only user previously synced from on-premises Active Directory, these properties are read-only in Microsoft Graph but can be fully managed through the Exchange Admin Center or the Exchange Online V2 module in PowerShell. Supports $filter (eq, ne, not, in)."
  type = object({
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
  })
  default = null
}

variable "on_premises_immutable_id" {
  description = "This property associates an on-premises Active Directory user account to their Microsoft Entra user object. This property must be specified when creating a new user account in the Graph if you're using a federated domain for the user's userPrincipalName (UPN) property. Note: The $ and _ characters can't be used when specifying this property. Supports $filter (eq, ne, not, ge, le, in). This property is subject to sensitive action restrictions; only specific privileged administrator roles can update it."
  type        = string
  default     = null
}

variable "on_premises_provisioning_errors" {
  description = "Errors when using Microsoft synchronization product during provisioning.  Supports $filter (eq, not, ge, le)."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
    category             = optional(string)
    occurredDateTime     = optional(string)
    propertyCausingError = optional(string)
    value                = optional(string)
  }))
  default = null
}

variable "on_premises_sam_account_name" {
  description = "Contains the on-premises sAMAccountName synchronized from the on-premises directory.  Supports $filter (eq, ne, not, ge, le, in, startsWith)."
  type        = string
  default     = null
}

variable "on_premises_security_identifier" {
  description = "Contains the on-premises security identifier (SID) for the user synchronized from on-premises to the cloud. Must be in the format of SID, such as 'S-1-5-21-1180699209-877415012-3182824384-1006'. Supports $filter (eq including on null values)."
  type        = string
  default     = null
}

variable "on_premises_sync_behavior" {
  description = "Indicates the state of synchronization for a user between the cloud and on-premises Active Directory. Supports $filter only with advanced query capabilities, for example, $filter=onPremisesSyncBehavior/isCloudManaged eq true&$count=true."
  type        = any
  default     = null
}

variable "on_premises_user_principal_name" {
  description = "Contains the on-premises userPrincipalName synchronized from the on-premises directory. Supports $filter (eq, ne, not, ge, le, in, startsWith)."
  type        = string
  default     = null
}

variable "onenote" {
  description = "Microsoft Graph onenote property."
  type        = any
  default     = null
}

variable "online_meetings" {
  description = "Information about a meeting, including the URL used to join a meeting, the attendees list, and the description."
  type = list(object({
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
      odata_type      = optional(string, "#microsoft.graph.broadcastMeetingSettings")
      allowedAudience = optional(string)
      captions = optional(object({
        odata_type           = optional(string, "#microsoft.graph.broadcastMeetingCaptionSettings")
        isCaptionEnabled     = optional(bool)
        spokenLanguage       = optional(string)
        translationLanguages = optional(list(string))
      }))
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
  }))
  default = null
}

variable "other_mails" {
  description = "A list of additional email addresses for the user; for example: ['bob@contoso.com', 'Robert@fabrikam.com']. Can store up to 250 values, each with a limit of 250 characters. NOTE: This property can't contain accent characters.Supports $filter (eq, not, ge, le, in, startsWith, endsWith, /$count eq 0, /$count ne 0). This property is subject to sensitive action restrictions; only specific privileged administrator roles can update it."
  type        = list(string)
  default     = null
}

variable "password_policies" {
  description = "Specifies password policies for the user. This value is an enumeration with one possible value being DisableStrongPassword, which allows weaker passwords than the default policy to be specified. DisablePasswordExpiration can also be specified. The two may be specified together; for example: DisablePasswordExpiration, DisableStrongPassword. For more information on the default password policies, see Microsoft Entra password policies. Supports $filter (ne, not, and eq on null values)."
  type        = string
  default     = null
  sensitive   = true
}

variable "password_profile" {
  description = "Specifies the password profile for the user. The profile contains the user's password. This property is required when a user is created. The password in the profile must satisfy minimum requirements as specified by the passwordPolicies property. By default, a strong password is required. Supports $filter (eq, ne, not, in, and eq on null values).  User-PasswordProfile.ReadWrite.All is the least privileged permission to update this property.  In delegated scenarios, the User Administrator Microsoft Entra role is the least privileged admin role supported to update this property for nonadmin users. Privileged Authentication Administrator is the least privileged role that's allowed to update this property for all administrators in the tenant. In general, the signed-in user must have a higher privileged administrator role as indicated in Who can reset passwords.  In app-only scenarios, the calling app must be assigned a supported permission and at least the User Administrator Microsoft Entra role.This property is also subject to sensitive action restrictions."
  type = object({
    odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
    forceChangePasswordNextSignIn        = optional(bool)
    forceChangePasswordNextSignInWithMfa = optional(bool)
    password                             = optional(string)
  })
  default   = null
  sensitive = true
}

variable "past_projects" {
  description = "A list for users to enumerate their past projects. Requires $select to retrieve."
  type        = list(string)
  default     = null
}

variable "pending_access_review_instances" {
  description = "Navigation property to get a list of access reviews pending approval by the reviewer."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessReviewInstance")
    decisions = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")
      applyDescription = optional(string)
      decision         = optional(string)
      insights         = optional(any)
      instance         = optional(any)
      justification    = optional(string)
      permission = optional(object({
        odata_type  = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItemPermission")
        description = optional(string)
        displayName = optional(string)
        id          = optional(string)
        type        = optional(string)
      }))
    })))
    definition = optional(any)
    fallbackReviewers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
      query      = optional(string)
      queryRoot  = optional(string)
      queryType  = optional(string)
      reviewerId = optional(string)
      scopeType  = optional(string)
    })))
    reviewers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
      query      = optional(string)
      queryRoot  = optional(string)
      queryType  = optional(string)
      reviewerId = optional(string)
      scopeType  = optional(string)
    })))
    stages = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.accessReviewStage")
      decisions         = optional(any)
      fallbackReviewers = optional(any)
      reviewers         = optional(any)
    })))
  }))
  default = null
}

variable "permission_grants" {
  description = "List all resource-specific permission grants of a user."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "postal_code" {
  description = "The postal code for the user's postal address. The postal code is specific to the user's country/region. In the United States of America, this attribute contains the ZIP code. Maximum length is 40 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "preferred_data_location" {
  description = "The preferred data location for the user. For more information, see OneDrive Online Multi-Geo."
  type        = string
  default     = null
}

variable "preferred_language" {
  description = "The preferred language for the user. The preferred language format is based on RFC 4646. The name combines an ISO 639 two-letter lowercase culture code associated with the language and an ISO 3166 two-letter uppercase subculture code associated with the country or region. Example: 'en-US', or 'es-ES'. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "preferred_name" {
  description = "The preferred name for the user. Not Supported. This attribute returns an empty string.Requires $select to retrieve."
  type        = string
  default     = null
}

variable "presence" {
  description = "Microsoft Graph presence property."
  type        = any
  default     = null
}

variable "print" {
  description = "Microsoft Graph print property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.userPrint")
    recentPrinterShares = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.printerShare")
      allowAllUsers = optional(bool)
      allowedGroups = optional(list(object({
        odata_type                    = optional(string, "#microsoft.graph.group")
        acceptedSenders               = optional(any)
        accessType                    = optional(string)
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
      allowedUsers = optional(list(object({
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
        infoCatalogs                                    = optional(any)
        informationProtection                           = optional(any)
        interests                                       = optional(any)
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
        otherMails                                      = optional(any)
        passwordPolicies                                = optional(string)
        passwordProfile                                 = optional(any)
        pastProjects                                    = optional(any)
        pendingAccessReviewInstances                    = optional(any)
        permissionGrants                                = optional(any)
        postalCode                                      = optional(string)
        preferredDataLocation                           = optional(string)
        preferredLanguage                               = optional(string)
        preferredName                                   = optional(string)
        presence                                        = optional(any)
        print                                           = optional(any)
        profile                                         = optional(any)
        responsibilities                                = optional(any)
        schools                                         = optional(any)
        security                                        = optional(any)
        serviceProvisioningErrors                       = optional(any)
        settings                                        = optional(any)
        showInAddressList                               = optional(bool)
        skills                                          = optional(any)
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
      capabilities = optional(object({
        odata_type    = optional(string, "#microsoft.graph.printerCapabilities")
        bottomMargins = optional(list(number))
        collation     = optional(bool)
        colorModes    = optional(list(string))
        contentTypes  = optional(list(string))
        copiesPerJob = optional(object({
          odata_type = optional(string, "#microsoft.graph.integerRange")
          end        = optional(number)
          maximum    = optional(number)
          minimum    = optional(number)
          start      = optional(number)
        }))
        dpis                         = optional(list(number))
        duplexModes                  = optional(list(string))
        feedDirections               = optional(list(string))
        feedOrientations             = optional(list(string))
        finishings                   = optional(list(string))
        inputBins                    = optional(list(string))
        isPageRangeSupported         = optional(bool)
        leftMargins                  = optional(list(number))
        mediaColors                  = optional(list(string))
        mediaSizes                   = optional(list(string))
        mediaTypes                   = optional(list(string))
        multipageLayouts             = optional(list(string))
        orientations                 = optional(list(string))
        outputBins                   = optional(list(string))
        pagesPerSheet                = optional(list(number))
        qualities                    = optional(list(string))
        rightMargins                 = optional(list(number))
        scalings                     = optional(list(string))
        supportedColorConfigurations = optional(list(string))
        supportedCopiesPerJob = optional(object({
          odata_type = optional(string, "#microsoft.graph.integerRange")
          end        = optional(number)
          maximum    = optional(number)
          minimum    = optional(number)
          start      = optional(number)
        }))
        supportedDocumentMimeTypes    = optional(list(string))
        supportedDuplexConfigurations = optional(list(string))
        supportedFinishings           = optional(list(string))
        supportedMediaColors          = optional(list(string))
        supportedMediaSizes           = optional(list(string))
        supportedMediaTypes           = optional(list(string))
        supportedOrientations         = optional(list(string))
        supportedOutputBins           = optional(list(string))
        supportedPagesPerSheet = optional(object({
          odata_type = optional(string, "#microsoft.graph.integerRange")
          end        = optional(number)
          maximum    = optional(number)
          minimum    = optional(number)
          start      = optional(number)
        }))
        supportedPresentationDirections = optional(list(string))
        supportedPrintQualities         = optional(list(string))
        supportsFitPdfToPage            = optional(bool)
        topMargins                      = optional(list(number))
      }))
      defaults = optional(object({
        odata_type              = optional(string, "#microsoft.graph.printerDefaults")
        colorMode               = optional(string)
        contentType             = optional(string)
        copiesPerJob            = optional(number)
        documentMimeType        = optional(string)
        dpi                     = optional(number)
        duplexConfiguration     = optional(string)
        duplexMode              = optional(string)
        finishings              = optional(list(string))
        fitPdfToPage            = optional(bool)
        inputBin                = optional(string)
        mediaColor              = optional(string)
        mediaSize               = optional(string)
        mediaType               = optional(string)
        multipageLayout         = optional(string)
        orientation             = optional(string)
        outputBin               = optional(string)
        pagesPerSheet           = optional(number)
        pdfFitToPage            = optional(bool)
        presentationDirection   = optional(string)
        printColorConfiguration = optional(string)
        printQuality            = optional(string)
        quality                 = optional(string)
        scaling                 = optional(string)
      }))
      displayName     = optional(string)
      isAcceptingJobs = optional(bool)
      jobs = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.printJob")
        acknowledgedDateTime = optional(string)
        completedDateTime    = optional(string)
        configuration        = optional(any)
        createdBy            = optional(any)
        displayName          = optional(string)
        documents            = optional(any)
        errorCode            = optional(number)
        isFetchable          = optional(bool)
        redirectedFrom       = optional(string)
        redirectedTo         = optional(string)
        status               = optional(any)
        tasks                = optional(any)
      })))
      location = optional(object({
        odata_type       = optional(string, "#microsoft.graph.printerLocation")
        altitudeInMeters = optional(number)
        building         = optional(string)
        city             = optional(string)
        countryOrRegion  = optional(string)
        floor            = optional(string)
        floorDescription = optional(string)
        floorNumber      = optional(number)
        latitude         = optional(any)
        longitude        = optional(any)
        organization     = optional(list(string))
        postalCode       = optional(string)
        roomDescription  = optional(string)
        roomName         = optional(string)
        roomNumber       = optional(number)
        site             = optional(string)
        stateOrProvince  = optional(string)
        streetAddress    = optional(string)
        subdivision      = optional(list(string))
        subunit          = optional(list(string))
      }))
      manufacturer = optional(string)
      model        = optional(string)
      name         = optional(string)
      printer      = optional(any)
      status = optional(object({
        odata_type                 = optional(string, "#microsoft.graph.printerStatus")
        processingState            = optional(string)
        processingStateDescription = optional(string)
        processingStateReasons     = optional(list(string))
        state                      = optional(string)
      }))
      viewPoint = optional(object({
        odata_type       = optional(string, "#microsoft.graph.printerShareViewpoint")
        lastUsedDateTime = optional(string)
      }))
    })))
  })
  default   = null
  sensitive = true
}

variable "profile" {
  description = "Represents properties that are descriptive of a user in a tenant."
  type        = any
  default     = null
}

variable "responsibilities" {
  description = "A list for the user to enumerate their responsibilities. Requires $select to retrieve."
  type        = list(string)
  default     = null
}

variable "schools" {
  description = "A list for the user to enumerate the schools they have attended. Requires $select to retrieve."
  type        = list(string)
  default     = null
}

variable "security" {
  description = "Microsoft Graph security property."
  type        = any
  default     = null
}

variable "service_provisioning_errors" {
  description = "Errors published by a federated service describing a nontransient, service-specific error regarding the properties or link from a user object."
  type        = any
  default     = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type        = any
  default     = null
}

variable "show_in_address_list" {
  description = "Do not use in Microsoft Graph. Manage this property through the Microsoft 365 admin center instead. Represents whether the user should be included in the Outlook global address list. See Known issue."
  type        = bool
  default     = null
}

variable "skills" {
  description = "A list for the user to enumerate their skills. Requires $select to retrieve."
  type        = list(string)
  default     = null
}

variable "sponsors" {
  description = "The users and groups responsible for this guest user's privileges in the tenant and keep the guest user's information and access updated. (HTTP Methods: GET, POST, DELETE.). Supports $expand."
  type        = any
  default     = null
}

variable "state" {
  description = "The state or province in the user's address. Maximum length is 128 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "street_address" {
  description = "The street address of the user's place of business. Maximum length is 1024 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "surname" {
  description = "The user's surname (family name or last name). Maximum length is 64 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "todo" {
  description = "Represents the To Do services available to a user."
  type        = any
  default     = null
}

variable "transitive_member_of" {
  description = "The groups, including nested groups and directory roles that a user is a member of. Nullable."
  type        = any
  default     = null
}

variable "usage_location" {
  description = "A two-letter country code (ISO standard 3166). Required for users that are assigned licenses due to legal requirements to check for availability of services in countries.  Examples include: US, JP, and GB. Not nullable. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "usage_rights" {
  description = "Represents the usage rights a user has been granted."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.usageRight")
    catalogId         = optional(string)
    serviceIdentifier = optional(string)
    state             = optional(string)
  }))
  default = null
}

variable "user_principal_name" {
  description = "The user principal name (UPN) of the user. The UPN is an Internet-style sign-in name for the user based on the Internet standard RFC 822. By convention, this should map to the user's email name. The general format is alias@domain, where the domain must be present in the tenant's verified domain collection. This property is required when a user is created. The verified domains for the tenant can be accessed from the verifiedDomains property of organization.NOTE: This property can't contain accent characters. Only the following characters are allowed A - Z, a - z, 0 - 9, ' . - _ ! # ^ ~. For the complete list of allowed characters, see username policies. Supports $filter (eq, ne, not, ge, le, in, startsWith, endsWith) and $orderby. This property is subject to sensitive action restrictions; only specific privileged administrator roles can update it."
  type        = string
  default     = null
}

variable "user_type" {
  description = "A String value that can be used to classify user types in your directory. The possible values are Member and Guest. Supports $filter (eq, ne, not, in, and eq on null values). NOTE: For more information about the permissions for member and guest users, see What are the default user permissions in Microsoft Entra ID?"
  type        = string
  default     = null
}

variable "virtual_events" {
  description = "Microsoft Graph virtualEvents property."
  type        = any
  default     = null
}

variable "windows_information_protection_device_registrations" {
  description = "Zero or more WIP device registrations that belong to the user."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")
    deviceMacAddress     = optional(string)
    deviceName           = optional(string)
    deviceRegistrationId = optional(string)
    deviceType           = optional(string)
    lastCheckInDateTime  = optional(string)
    userId               = optional(string)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activities", "adhocCalls", "agreementAcceptances", "assignedPlans", "calendar", "calendarGroups", "calendarView", "calendars", "cloudPCs", "cloudPcPools", "contactFolders", "contacts", "createdDateTime", "createdObjects", "creationType", "dataSecurityAndGovernance", "directReports", "distributionLists", "drive", "drives", "employeeExperience", "events", "id", "imAddresses", "insights", "isLicenseReconciliationNeeded", "isManagementRestricted", "joinedTeams", "lastPasswordChangeDateTime", "legalAgeGroupClassification", "licenseAssignmentStates", "mailFolders", "manager", "memberOf", "messages", "onPremisesLastSyncDateTime", "onPremisesSipInfo", "onPremisesSyncEnabled", "outlook", "ownedDevices", "ownedObjects", "people", "photo", "photos", "planner", "provisionedPlans", "proxyAddresses", "refreshTokensValidFromDateTime", "registeredDevices", "scopedRoleMemberOf", "securityIdentifier", "signInActivity", "signInSessionsValidFromDateTime", "solutions", "sponsorOf", "teamwork", "transitiveReports"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
