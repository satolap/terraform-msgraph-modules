variable "applies_to" {
  description = "Indicates the user scope of the mobility management policy. The possible values are: none, all, selected."
  type        = string
  default     = null

  validation {
    condition     = var.applies_to == null ? true : contains(["none", "all", "selected", "unknownFutureValue"], var.applies_to)
    error_message = "applies_to must be one of the documented enum values."
  }
}

variable "compliance_url" {
  description = "Compliance URL of the mobility management application."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the mobility management application."
  type        = string
  default     = null
}

variable "discovery_url" {
  description = "Discovery URL of the mobility management application."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the mobility management application."
  type        = string
  default     = null
}

variable "included_groups" {
  description = "Microsoft Entra groups under the scope of the mobility management application if appliesTo is selected"
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

variable "is_mdm_enrollment_during_registration_disabled" {
  description = "Controls the option if users in an automatic enrollment configuration on Microsoft Entra registered devices are prompted to MDM enroll their device in the Entra account registration flow."
  type        = bool
  default     = null
}

variable "is_valid" {
  description = "Whether policy is valid. Invalid policies may not be updated and should be deleted."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileDeviceManagementPolicy"
  nullable    = false
}

variable "terms_of_use_url" {
  description = "Terms of Use URL of the mobility management application."
  type        = string
  default     = null
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
