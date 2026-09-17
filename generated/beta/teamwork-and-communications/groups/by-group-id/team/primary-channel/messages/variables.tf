variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "attachments" {
  description = "References to attached objects like files, tabs, meetings etc."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.chatMessageAttachment")
    content      = optional(string)
    contentType  = optional(string)
    contentUrl   = optional(string)
    name         = optional(string)
    teamsAppId   = optional(string)
    thumbnailUrl = optional(string)
  }))
  default = null
}

variable "body" {
  description = "Microsoft Graph body property."
  type = object({
    odata_type             = optional(string, "#microsoft.graph.chatMessageBody")
    content                = optional(string)
    contentType            = optional(any)
    messageBodyContentType = optional(any)
  })
  default = null
}

variable "channel_identity" {
  description = "If the message was sent in a channel, represents identity of the channel."
  type        = any
  default     = null
}

variable "chat_id" {
  description = "If the message was sent in a chat, represents the identity of the chat."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Timestamp of when the chat message was created."
  type        = string
  default     = null
}

variable "from" {
  description = "Details of the sender of the chat message. Can only be set during migration."
  type        = any
  default     = null
}

variable "has_replies" {
  description = "Microsoft Graph hasReplies property."
  type        = bool
  default     = null
}

variable "hosted_contents" {
  description = "Content in a message hosted by Microsoft Teams - for example, images or code snippets."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.chatMessageHostedContent")
    contentBytes = optional(string)
    contentType  = optional(string)
  }))
  default = null
}

variable "importance" {
  description = "Microsoft Graph importance property."
  type        = string
  default     = null

  validation {
    condition     = var.importance == null ? true : contains(["normal", "high", "urgent"], var.importance)
    error_message = "importance must be one of the documented enum values."
  }
}

variable "locale" {
  description = "Locale of the chat message set by the client. Always set to en-us."
  type        = string
  default     = null
}

variable "mentions" {
  description = "List of entities mentioned in the chat message. Supported entities are: user, bot, team, channel, chat, and tag."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.chatMessageMention")
    id          = optional(number)
    mentionText = optional(string)
    mentioned   = optional(any)
  }))
  default = null
}

variable "message_history" {
  description = "List of activity history of a message item, including modification time and actions, such as reactionAdded, reactionRemoved, or reaction changes, on the message."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.chatMessageHistoryItem")
    actions          = optional(string)
    modifiedDateTime = optional(string)
    reaction         = optional(any)
  }))
  default = null
}

variable "message_type" {
  description = "Microsoft Graph messageType property."
  type        = string
  default     = null

  validation {
    condition     = var.message_type == null ? true : contains(["message", "chatEvent", "typing", "unknownFutureValue", "systemEventMessage"], var.message_type)
    error_message = "message_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.chatMessage"
  nullable    = false
}

variable "on_behalf_of" {
  description = "User attribution of the message when bot sends a message on behalf of a user."
  type        = any
  default     = null
}

variable "policy_violation" {
  description = "Defines the properties of a policy violation set by a data loss prevention (DLP) application."
  type        = any
  default     = null
}

variable "reactions" {
  description = "Reactions for this chat message (for example, Like)."
  type = list(object({
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
  }))
  default = null
}

variable "replies" {
  description = "Replies for a specified message. Supports $expand for channel messages."
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

variable "subject" {
  description = "The subject of the chat message, in plaintext."
  type        = string
  default     = null
}

variable "summary" {
  description = "Summary text of the chat message that could be used for push notifications and summary views or fall back views. Only applies to channel chat messages, not chat messages in a chat."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["citations", "deletedDateTime", "etag", "eventDetail", "id", "lastEditedDateTime", "lastModifiedDateTime", "replyToId", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
