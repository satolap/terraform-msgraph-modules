variable "display_name" {
  description = "The display name for the group. Required. Maximum length is 256 characters. Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  nullable    = false
}

variable "mail_enabled" {
  description = "Specifies whether the group is mail-enabled. Required. Returned by default. Supports $filter (eq, ne, not, and eq on null values)."
  type        = bool
  nullable    = false
}

variable "mail_nickname" {
  description = "The mail alias for the group, unique for Microsoft 365 groups in the organization. Maximum length is 64 characters. This property can contain only characters in the ASCII character set 0 - 127 except the following: @ () / [] ' ; : <> , SPACE. Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith)."
  type        = string
  nullable    = false
}

variable "security_enabled" {
  description = "Specifies whether the group is a security group. Required.Returned by default. Supports $filter (eq, ne, not, in)."
  type        = bool
  nullable    = false
}

variable "accepted_senders" {
  description = "The list of users or groups allowed to create posts or calendar events in this group. If this list is non-empty, then only users or groups listed here can post."
  type        = any
  default     = null
}

variable "app_role_assignments" {
  description = "Represents the app roles a group has been granted for an application. Supports $expand."
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

variable "assigned_labels" {
  description = "The list of sensitivity label pairs (label ID, label name) associated with a Microsoft 365 group or a cloud security group. Requires a Microsoft Entra ID P1 license. Requires $select to retrieve. This property can be specified during group creation or update. However, for cloud security groups, it's immutable once set. This property can be updated only in delegated scenarios where the caller requires both the Microsoft Graph permission and a supported administrator role. See Key differences from Microsoft 365 group labeling to learn more about managing this property for Microsoft 365 vs. cloud security groups."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.assignedLabel")
    labelId    = optional(string)
  }))
  default = null
}

variable "classification" {
  description = "Describes a classification for the group (such as low, medium or high business impact). Valid values for this property are defined by creating a ClassificationList setting value, based on the template definition.Returned by default. Supports $filter (eq, ne, not, ge, le, startsWith)."
  type        = string
  default     = null
}

variable "cloud_licensing" {
  description = "The relationships of a group to cloud licensing resources."
  type = object({
    odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")
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
  })
  default = null
}

variable "conversations" {
  description = "The group's conversations."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.conversation")
    hasAttachments        = optional(bool)
    lastDeliveredDateTime = optional(string)
    preview               = optional(string)
    topic                 = optional(string)
    uniqueSenders         = optional(list(string))
  }))
  default = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description for the group. Returned by default. Supports $filter (eq, ne, not, ge, le, startsWith) and $search."
  type        = string
  default     = null
}

variable "events" {
  description = "The group's events."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.event")
    allowNewTimeProposals = optional(bool)
    attendees = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.attendee")
      emailAddress    = optional(any)
      proposedNewTime = optional(any)
      status = optional(object({
        odata_type = optional(string, "#microsoft.graph.responseStatus")
        response   = optional(string)
        time       = optional(string)
      }))
      type = optional(string)
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
    occurrenceId          = optional(string)
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
        daysOfWeek     = optional(list(string))
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
    uid           = optional(string)
    webLink       = optional(string)
  }))
  default = null
}

variable "group_types" {
  description = "Specifies the group type and its membership. If the collection contains Unified, the group is a Microsoft 365 group; otherwise, it's either a security group or a distribution group. For details, see groups overview.If the collection includes DynamicMembership, the group has dynamic membership; otherwise, membership is static. Returned by default. Supports $filter (eq, not)."
  type        = list(string)
  default     = null
}

variable "has_members_with_license_errors" {
  description = "Indicates whether there are members in this group that have license errors from its group-based license assignment. This property is never returned on a GET operation. You can use it as a $filter argument to get groups that have members with license errors (that is, filter for this property being true).  Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "info_catalogs" {
  description = "Identifies the info segments assigned to the group. Returned by default. Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "is_assignable_to_role" {
  description = "Indicates whether this group can be assigned to a Microsoft Entra role. Optional. This property can only be set while creating the group and is immutable. If set to true, the securityEnabled property must also be set to true,  visibility must be Hidden, and the group cannot be a dynamic group (that is, groupTypes can't contain DynamicMembership). Only callers with at least the Privileged Role Administrator role can set this property. The caller must also be assigned the RoleManagement.ReadWrite.Directory permission to set this property or update the membership of such groups. For more, see Using a group to manage Microsoft Entra role assignmentsUsing this feature requires a Microsoft Entra ID P1 license. Returned by default. Supports $filter (eq, ne, not)."
  type        = bool
  default     = null
}

variable "members" {
  description = "Direct group members, who can be users, devices, other groups, or service principals. Supports the List members, Add member, and Remove member operations. Nullable. Supports $expand including nested $select. For example, /groups?$filter=startsWith(displayName,'Role')&$select=id,displayName&$expand=members($select=id,userPrincipalName,displayName)."
  type        = any
  default     = null
}

variable "membership_rule" {
  description = "The rule that determines members for this group if the group is a dynamic group (groupTypes contains DynamicMembership). For more information about the syntax of the membership rule, see Membership Rules syntax. Returned by default. Supports $filter (eq, ne, not, ge, le, startsWith)."
  type        = string
  default     = null
}

variable "membership_rule_processing_state" {
  description = "Indicates whether the dynamic membership processing is on or paused. Possible values are On or Paused. Returned by default. Supports $filter (eq, ne, not, in)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.group"
  nullable    = false
}

variable "on_premises_extension_attributes" {
  description = "Complex type containing extension attributes 1-15 for the group, synchronized from on-premises Active Directory. Returned only on $select. Supports $filter (eq, ne, not, in)."
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

variable "on_premises_provisioning_errors" {
  description = "Errors when using Microsoft synchronization product during provisioning. Returned by default. Supports $filter (eq, not)."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
    category             = optional(string)
    occurredDateTime     = optional(string)
    propertyCausingError = optional(string)
    value                = optional(string)
  }))
  default = null
}

variable "on_premises_sync_behavior" {
  description = "Indicates the state of synchronization for a group between the cloud and on-premises Active Directory. Supports $filter only with advanced query capabilities. For example, $filter=onPremisesSyncBehavior/isCloudManaged eq true&$count=true."
  type        = any
  default     = null
}

variable "onenote" {
  description = "Microsoft Graph onenote property."
  type        = any
  default     = null
}

variable "organization_id" {
  description = "Microsoft Graph organizationId property."
  type        = string
  default     = null
}

variable "owners" {
  description = "The owners of the group who can be users or service principals. Limited to 100 owners. Nullable. If this property isn't specified when creating a Microsoft 365 group the calling user (admin or non-admin) is automatically assigned as the group owner. A non-admin user can't explicitly add themselves to this collection when they're creating the group. For more information, see the related known issue. For security groups, the admin user isn't automatically added to this collection. For more information, see the related known issue. Supports $filter (/$count eq 0, /$count ne 0, /$count eq 1, /$count ne 1); Supports $expand including nested $select. For example, /groups?$filter=startsWith(displayName,'Role')&$select=id,displayName&$expand=owners($select=id,userPrincipalName,displayName)."
  type        = any
  default     = null
}

variable "permission_grants" {
  description = "The permissions granted for a group to a specific application. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "photo" {
  description = "The group's profile photo."
  type        = any
  default     = null
}

variable "preferred_data_location" {
  description = "The preferred data location for the Microsoft 365 group. By default, the group inherits the group creator's preferred data location. To set this property, the calling app must be granted the Directory.ReadWrite.All permission and the user be assigned at least one of the following Microsoft Entra roles:  User Account Administrator Directory Writer  Exchange Administrator  SharePoint Administrator  For more information about this property, see OneDrive Online Multi-Geo and Create a Microsoft 365 group with a specific PDL. Nullable. Returned by default."
  type        = string
  default     = null
}

variable "preferred_language" {
  description = "The preferred language for a Microsoft 365 group. Should follow ISO 639-1 Code; for example, en-US. Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "rejected_senders" {
  description = "The list of users or groups not allowed to create posts or calendar events in this group. Nullable"
  type        = any
  default     = null
}

variable "resource_behavior_options" {
  description = "Specifies the group behaviors that can be set for a Microsoft 365 group during creation. This property can be set only as part of creation (POST). For the list of possible values, see Microsoft 365 group behaviors and provisioning options."
  type        = list(string)
  default     = null
}

variable "resource_provisioning_options" {
  description = "Specifies the group resources that are associated with the Microsoft 365 group. The possible value is Team. For more information, see Microsoft 365 group behaviors and provisioning options. Returned by default. Supports $filter (eq, not, startsWith)."
  type        = list(string)
  default     = null
}

variable "service_provisioning_errors" {
  description = "Errors published by a federated service describing a non-transient, service-specific error regarding the properties or link from a group object."
  type        = any
  default     = null
}

variable "settings" {
  description = "Settings that can govern this group's behavior, like whether members can invite guest users to the group. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.directorySetting")
    values = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.settingValue")
      name       = optional(string)
      value      = optional(string)
    })))
  }))
  default = null
}

variable "sites" {
  description = "The list of SharePoint sites in this group. Access the default site with /sites/root."
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

variable "team" {
  description = "The team associated with this group."
  type        = any
  default     = null
}

variable "theme" {
  description = "Specifies a Microsoft 365 group's color theme. Possible values are Teal, Purple, Green, Blue, Pink, Orange or Red. Returned by default."
  type        = string
  default     = null
}

variable "threads" {
  description = "The group's conversation threads. Nullable."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.conversationThread")
    ccRecipients          = optional(any)
    hasAttachments        = optional(bool)
    isLocked              = optional(bool)
    lastDeliveredDateTime = optional(string)
    posts = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.post")
      body = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      categories           = optional(list(string))
      createdDateTime      = optional(string)
      from                 = optional(any)
      hasAttachments       = optional(bool)
      importance           = optional(string)
      lastModifiedDateTime = optional(string)
      mentions             = optional(any)
      newParticipants      = optional(any)
      receivedDateTime     = optional(string)
      sender               = optional(any)
    })))
    preview       = optional(string)
    toRecipients  = optional(any)
    topic         = optional(string)
    uniqueSenders = optional(list(string))
  }))
  default = null
}

variable "transitive_member_of" {
  description = "The groups a group is a member of, either directly or through nested membership. Nullable."
  type        = any
  default     = null
}

variable "transitive_members" {
  description = "The direct and transitive members of a group. Nullable."
  type        = any
  default     = null
}

variable "visibility" {
  description = "Specifies the group join policy and group content visibility for groups. The possible values are: Private, Public, or HiddenMembership. HiddenMembership can be set only for Microsoft 365 groups when the groups are created. It can't be updated later. Other values of visibility can be updated after group creation. If visibility value isn't specified during group creation on Microsoft Graph, a security group is created as Private by default, and Microsoft 365 group is Public. Groups assignable to roles are always Private. To learn more, see group visibility options. Returned by default. Nullable."
  type        = string
  default     = null
}

variable "welcome_message_enabled" {
  description = "Indicates whether a welcome message is sent to new members when they are added to the group. The default value is true. Requires $select to retrieve. Supported only on the Get group API (GET /groups/{ID})."
  type        = bool
  default     = null
}

variable "writeback_configuration" {
  description = "Specifies whether or not a group is configured to write back group object properties to on-premises Active Directory. These properties are used when group writeback is configured in the Microsoft Entra Connect sync client."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.groupWritebackConfiguration")
    isEnabled           = optional(bool)
    onPremisesGroupType = optional(string)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessType", "allowExternalSenders", "assignedLicenses", "autoSubscribeNewMembers", "calendar", "calendarView", "createdByAppId", "createdDateTime", "createdOnBehalfOf", "drive", "drives", "endpoints", "expirationDateTime", "extensions", "groupLifecyclePolicies", "hideFromAddressLists", "hideFromOutlookClients", "id", "isArchived", "isFavorite", "isManagementRestricted", "isSubscribedByMail", "licenseProcessingState", "mail", "memberOf", "membersWithLicenseErrors", "membershipRuleProcessingStatus", "onPremisesDomainName", "onPremisesLastSyncDateTime", "onPremisesNetBiosName", "onPremisesSamAccountName", "onPremisesSecurityIdentifier", "onPremisesSyncEnabled", "photos", "planner", "proxyAddresses", "renewedDateTime", "securityIdentifier", "uniqueName", "unseenConversationsCount", "unseenCount", "unseenMessagesCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
