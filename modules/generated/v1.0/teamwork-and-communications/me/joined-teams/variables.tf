variable "all_channels" {
  description = "List of channels either hosted in or shared with the team (incoming channels)."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.channel")
    allMembers  = optional(any)
    description = optional(string)
    displayName = optional(string)
    enabledApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsApp")
      appDefinitions = optional(any)
      displayName    = optional(string)
      externalId     = optional(string)
    })))
    filesFolder             = optional(any)
    isFavoriteByDefault     = optional(bool)
    layoutType              = optional(string)
    members                 = optional(any)
    membershipType          = optional(string)
    messages                = optional(any)
    migrationMode           = optional(string)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.channelSummary")
      guestsCount                = optional(number)
      hasMembersFromOtherTenants = optional(bool)
      membersCount               = optional(number)
      ownersCount                = optional(number)
    }))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName = optional(string)
      teamsApp    = optional(any)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "channels" {
  description = "The collection of channels and messages associated with the team."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.channel")
    allMembers  = optional(any)
    description = optional(string)
    displayName = optional(string)
    enabledApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsApp")
      appDefinitions = optional(any)
      displayName    = optional(string)
      externalId     = optional(string)
    })))
    filesFolder             = optional(any)
    isFavoriteByDefault     = optional(bool)
    layoutType              = optional(string)
    members                 = optional(any)
    membershipType          = optional(string)
    messages                = optional(any)
    migrationMode           = optional(string)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.channelSummary")
      guestsCount                = optional(number)
      hasMembersFromOtherTenants = optional(bool)
      membersCount               = optional(number)
      ownersCount                = optional(number)
    }))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName = optional(string)
      teamsApp    = optional(any)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "classification" {
  description = "An optional label. Typically describes the data or business sensitivity of the team. Must match one of a preconfigured set in the tenant's directory."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Timestamp at which the team was created."
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description for the team. Maximum length: 1,024 characters."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the team."
  type        = string
  default     = null
}

variable "first_channel_name" {
  description = "The name of the first channel in the team. This is an optional property, only used during team creation and isn't returned in methods to get and list teams."
  type        = string
  default     = null
}

variable "fun_settings" {
  description = "Settings to configure use of Giphy, memes, and stickers in the team."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.teamFunSettings")
    allowCustomMemes      = optional(bool)
    allowGiphy            = optional(bool)
    allowStickersAndMemes = optional(bool)
    giphyContentRating    = optional(string)
  })
  default = null
}

variable "group" {
  description = "Microsoft Graph group property."
  type        = any
  default     = null
}

variable "guest_settings" {
  description = "Settings to configure whether guests can create, update, or delete channels in the team."
  type = object({
    odata_type                = optional(string, "#microsoft.graph.teamGuestSettings")
    allowCreateUpdateChannels = optional(bool)
    allowDeleteChannels       = optional(bool)
  })
  default = null
}

variable "incoming_channels" {
  description = "List of channels shared with the team."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.channel")
    allMembers  = optional(any)
    description = optional(string)
    displayName = optional(string)
    enabledApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsApp")
      appDefinitions = optional(any)
      displayName    = optional(string)
      externalId     = optional(string)
    })))
    filesFolder             = optional(any)
    isFavoriteByDefault     = optional(bool)
    layoutType              = optional(string)
    members                 = optional(any)
    membershipType          = optional(string)
    messages                = optional(any)
    migrationMode           = optional(string)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.channelSummary")
      guestsCount                = optional(number)
      hasMembersFromOtherTenants = optional(bool)
      membersCount               = optional(number)
      ownersCount                = optional(number)
    }))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName = optional(string)
      teamsApp    = optional(any)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "installed_apps" {
  description = "The apps installed in this team."
  type        = any
  default     = null
}

variable "internal_id" {
  description = "A unique ID for the team that was used in a few places such as the audit log/Office 365 Management Activity API."
  type        = string
  default     = null
}

variable "member_settings" {
  description = "Settings to configure whether members can perform certain actions, for example, create channels and add bots, in the team."
  type = object({
    odata_type                        = optional(string, "#microsoft.graph.teamMemberSettings")
    allowAddRemoveApps                = optional(bool)
    allowCreatePrivateChannels        = optional(bool)
    allowCreateUpdateChannels         = optional(bool)
    allowCreateUpdateRemoveConnectors = optional(bool)
    allowCreateUpdateRemoveTabs       = optional(bool)
    allowDeleteChannels               = optional(bool)
  })
  default = null
}

variable "members" {
  description = "Members and owners of the team."
  type        = any
  default     = null
}

variable "messaging_settings" {
  description = "Settings to configure messaging and mentions in the team."
  type = object({
    odata_type               = optional(string, "#microsoft.graph.teamMessagingSettings")
    allowChannelMentions     = optional(bool)
    allowOwnerDeleteMessages = optional(bool)
    allowTeamMentions        = optional(bool)
    allowUserDeleteMessages  = optional(bool)
    allowUserEditMessages    = optional(bool)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.team"
  nullable    = false
}

variable "operations" {
  description = "The async operations that ran or are running on this team."
  type = list(object({
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
  }))
  default = null
}

variable "permission_grants" {
  description = "A collection of permissions granted to apps to access the team."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "photo" {
  description = "The profile photo for the team."
  type        = any
  default     = null
}

variable "primary_channel" {
  description = "The general channel for the team."
  type        = any
  default     = null
}

variable "schedule" {
  description = "The schedule of shifts for this team."
  type        = any
  default     = null
}

variable "specialization" {
  description = "Optional. Indicates whether the team is intended for a particular use case. Each team specialization has access to unique behaviors and experiences targeted to its use case."
  type        = string
  default     = null

  validation {
    condition     = var.specialization == null ? true : contains(["none", "educationStandard", "educationClass", "educationProfessionalLearningCommunity", "educationStaff", "healthcareStandard", "healthcareCareCoordination", "unknownFutureValue"], var.specialization)
    error_message = "specialization must be one of the documented enum values."
  }
}

variable "summary" {
  description = "Contains summary information about the team, including number of owners, members, and guests."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.teamSummary")
    guestsCount  = optional(number)
    membersCount = optional(number)
    ownersCount  = optional(number)
  })
  default = null
}

variable "tags" {
  description = "The tags associated with the team."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.teamworkTag")
    description = optional(string)
    displayName = optional(string)
    memberCount = optional(number)
    members = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.teamworkTagMember")
      displayName = optional(string)
      tenantId    = optional(string)
      userId      = optional(string)
    })))
    tagType = optional(string)
    teamId  = optional(string)
  }))
  default = null
}

variable "template" {
  description = "The template this team was created from. See available templates."
  type        = any
  default     = null
}

variable "tenant_id" {
  description = "The ID of the Microsoft Entra tenant."
  type        = string
  default     = null
}

variable "visibility" {
  description = "The visibility of the group and team. Defaults to Public."
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : contains(["private", "public", "hiddenMembership", "unknownFutureValue"], var.visibility)
    error_message = "visibility must be one of the documented enum values."
  }
}

variable "web_url" {
  description = "A hyperlink that goes to the team in the Microsoft Teams client. You get this URL when you right-click a team in the Microsoft Teams client and select Get link to team. This URL should be treated as an opaque blob, and not parsed."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isArchived"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
