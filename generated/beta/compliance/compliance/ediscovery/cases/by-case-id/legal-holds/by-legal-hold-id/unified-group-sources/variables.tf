variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "legal_hold_id" {
  description = "The unique identifier of legalHold"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.legal_hold_id)) > 0
    error_message = "legal_hold_id must not be empty."
  }
}

variable "created_by" {
  description = "The user who created the dataSource."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time the dataSource was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the dataSource, and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "group" {
  description = "Microsoft Graph group property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.group")
    acceptedSenders = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    accessType           = optional(any)
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
    cloudLicensing          = optional(any)
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
      attendees = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.attendee")
        emailAddress    = optional(any)
        proposedNewTime = optional(any)
        status          = optional(any)
        type            = optional(any)
      })))
      body                 = optional(any)
      bodyPreview          = optional(string)
      cancelledOccurrences = optional(list(string))
      categories           = optional(list(string))
      createdDateTime      = optional(string)
      end                  = optional(any)
      exceptionOccurrences = optional(any)
      extensions = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.extension")
      })))
      hasAttachments       = optional(bool)
      hideAttendees        = optional(bool)
      importance           = optional(any)
      isAllDay             = optional(bool)
      isCancelled          = optional(bool)
      isDraft              = optional(bool)
      isOnlineMeeting      = optional(bool)
      isOrganizer          = optional(bool)
      isReminderOn         = optional(bool)
      lastModifiedDateTime = optional(string)
      location             = optional(any)
      locations = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.location")
        address              = optional(any)
        coordinates          = optional(any)
        displayName          = optional(string)
        locationEmailAddress = optional(string)
        locationUri          = optional(string)
        uniqueId             = optional(string)
        uniqueIdType         = optional(any)
      })))
      occurrenceId               = optional(string)
      onlineMeetingProvider      = optional(any)
      organizer                  = optional(any)
      originalEndTimeZone        = optional(string)
      originalStart              = optional(string)
      originalStartTimeZone      = optional(string)
      recurrence                 = optional(any)
      reminderMinutesBeforeStart = optional(number)
      responseRequested          = optional(bool)
      responseStatus             = optional(any)
      sensitivity                = optional(any)
      seriesMasterId             = optional(string)
      showAs                     = optional(any)
      start                      = optional(any)
      subject                    = optional(string)
      transactionId              = optional(string)
      uid                        = optional(string)
      webLink                    = optional(string)
    })))
    groupTypes                  = optional(list(string))
    hasMembersWithLicenseErrors = optional(bool)
    hideFromAddressLists        = optional(bool)
    hideFromOutlookClients      = optional(bool)
    infoCatalogs                = optional(list(string))
    isAssignableToRole          = optional(bool)
    isFavorite                  = optional(bool)
    isSubscribedByMail          = optional(bool)
    mailEnabled                 = optional(bool)
    mailNickname                = optional(string)
    members = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    membershipRule                = optional(string)
    membershipRuleProcessingState = optional(string)
    onPremisesExtensionAttributes = optional(any)
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
    owners = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    photo                 = optional(any)
    preferredDataLocation = optional(string)
    preferredLanguage     = optional(string)
    rejectedSenders = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    resourceBehaviorOptions     = optional(list(string))
    resourceProvisioningOptions = optional(list(string))
    securityEnabled             = optional(bool)
    serviceProvisioningErrors = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.serviceProvisioningError")
      createdDateTime = optional(string)
      isResolved      = optional(bool)
      serviceInstance = optional(string)
    })))
    settings = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.directorySetting")
      values = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.settingValue")
        name       = optional(string)
        value      = optional(string)
      })))
    })))
    sites = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.site")
      analytics  = optional(any)
      columns = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.columnDefinition")
        boolean               = optional(any)
        calculated            = optional(any)
        choice                = optional(any)
        columnGroup           = optional(string)
        contentApprovalStatus = optional(any)
        currency              = optional(any)
        dateTime              = optional(any)
        defaultValue          = optional(any)
        description           = optional(string)
        displayName           = optional(string)
        enforceUniqueValues   = optional(bool)
        geolocation           = optional(any)
        hidden                = optional(bool)
        hyperlinkOrPicture    = optional(any)
        indexed               = optional(bool)
        isDeletable           = optional(bool)
        isSealed              = optional(bool)
        isSearchable          = optional(bool)
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        sourceContentType     = optional(any)
        term                  = optional(any)
        text                  = optional(any)
        thumbnail             = optional(any)
        validation            = optional(any)
      })))
      contentModels = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.contentModel")
        modelType  = optional(any)
        name       = optional(string)
      })))
      contentTypes = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.contentType")
        associatedHubsUrls = optional(any)
        base               = optional(any)
        baseTypes          = optional(any)
        columnLinks        = optional(any)
        columnPositions    = optional(any)
        columns            = optional(any)
        description        = optional(string)
        documentSet        = optional(any)
        documentTemplate   = optional(any)
        group              = optional(string)
        hidden             = optional(bool)
        inheritedFrom      = optional(any)
        isBuiltIn          = optional(bool)
        name               = optional(string)
        order              = optional(any)
        parentId           = optional(string)
        propagateChanges   = optional(bool)
        readOnly           = optional(bool)
        sealed             = optional(bool)
      })))
      createdByUser = optional(any)
      deleted       = optional(any)
      description   = optional(string)
      documentProcessingJobs = optional(list(object({
        odata_type       = optional(string, "#microsoft.graph.documentProcessingJob")
        jobType          = optional(any)
        listItemUniqueId = optional(string)
        status           = optional(any)
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
        parentReference    = optional(any)
        sharePointIds      = optional(any)
      })))
      extensions = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.extension")
      })))
      externalColumns = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.columnDefinition")
        boolean               = optional(any)
        calculated            = optional(any)
        choice                = optional(any)
        columnGroup           = optional(string)
        contentApprovalStatus = optional(any)
        currency              = optional(any)
        dateTime              = optional(any)
        defaultValue          = optional(any)
        description           = optional(string)
        displayName           = optional(string)
        enforceUniqueValues   = optional(bool)
        geolocation           = optional(any)
        hidden                = optional(bool)
        hyperlinkOrPicture    = optional(any)
        indexed               = optional(bool)
        isDeletable           = optional(bool)
        isSealed              = optional(bool)
        isSearchable          = optional(bool)
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        sourceContentType     = optional(any)
        term                  = optional(any)
        text                  = optional(any)
        thumbnail             = optional(any)
        validation            = optional(any)
      })))
      informationProtection = optional(any)
      isPersonalSite        = optional(bool)
      items = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.baseItem")
        createdByUser      = optional(any)
        description        = optional(string)
        lastModifiedByUser = optional(any)
        name               = optional(string)
        parentReference    = optional(any)
      })))
      lastModifiedByUser = optional(any)
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
        list               = optional(any)
        name               = optional(string)
        operations         = optional(any)
        parentReference    = optional(any)
        subscriptions      = optional(any)
      })))
      locale    = optional(string)
      lockState = optional(any)
      name      = optional(string)
      onenote   = optional(any)
      operations = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.richLongRunningOperation")
        createdDateTime    = optional(string)
        error              = optional(any)
        lastActionDateTime = optional(string)
        percentageComplete = optional(number)
        resourceId         = optional(string)
        resourceLocation   = optional(string)
        status             = optional(any)
        statusDetail       = optional(string)
        type               = optional(string)
      })))
      ownerIdentityToResolve = optional(any)
      pageTemplates = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.pageTemplate")
        canvasLayout       = optional(any)
        createdByUser      = optional(any)
        description        = optional(string)
        lastModifiedByUser = optional(any)
        name               = optional(string)
        pageLayout         = optional(any)
        parentReference    = optional(any)
        publishingState    = optional(any)
        title              = optional(string)
        titleArea          = optional(any)
        webParts           = optional(any)
      })))
      pages = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.baseSitePage")
        createdByUser      = optional(any)
        description        = optional(string)
        lastModifiedByUser = optional(any)
        name               = optional(string)
        pageLayout         = optional(any)
        parentReference    = optional(any)
        publishingState    = optional(any)
        title              = optional(string)
      })))
      parentReference = optional(any)
      permissions = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.permission")
        expirationDateTime = optional(string)
      })))
      recycleBin          = optional(any)
      shareByEmailEnabled = optional(bool)
      sites               = optional(any)
      template            = optional(any)
      termStore           = optional(any)
    })))
    team  = optional(any)
    theme = optional(string)
    threads = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.conversationThread")
      ccRecipients = optional(list(object({
        odata_type   = optional(string, "#microsoft.graph.recipient")
        emailAddress = optional(any)
      })))
      hasAttachments        = optional(bool)
      isLocked              = optional(bool)
      lastDeliveredDateTime = optional(string)
      posts = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.post")
        body                 = optional(any)
        categories           = optional(any)
        createdDateTime      = optional(string)
        from                 = optional(any)
        hasAttachments       = optional(bool)
        importance           = optional(any)
        lastModifiedDateTime = optional(string)
        mentions             = optional(any)
        newParticipants      = optional(any)
        receivedDateTime     = optional(string)
        sender               = optional(any)
      })))
      preview = optional(string)
      toRecipients = optional(list(object({
        odata_type   = optional(string, "#microsoft.graph.recipient")
        emailAddress = optional(any)
      })))
      topic         = optional(string)
      uniqueSenders = optional(list(string))
    })))
    transitiveMemberOf = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    transitiveMembers = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    unseenConversationsCount = optional(number)
    unseenCount              = optional(number)
    unseenMessagesCount      = optional(number)
    visibility               = optional(string)
    welcomeMessageEnabled    = optional(bool)
    writebackConfiguration   = optional(any)
  })
  default = null
}

variable "hold_status" {
  description = "Microsoft Graph holdStatus property."
  type        = any
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial", "unknownFutureValue"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
  }
}

variable "included_sources" {
  description = "Specifies which sources are included in this group. The possible values are: mailbox, site."
  type        = any
  default     = null

  validation {
    condition     = var.included_sources == null ? true : contains(["mailbox", "site"], var.included_sources)
    error_message = "included_sources must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.unifiedGroupSource"
  nullable    = false
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
