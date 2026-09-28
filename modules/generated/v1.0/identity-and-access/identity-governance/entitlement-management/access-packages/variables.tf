variable "description" {
  description = "The description of the access package."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Required. The display name of the access package. Supports $filter (eq, contains)."
  type        = string
  default     = null
}

variable "incompatible_access_packages" {
  description = "The access packages whose assigned users are ineligible to be assigned this access package."
  type = list(object({
    odata_type                 = optional(string, "#microsoft.graph.accessPackage")
    description                = optional(string)
    displayName                = optional(string)
    incompatibleAccessPackages = optional(any)
    incompatibleGroups = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.group")
      acceptedSenders               = optional(any)
      accessType                    = optional(string)
      allowExternalSenders          = optional(bool)
      appRoleAssignments            = optional(any)
      assignedLabels                = optional(any)
      autoSubscribeNewMembers       = optional(bool)
      classification                = optional(string)
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
      planner                      = optional(any)
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
    })))
    isHidden = optional(bool)
    resourceRoleScopes = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")
      createdDateTime = optional(string)
      role            = optional(any)
      scope           = optional(any)
    })))
  }))
  default = null
}

variable "incompatible_groups" {
  description = "The groups whose members are ineligible to be assigned this access package."
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
      values      = optional(any)
    })))
    sites = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.site")
      analytics    = optional(any)
      columns      = optional(any)
      contentTypes = optional(any)
      description  = optional(string)
      drive        = optional(any)
      drives       = optional(any)
      error = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicError")
        code       = optional(string)
        details    = optional(any)
        innerError = optional(any)
        message    = optional(string)
        target     = optional(string)
      }))
      externalColumns = optional(any)
      items           = optional(any)
      lists           = optional(any)
      name            = optional(string)
      onenote         = optional(any)
      operations      = optional(any)
      pages           = optional(any)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      permissions = optional(any)
      sites       = optional(any)
      termStore   = optional(any)
      termStores  = optional(any)
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
  }))
  default = null
}

variable "is_hidden" {
  description = "Indicates whether the access package is hidden from the requestor."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackage"
  nullable    = false
}

variable "resource_role_scopes" {
  description = "The resource roles and scopes in this access package."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")
    createdDateTime = optional(string)
    role            = optional(any)
    scope           = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackagesIncompatibleWith", "assignmentPolicies", "catalog", "createdDateTime", "id", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
