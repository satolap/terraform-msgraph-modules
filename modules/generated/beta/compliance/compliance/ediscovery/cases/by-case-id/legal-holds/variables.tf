variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "content_query" {
  description = "KQL query that specifies content to be held in the specified locations. To learn more, see Keyword queries and search conditions for Content Search and eDiscovery.  To hold all content in the specified locations, leave contentQuery blank."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The user who created the legal hold."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time the legal hold was created."
  type        = string
  default     = null
}

variable "description" {
  description = "The legal hold description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the legal hold."
  type        = string
  default     = null
}

variable "errors" {
  description = "Lists any errors that happened while placing the hold."
  type        = list(string)
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the hold is enabled and actively holding content."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "the user who last modified the legal hold."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the legal hold was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.legalHold"
  nullable    = false
}

variable "site_sources" {
  description = "Data source entity for SharePoint sites associated with the legal hold."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ediscovery.siteSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    holdStatus      = optional(any)
    site = optional(object({
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
    }))
  }))
  default = null
}

variable "status" {
  description = "The status of the legal hold. The possible values are: Pending, Error, Success, UnknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["Pending", "Error", "Success", "UnknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "unified_group_sources" {
  description = "Microsoft Graph unifiedGroupSources property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ediscovery.unifiedGroupSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    group = optional(object({
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
        uniqueSenders         = optional(any)
      })))
      deletedDateTime = optional(string)
      description     = optional(string)
      displayName     = optional(string)
      events = optional(list(object({
        odata_type                 = optional(string, "#microsoft.graph.event")
        allowNewTimeProposals      = optional(bool)
        attendees                  = optional(any)
        body                       = optional(any)
        bodyPreview                = optional(string)
        cancelledOccurrences       = optional(any)
        categories                 = optional(any)
        createdDateTime            = optional(string)
        end                        = optional(any)
        exceptionOccurrences       = optional(any)
        extensions                 = optional(any)
        hasAttachments             = optional(bool)
        hideAttendees              = optional(bool)
        importance                 = optional(any)
        isAllDay                   = optional(bool)
        isCancelled                = optional(bool)
        isDraft                    = optional(bool)
        isOnlineMeeting            = optional(bool)
        isOrganizer                = optional(bool)
        isReminderOn               = optional(bool)
        lastModifiedDateTime       = optional(string)
        location                   = optional(any)
        locations                  = optional(any)
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
        values     = optional(any)
      })))
      sites = optional(list(object({
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
        uniqueSenders         = optional(any)
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
    }))
    holdStatus      = optional(any)
    includedSources = optional(any)
  }))
  default = null
}

variable "user_sources" {
  description = "Data source entity for a the legal hold. This is the container for a mailbox and OneDrive for Business site."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ediscovery.userSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    email           = optional(string)
    holdStatus      = optional(any)
    includedSources = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
