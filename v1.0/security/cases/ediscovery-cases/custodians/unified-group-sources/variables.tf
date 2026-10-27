variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "ediscovery_custodian_id" {
  description = "The unique identifier of ediscoveryCustodian"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_custodian_id)) > 0
    error_message = "ediscovery_custodian_id must not be empty."
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
  description = "The display name of the dataSource and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "group" {
  description = "Microsoft Graph group property."
  type = object({
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
        type            = optional(string)
      })))
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
      onlineMeetingProvider = optional(string)
      organizer             = optional(any)
      originalEndTimeZone   = optional(string)
      originalStart         = optional(string)
      originalStartTimeZone = optional(string)
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
    planner                     = optional(any)
    preferredDataLocation       = optional(string)
    preferredLanguage           = optional(string)
    rejectedSenders             = optional(any)
    resourceBehaviorOptions     = optional(list(string))
    resourceProvisioningOptions = optional(list(string))
    securityEnabled             = optional(bool)
    serviceProvisioningErrors   = optional(any)
    settings = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.groupSetting")
      displayName = optional(string)
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
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        term                  = optional(any)
        text                  = optional(any)
        thumbnail             = optional(any)
        validation            = optional(any)
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
      description = optional(string)
      drive       = optional(any)
      drives = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.drive")
        bundles         = optional(any)
        description     = optional(string)
        following       = optional(any)
        name            = optional(string)
        parentReference = optional(any)
        sharePointIds   = optional(any)
      })))
      error = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicError")
        code       = optional(string)
        details    = optional(any)
        innerError = optional(object({
          odata_type = optional(string, "#microsoft.graph.publicInnerError")
          code       = optional(string)
          details    = optional(any)
          message    = optional(string)
          target     = optional(string)
        }))
        message = optional(string)
        target  = optional(string)
      }))
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
        lookup                = optional(any)
        name                  = optional(string)
        number                = optional(any)
        personOrGroup         = optional(any)
        propagateChanges      = optional(bool)
        readOnly              = optional(bool)
        required              = optional(bool)
        sourceColumn          = optional(any)
        term                  = optional(any)
        text                  = optional(any)
        thumbnail             = optional(any)
        validation            = optional(any)
      })))
      items = optional(any)
      lists = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.list")
        columns         = optional(any)
        contentTypes    = optional(any)
        description     = optional(string)
        displayName     = optional(string)
        drive           = optional(any)
        items           = optional(any)
        list            = optional(any)
        name            = optional(string)
        operations      = optional(any)
        parentReference = optional(any)
        subscriptions   = optional(any)
      })))
      name    = optional(string)
      onenote = optional(any)
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
      sites     = optional(any)
      termStore = optional(any)
      termStores = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.termStore.store")
        defaultLanguageTag = optional(string)
        groups             = optional(any)
        languageTags       = optional(any)
        sets               = optional(any)
      })))
    })))
    team  = optional(any)
    theme = optional(string)
    threads = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.conversationThread")
      ccRecipients          = optional(any)
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
        lastModifiedDateTime = optional(string)
        newParticipants      = optional(any)
        receivedDateTime     = optional(string)
        sender               = optional(any)
      })))
      preview       = optional(string)
      toRecipients  = optional(any)
      topic         = optional(string)
      uniqueSenders = optional(list(string))
    })))
    transitiveMemberOf       = optional(any)
    transitiveMembers        = optional(any)
    unseenConversationsCount = optional(number)
    unseenCount              = optional(number)
    unseenMessagesCount      = optional(number)
    visibility               = optional(string)
    welcomeMessageEnabled    = optional(bool)
  })
  default = null

  validation {
    condition     = (var.group == null ? true : alltrue([(var.group["accessType"] == null ? true : alltrue([(var.group["accessType"] == null ? true : contains(["none", "private", "secret", "public"], var.group["accessType"]))])), (var.group["events"] == null ? true : alltrue([alltrue([for input1 in var.group["events"] : (input1 == null ? true : alltrue([(input1["attendees"] == null ? true : alltrue([alltrue([for input3 in input1["attendees"] : (input3 == null ? true : alltrue([(input3["type"] == null ? true : alltrue([(input3["type"] == null ? true : contains(["required", "optional", "resource"], input3["type"]))]))]))])])), (input1["body"] == null ? true : alltrue([(input1["body"]["contentType"] == null ? true : alltrue([(input1["body"]["contentType"] == null ? true : contains(["text", "html"], input1["body"]["contentType"]))]))])), (input1["importance"] == null ? true : alltrue([(input1["importance"] == null ? true : contains(["low", "normal", "high"], input1["importance"]))])), (input1["onlineMeetingProvider"] == null ? true : alltrue([(input1["onlineMeetingProvider"] == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], input1["onlineMeetingProvider"]))])), (input1["recurrence"] == null ? true : alltrue([(input1["recurrence"]["pattern"] == null ? true : alltrue([(input1["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(input1["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input1["recurrence"]["pattern"]["firstDayOfWeek"]))])), (input1["recurrence"]["pattern"]["index"] == null ? true : alltrue([(input1["recurrence"]["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], input1["recurrence"]["pattern"]["index"]))])), (input1["recurrence"]["pattern"]["type"] == null ? true : alltrue([(input1["recurrence"]["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], input1["recurrence"]["pattern"]["type"]))]))])), (input1["recurrence"]["range"] == null ? true : alltrue([(input1["recurrence"]["range"]["type"] == null ? true : alltrue([(input1["recurrence"]["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], input1["recurrence"]["range"]["type"]))]))]))])), (input1["responseStatus"] == null ? true : alltrue([(input1["responseStatus"]["response"] == null ? true : alltrue([(input1["responseStatus"]["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], input1["responseStatus"]["response"]))]))])), (input1["sensitivity"] == null ? true : alltrue([(input1["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input1["sensitivity"]))])), (input1["showAs"] == null ? true : alltrue([(input1["showAs"] == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], input1["showAs"]))]))]))])])), (var.group["sites"] == null ? true : alltrue([alltrue([for input1 in var.group["sites"] : (input1 == null ? true : alltrue([(input1["operations"] == null ? true : alltrue([alltrue([for input3 in input1["operations"] : (input3 == null ? true : alltrue([(input3["status"] == null ? true : alltrue([(input3["status"] == null ? true : contains(["notStarted", "running", "succeeded", "failed"], input3["status"]))]))]))])]))]))])]))]))
    error_message = "group: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "hold_status" {
  description = "The hold status of the dataSource. The possible values are: notApplied, applied, applying, removing, partial."
  type        = string
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
  }
}

variable "included_sources" {
  description = "Specifies which sources are included in this group. The possible values are: mailbox, site."
  type        = string
  default     = null

  validation {
    condition     = var.included_sources == null ? true : try(alltrue([for value in split(",", var.included_sources) : contains(["mailbox", "site"], lower(trimspace(value)))]), false)
    error_message = "included_sources must be one or more of the documented enum values, separated by commas."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.unifiedGroupSource"
  nullable    = false
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
