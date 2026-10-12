variable "channels" {
  description = "The channels those are either shared with this deleted team or created in this deleted team."
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
    filesFolder         = optional(any)
    isFavoriteByDefault = optional(bool)
    joinedUsers         = optional(any)
    layoutType          = optional(string)
    members             = optional(any)
    membershipType      = optional(string)
    messages            = optional(any)
    migrationMode       = optional(string)
    moderationSettings = optional(object({
      odata_type                    = optional(string, "#microsoft.graph.channelModerationSettings")
      allowNewMessageFromBots       = optional(bool)
      allowNewMessageFromConnectors = optional(bool)
      replyRestriction              = optional(string)
      userNewMessageRestriction     = optional(string)
    }))
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
      displayName    = optional(string)
      messageId      = optional(string)
      sortOrderIndex = optional(string)
      teamsApp       = optional(any)
      teamsAppId     = optional(string)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deletedTeam"
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
