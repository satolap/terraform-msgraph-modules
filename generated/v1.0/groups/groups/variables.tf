variable "display_name" {
  description = "The display name for the group. This property is required when a group is created and can't be cleared during updates. Maximum length is 256 characters. Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  nullable    = false
}

variable "mail_enabled" {
  description = "Specifies whether the group is mail-enabled. Required. Returned by default. Supports $filter (eq, ne, not)."
  type        = bool
  nullable    = false
}

variable "mail_nickname" {
  description = "The mail alias for the group, unique for Microsoft 365 groups in the organization. Maximum length is 64 characters. This property can contain only characters in the ASCII character set 0 - 127 except the following characters: @ () / [] ' ; : <> , SPACE. Required. Returned by default. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values)."
  type        = string
  nullable    = false
}

variable "security_enabled" {
  description = "Specifies whether the group is a security group. Required. Returned by default. Supports $filter (eq, ne, not, in)."
  type        = bool
  nullable    = false
}

variable "accepted_senders" {
  description = "The list of users or groups allowed to create posts or calendar events in this group. If this list is nonempty, then only users or groups listed here are allowed to post."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "app_role_assignments" {
  description = "Represents the app roles granted to a group for an application. Supports $expand."
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
  description = "Describes a classification for the group (such as low, medium, or high business impact). Valid values for this property are defined by creating a ClassificationList setting value, based on the template definition.Returned by default. Supports $filter (eq, ne, not, ge, le, startsWith)."
  type        = string
  default     = null
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
  description = "The group's calendar events."
  type = list(object({
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
    webLink                    = optional(string)
  }))
  default = null
}

variable "group_types" {
  description = "Specifies the group type and its membership. If the collection contains Unified, the group is a Microsoft 365 group; otherwise, it's either a security group or a distribution group. For details, see groups overview.If the collection includes DynamicMembership, the group has dynamic membership; otherwise, membership is static. Returned by default. Supports $filter (eq, not)."
  type        = list(string)
  default     = null
}

variable "has_members_with_license_errors" {
  description = "Indicates whether there are members in this group that have license errors from its group-based license assignment. This property is never returned on a GET operation. You can use it as a $filter argument to get groups that have members with license errors (that is, filter for this property being true). See an example. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "info_catalogs" {
  description = "Microsoft Graph infoCatalogs property."
  type        = list(string)
  default     = null
}

variable "is_assignable_to_role" {
  description = "Indicates whether this group can be assigned to a Microsoft Entra role. Optional. This property can only be set while creating the group and is immutable. If set to true, the securityEnabled property must also be set to true, visibility must be Hidden, and the group can't be a dynamic group (that is, groupTypes can't contain DynamicMembership). Only callers with at least the Privileged Role Administrator role can set this property. The caller must also be assigned the RoleManagement.ReadWrite.Directory permission to set this property or update the membership of such groups. For more, see Using a group to manage Microsoft Entra role assignmentsUsing this feature requires a Microsoft Entra ID P1 license. Returned by default. Supports $filter (eq, ne, not)."
  type        = bool
  default     = null
}

variable "members" {
  description = "The members of this group, who can be users, devices, other groups, or service principals. Supports the List members, Add member, and Remove member operations. Nullable. Supports $expand including nested $select. For example, /groups?$filter=startsWith(displayName,'Role')&$select=id,displayName&$expand=members($select=id,userPrincipalName,displayName)."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
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
  type        = any
  default     = null
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
  description = "Microsoft Graph onPremisesSyncBehavior property."
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
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "permission_grants" {
  description = "Microsoft Graph permissionGrants property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "photo" {
  description = "The group's profile photo"
  type        = any
  default     = null
}

variable "planner" {
  description = "Entry-point to Planner resource that might exist for a Unified Group."
  type        = any
  default     = null
}

variable "preferred_data_location" {
  description = "The preferred data location for the Microsoft 365 group. By default, the group inherits the group creator's preferred data location. To set this property, the calling app must be granted the Directory.ReadWrite.All permission and the user be assigned at least one of the following Microsoft Entra roles: User Account Administrator Directory Writer  Exchange Administrator  SharePoint Administrator  For more information about this property, see OneDrive Online Multi-Geo. Nullable. Returned by default."
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
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
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
  description = "Errors published by a federated service describing a nontransient, service-specific error regarding the properties or link from a group object.  Supports $filter (eq, not, for isResolved and serviceInstance)."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.serviceProvisioningError")
    createdDateTime = optional(string)
    isResolved      = optional(bool)
    serviceInstance = optional(string)
  }))
  default = null
}

variable "settings" {
  description = "Settings that can govern this group's behavior, like whether members can invite guests to the group. Nullable."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.groupSetting")
    displayName = optional(string)
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
      associatedHubsUrls = optional(list(string))
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
    error = optional(any)
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
    items = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.baseItem")
      description     = optional(string)
      name            = optional(string)
      parentReference = optional(any)
    })))
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
      status             = optional(any)
      statusDetail       = optional(string)
      type               = optional(string)
    })))
    pages = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.baseSitePage")
      description     = optional(string)
      name            = optional(string)
      pageLayout      = optional(any)
      parentReference = optional(any)
      publishingState = optional(any)
      title           = optional(string)
    })))
    parentReference = optional(any)
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
      languageTags       = optional(list(string))
      sets               = optional(any)
    })))
  }))
  default = null
}

variable "team" {
  description = "The team associated with this group."
  type        = any
  default     = null
}

variable "theme" {
  description = "Specifies a Microsoft 365 group's color theme. Possible values are Teal, Purple, Green, Blue, Pink, Orange, or Red. Returned by default."
  type        = string
  default     = null
}

variable "threads" {
  description = "The group's conversation threads. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.conversationThread")
    ccRecipients = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    })))
    hasAttachments        = optional(bool)
    isLocked              = optional(bool)
    lastDeliveredDateTime = optional(string)
    posts = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.post")
      body            = optional(any)
      categories      = optional(list(string))
      createdDateTime = optional(string)
      from = optional(object({
        odata_type   = optional(string, "#microsoft.graph.recipient")
        emailAddress = optional(any)
      }))
      hasAttachments       = optional(bool)
      lastModifiedDateTime = optional(string)
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
  }))
  default = null
}

variable "transitive_member_of" {
  description = "The groups that a group is a member of, either directly or through nested membership. Nullable."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "transitive_members" {
  description = "The direct and transitive members of a group. Nullable."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "visibility" {
  description = "Specifies the group join policy and group content visibility for groups. The possible values are: Private, Public, or HiddenMembership. HiddenMembership can be set only for Microsoft 365 groups when the groups are created. It can't be updated later. Other values of visibility can be updated after group creation. If visibility value isn't specified during group creation on Microsoft Graph, a security group is created as Private by default, and the Microsoft 365 group is Public. Groups assignable to roles are always Private. To learn more, see group visibility options. Returned by default. Nullable."
  type        = string
  default     = null
}

variable "welcome_message_enabled" {
  description = "Microsoft Graph welcomeMessageEnabled property."
  type        = bool
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessType", "allowExternalSenders", "assignedLicenses", "autoSubscribeNewMembers", "calendar", "calendarView", "createdDateTime", "createdOnBehalfOf", "drive", "drives", "expirationDateTime", "extensions", "groupLifecyclePolicies", "hideFromAddressLists", "hideFromOutlookClients", "id", "isArchived", "isFavorite", "isManagementRestricted", "isSubscribedByMail", "licenseProcessingState", "mail", "memberOf", "membersWithLicenseErrors", "onPremisesDomainName", "onPremisesLastSyncDateTime", "onPremisesNetBiosName", "onPremisesSamAccountName", "onPremisesSecurityIdentifier", "onPremisesSyncEnabled", "photos", "proxyAddresses", "renewedDateTime", "securityIdentifier", "uniqueName", "unseenConversationsCount", "unseenCount", "unseenMessagesCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
