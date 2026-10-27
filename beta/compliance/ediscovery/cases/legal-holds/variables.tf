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
    holdStatus      = optional(string)
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
        modelType  = optional(string)
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
        parentReference    = optional(any)
        sharePointIds      = optional(any)
      })))
      extensions = optional(any)
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
        list               = optional(any)
        name               = optional(string)
        operations         = optional(any)
        parentReference    = optional(any)
        subscriptions      = optional(any)
      })))
      locale    = optional(string)
      lockState = optional(string)
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
        parentReference    = optional(any)
        publishingState    = optional(any)
        title              = optional(string)
        titleArea          = optional(any)
        webParts           = optional(any)
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
  }))
  default = null

  validation {
    condition     = (var.site_sources == null ? true : alltrue([alltrue([for input0 in var.site_sources : (input0 == null ? true : alltrue([(input0["holdStatus"] == null ? true : alltrue([(input0["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input0["holdStatus"]))])), (input0["site"] == null ? true : alltrue([(input0["site"]["contentModels"] == null ? true : alltrue([alltrue([for input3 in input0["site"]["contentModels"] : (input3 == null ? true : alltrue([(input3["modelType"] == null ? true : alltrue([(input3["modelType"] == null ? true : contains(["teachingMethod", "layoutMethod", "freeformSelectionMethod", "prebuiltContractModel", "prebuiltInvoiceModel", "prebuiltReceiptModel"], input3["modelType"]))]))]))])])), (input0["site"]["documentProcessingJobs"] == null ? true : alltrue([alltrue([for input3 in input0["site"]["documentProcessingJobs"] : (input3 == null ? true : alltrue([(input3["jobType"] == null ? true : alltrue([(input3["jobType"] == null ? true : contains(["file", "folder"], input3["jobType"]))])), (input3["status"] == null ? true : alltrue([(input3["status"] == null ? true : contains(["inProgress", "completed", "failed"], input3["status"]))]))]))])])), (input0["site"]["lockState"] == null ? true : alltrue([(input0["site"]["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input0["site"]["lockState"]))])), (input0["site"]["operations"] == null ? true : alltrue([alltrue([for input3 in input0["site"]["operations"] : (input3 == null ? true : alltrue([(input3["status"] == null ? true : alltrue([(input3["status"] == null ? true : contains(["notStarted", "running", "succeeded", "failed"], input3["status"]))]))]))])])), (input0["site"]["pageTemplates"] == null ? true : alltrue([alltrue([for input3 in input0["site"]["pageTemplates"] : (input3 == null ? true : alltrue([(input3["pageLayout"] == null ? true : alltrue([(input3["pageLayout"] == null ? true : contains(["microsoftReserved", "article", "home"], input3["pageLayout"]))]))]))])])), (input0["site"]["template"] == null ? true : alltrue([(input0["site"]["template"] == null ? true : contains(["sitepagepublishing", "sts"], input0["site"]["template"]))]))]))]))])]))
    error_message = "site_sources: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "status" {
  description = "The status of the legal hold. The possible values are: Pending, Error, Success, UnknownFutureValue."
  type        = string
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
        odata_type  = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")
        assignments = optional(any)
        usageRights = optional(any)
      }))
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
        importance                 = optional(string)
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
        onlineMeetingProvider      = optional(string)
        organizer                  = optional(any)
        originalEndTimeZone        = optional(string)
        originalStart              = optional(string)
        originalStartTimeZone      = optional(string)
        recurrence                 = optional(any)
        reminderMinutesBeforeStart = optional(number)
        responseRequested          = optional(bool)
        responseStatus             = optional(any)
        sensitivity                = optional(string)
        seriesMasterId             = optional(string)
        showAs                     = optional(string)
        start                      = optional(any)
        subject                    = optional(string)
        transactionId              = optional(string)
        uid                        = optional(string)
        webLink                    = optional(string)
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
        lockState              = optional(string)
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
        template               = optional(string)
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
    holdStatus      = optional(string)
    includedSources = optional(string)
  }))
  default = null

  validation {
    condition     = (var.unified_group_sources == null ? true : alltrue([alltrue([for input0 in var.unified_group_sources : (input0 == null ? true : alltrue([(input0["group"] == null ? true : alltrue([(input0["group"]["accessType"] == null ? true : alltrue([(input0["group"]["accessType"] == null ? true : contains(["none", "private", "secret", "public"], input0["group"]["accessType"]))])), (input0["group"]["events"] == null ? true : alltrue([alltrue([for input3 in input0["group"]["events"] : (input3 == null ? true : alltrue([(input3["importance"] == null ? true : alltrue([(input3["importance"] == null ? true : contains(["low", "normal", "high"], input3["importance"]))])), (input3["onlineMeetingProvider"] == null ? true : alltrue([(input3["onlineMeetingProvider"] == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], input3["onlineMeetingProvider"]))])), (input3["sensitivity"] == null ? true : alltrue([(input3["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input3["sensitivity"]))])), (input3["showAs"] == null ? true : alltrue([(input3["showAs"] == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], input3["showAs"]))]))]))])])), (input0["group"]["sites"] == null ? true : alltrue([alltrue([for input3 in input0["group"]["sites"] : (input3 == null ? true : alltrue([(input3["lockState"] == null ? true : alltrue([(input3["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input3["lockState"]))])), (input3["template"] == null ? true : alltrue([(input3["template"] == null ? true : contains(["sitepagepublishing", "sts"], input3["template"]))]))]))])]))])), (input0["holdStatus"] == null ? true : alltrue([(input0["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input0["holdStatus"]))])), (input0["includedSources"] == null ? true : alltrue([(input0["includedSources"] == null ? true : try(alltrue([for value in split(",", input0["includedSources"]) : contains(["mailbox", "site"], lower(trimspace(value)))]), false))]))]))])]))
    error_message = "unified_group_sources: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "user_sources" {
  description = "Data source entity for a the legal hold. This is the container for a mailbox and OneDrive for Business site."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ediscovery.userSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    email           = optional(string)
    holdStatus      = optional(string)
    includedSources = optional(string)
  }))
  default = null

  validation {
    condition     = (var.user_sources == null ? true : alltrue([alltrue([for input0 in var.user_sources : (input0 == null ? true : alltrue([(input0["holdStatus"] == null ? true : alltrue([(input0["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input0["holdStatus"]))])), (input0["includedSources"] == null ? true : alltrue([(input0["includedSources"] == null ? true : try(alltrue([for value in split(",", input0["includedSources"]) : contains(["mailbox", "site"], lower(trimspace(value)))]), false))]))]))])]))
    error_message = "user_sources: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
