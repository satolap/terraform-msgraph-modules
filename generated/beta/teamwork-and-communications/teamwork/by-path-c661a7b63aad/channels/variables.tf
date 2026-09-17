variable "team_template_id" {
  description = "The unique identifier of teamTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_id)) > 0
    error_message = "team_template_id must not be empty."
  }
}

variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "all_members" {
  description = "A collection of membership records associated with the channel. It includes both direct and indirect members of shared channels."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.conversationMember")
    displayName                 = optional(string)
    roles                       = optional(list(string))
    visibleHistoryStartDateTime = optional(string)
  }))
  default = null
}

variable "description" {
  description = "Optional textual description for the channel."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Channel name as it appears to the user in Microsoft Teams. The maximum length is 50 characters."
  type        = string
  default     = null
}

variable "enabled_apps" {
  description = "A collection of enabled apps in the channel."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsApp")
    appDefinitions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.teamsAppDefinition")
      allowedInstallationScopes = optional(any)
      authorization             = optional(any)
      azureADAppId              = optional(string)
      bot                       = optional(any)
      colorIcon                 = optional(any)
      createdBy                 = optional(any)
      dashboardCards            = optional(any)
      description               = optional(string)
      displayName               = optional(string)
      lastModifiedDateTime      = optional(string)
      outlineIcon               = optional(any)
      publishingState           = optional(any)
      shortdescription          = optional(string)
      teamsAppId                = optional(string)
      version                   = optional(string)
    })))
    displayName = optional(string)
    externalId  = optional(string)
  }))
  default = null
}

variable "files_folder" {
  description = "Metadata for the location where the channel's files are stored."
  type        = any
  default     = null
}

variable "is_favorite_by_default" {
  description = "Indicates whether the channel should be marked as recommended for all members of the team to show in their channel list. Note: All recommended channels automatically show in the channels list for education and frontline worker users. The property can only be set programmatically via the Create team method. The default value is false."
  type        = bool
  default     = null
}

variable "joined_users" {
  description = "Microsoft Graph joinedUsers property."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.conversationMember")
    displayName                 = optional(string)
    roles                       = optional(list(string))
    visibleHistoryStartDateTime = optional(string)
  }))
  default = null
}

variable "layout_type" {
  description = "The layout type of the channel. It can be set during creation and updated later. The possible values are: post, chat, unknownFutureValue. The default value is post. Channels with the post layout use a traditional post‑reply conversation format, and channels with the chat layout provide a chat‑like threading experience similar to group chats."
  type        = any
  default     = null

  validation {
    condition     = var.layout_type == null ? true : contains(["post", "chat", "unknownFutureValue"], var.layout_type)
    error_message = "layout_type must be one of the documented enum values."
  }
}

variable "members" {
  description = "A collection of membership records associated with the channel."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.conversationMember")
    displayName                 = optional(string)
    roles                       = optional(list(string))
    visibleHistoryStartDateTime = optional(string)
  }))
  default = null
}

variable "membership_type" {
  description = "The type of the channel. Can be set during creation and can't be changed. The possible values are: standard, private, unknownFutureValue, shared. The default value is standard. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: shared."
  type        = any
  default     = null

  validation {
    condition     = var.membership_type == null ? true : contains(["standard", "private", "unknownFutureValue", "shared"], var.membership_type)
    error_message = "membership_type must be one of the documented enum values."
  }
}

variable "messages" {
  description = "A collection of all the messages in the channel. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.chatMessage")
    attachments = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.chatMessageAttachment")
      content      = optional(string)
      contentType  = optional(string)
      contentUrl   = optional(string)
      name         = optional(string)
      teamsAppId   = optional(string)
      thumbnailUrl = optional(string)
    })))
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
    hostedContents = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.chatMessageHostedContent")
      contentBytes = optional(string)
      contentType  = optional(string)
    })))
    importance = optional(string)
    locale     = optional(string)
    mentions = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessageMention")
      id          = optional(number)
      mentionText = optional(string)
      mentioned   = optional(any)
    })))
    messageHistory = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.chatMessageHistoryItem")
      actions          = optional(string)
      modifiedDateTime = optional(string)
      reaction         = optional(any)
    })))
    messageType     = optional(string)
    onBehalfOf      = optional(any)
    policyViolation = optional(any)
    reactions = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.chatMessageReaction")
      createdDateTime    = optional(string)
      displayName        = optional(string)
      reactionContentUrl = optional(string)
      reactionType       = optional(string)
      user = optional(object({
        odata_type  = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")
        application = optional(any)
        device      = optional(any)
        user        = optional(any)
      }))
    })))
    replies = optional(any)
    subject = optional(string)
    summary = optional(string)
  }))
  default = null
}

variable "migration_mode" {
  description = "Indicates whether a channel is in migration mode. This value is null for channels that never entered migration mode. The possible values are: inProgress, completed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.migration_mode == null ? true : contains(["inProgress", "completed", "unknownFutureValue"], var.migration_mode)
    error_message = "migration_mode must be one of the documented enum values."
  }
}

variable "moderation_settings" {
  description = "Settings to configure channel moderation to control who can start new posts and reply to posts in that channel."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.channel"
  nullable    = false
}

variable "original_created_date_time" {
  description = "Timestamp of the original creation time for the channel. The value is null if the channel never entered migration mode."
  type        = string
  default     = null
}

variable "shared_with_teams" {
  description = "A collection of teams with which a channel is shared."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
    allowedMembers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    displayName = optional(string)
    isHostTeam  = optional(bool)
    team        = optional(any)
    tenantId    = optional(string)
  }))
  default = null
}

variable "summary" {
  description = "Contains summary information about the channel, including number of guests, members, owners, and an indicator for members from other tenants. The summary property is only returned if it appears in the $select clause of the Get channel method."
  type        = any
  default     = null
}

variable "tabs" {
  description = "A collection of all the tabs in the channel."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.teamsTab")
    configuration  = optional(any)
    displayName    = optional(string)
    messageId      = optional(string)
    sortOrderIndex = optional(string)
    teamsApp       = optional(any)
    teamsAppId     = optional(string)
  }))
  default = null
}

variable "tenant_id" {
  description = "The ID of the Microsoft Entra tenant."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "email", "id", "isArchived", "planner", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
