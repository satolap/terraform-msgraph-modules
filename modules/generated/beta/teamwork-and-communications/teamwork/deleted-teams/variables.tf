variable "channels" {
  description = "The channels those are either shared with this deleted team or created in this deleted team."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.channel")
    allMembers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
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
    joinedUsers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    layoutType = optional(any)
    members = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    membershipType = optional(any)
    messages = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessage")
      attachments = optional(any)
      body = optional(object({
        odata_type             = optional(string, "#microsoft.graph.chatMessageBody")
        content                = optional(string)
        contentType            = optional(any)
        messageBodyContentType = optional(any)
      }))
      channelIdentity = optional(any)
      chatId          = optional(string)
      createdDateTime = optional(string)
      from            = optional(any)
      hasReplies      = optional(bool)
      hostedContents  = optional(any)
      importance      = optional(string)
      locale          = optional(string)
      mentions        = optional(any)
      messageHistory  = optional(any)
      messageType     = optional(string)
      onBehalfOf      = optional(any)
      policyViolation = optional(any)
      reactions       = optional(any)
      replies         = optional(any)
      subject         = optional(string)
      summary         = optional(string)
    })))
    migrationMode           = optional(any)
    moderationSettings      = optional(any)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(any)
    tabs = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsTab")
      configuration  = optional(any)
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
