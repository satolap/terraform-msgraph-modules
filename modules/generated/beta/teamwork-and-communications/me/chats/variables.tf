variable "chat_type" {
  description = "Microsoft Graph chatType property."
  type        = string
  default     = null

  validation {
    condition     = var.chat_type == null ? true : contains(["oneOnOne", "group", "meeting", "unknownFutureValue"], var.chat_type)
    error_message = "chat_type must be one of the documented enum values."
  }
}

variable "installed_apps" {
  description = "A collection of all the apps in the chat. Nullable."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.teamsAppInstallation")
    consentedPermissionSet = optional(any)
    scopeInfo              = optional(any)
    teamsApp               = optional(any)
    teamsAppDefinition     = optional(any)
  }))
  default = null
}

variable "last_message_preview" {
  description = "Preview of the last message sent in the chat. Null if no messages are sent in the chat. Currently, only the list chats operation supports this property."
  type        = any
  default     = null
}

variable "members" {
  description = "A collection of all the members in the chat. Nullable."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.conversationMember")
    displayName                 = optional(string)
    roles                       = optional(list(string))
    visibleHistoryStartDateTime = optional(string)
  }))
  default = null
}

variable "messages" {
  description = "A collection of all the messages in the chat. Nullable."
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
  description = "Indicates whether a chat is in migration mode. This value is null for chats that never entered migration mode. The possible values are: inProgress, completed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.migration_mode == null ? true : contains(["inProgress", "completed", "unknownFutureValue"], var.migration_mode)
    error_message = "migration_mode must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.chat"
  nullable    = false
}

variable "operations" {
  description = "A collection of all the Teams async operations that ran or are running on the chat. Nullable."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.teamsAsyncOperation")
    attemptsCount          = optional(number)
    createdDateTime        = optional(string)
    error                  = optional(any)
    lastActionDateTime     = optional(string)
    operationType          = optional(string)
    status                 = optional(string)
    targetResourceId       = optional(string)
    targetResourceLocation = optional(string)
  }))
  default = null
}

variable "original_created_date_time" {
  description = "Timestamp of the original creation time for the chat. The value is null if the chat never entered migration mode."
  type        = string
  default     = null
}

variable "permission_grants" {
  description = "A collection of permissions granted to apps for the chat."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "pinned_messages" {
  description = "A collection of all the pinned messages in the chat. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")
    message    = optional(any)
  }))
  default = null
}

variable "tabs" {
  description = "A collection of all the tabs in the chat. Nullable."
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

variable "targeted_messages" {
  description = "A collection of targeted messages in the chat that are visible only to specific users. Nullable. You can't expand this relationship using $expand. Targeted messages can also be retrieved via the userTeamwork: getAllTargetedMessages API."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.targetedChatMessage")
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
    recipient = optional(any)
    replies = optional(list(object({
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
    subject = optional(string)
    summary = optional(string)
  }))
  default = null
}

variable "topic" {
  description = "(Optional) Subject or topic for the chat. Only available for group chats."
  type        = string
  default     = null
}

variable "viewpoint" {
  description = "Represents caller-specific information about the chat, such as last message read date and time. This property is populated only when the request is made in a delegated context."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "isHiddenForAllMembers", "lastUpdatedDateTime", "onlineMeetingInfo", "tenantId", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
