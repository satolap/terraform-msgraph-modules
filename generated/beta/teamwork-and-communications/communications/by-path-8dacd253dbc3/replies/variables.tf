variable "online_meeting_engagement_conversation_id" {
  description = "The unique identifier of onlineMeetingEngagementConversation"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.online_meeting_engagement_conversation_id)) > 0
    error_message = "online_meeting_engagement_conversation_id must not be empty."
  }
}

variable "body" {
  description = "Microsoft Graph body property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(any)
  })
  default = null
}

variable "conversation" {
  description = "Represents a conversation in Viva Engage."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.engagementConversation")
    creationMode = optional(string)
    messages = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")
      body = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(any)
      }))
      conversation = optional(any)
      creationMode = optional(string)
      from         = optional(any)
      reactions = optional(list(object({
        odata_type   = optional(string, "#microsoft.graph.engagementConversationMessageReaction")
        reactionBy   = optional(any)
        reactionType = optional(string)
      })))
      replies   = optional(any)
      replyTo   = optional(any)
      replyToId = optional(string)
    })))
    starter = optional(object({
      odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")
      body = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(any)
      }))
      conversation = optional(any)
      creationMode = optional(string)
      from         = optional(any)
      reactions = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")
        reactionBy = optional(object({
          odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
          application = optional(any)
          audience    = optional(any)
          device      = optional(any)
          group       = optional(any)
          user        = optional(any)
        }))
        reactionType = optional(string)
      })))
      replies   = optional(any)
      replyTo   = optional(any)
      replyToId = optional(string)
    }))
    starterId = optional(string)
  })
  default = null
}

variable "creation_mode" {
  description = "Indicates that the resource is in migration state and is currently being used for migration purposes."
  type        = string
  default     = null

  validation {
    condition     = var.creation_mode == null ? true : contains(["none", "migration", "unknownFutureValue"], var.creation_mode)
    error_message = "creation_mode must be one of the documented enum values."
  }
}

variable "from" {
  description = "Identity of the sender of the message."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.engagementConversationMessage"
  nullable    = false
}

variable "reactions" {
  description = "A collection of reactions (such as like and smile) that users have applied to this message."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")
    reactionBy = optional(object({
      odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
      application = optional(any)
      audience    = optional(any)
      device      = optional(any)
      group       = optional(any)
      user        = optional(any)
    }))
    reactionType = optional(string)
  }))
  default = null
}

variable "replies" {
  description = "A collection of messages that are replies to this message and form a threaded discussion."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(any)
    }))
    conversation = optional(object({
      odata_type   = optional(string, "#microsoft.graph.engagementConversation")
      creationMode = optional(string)
      messages     = optional(any)
      starter      = optional(any)
      starterId    = optional(string)
    }))
    creationMode = optional(string)
    from         = optional(any)
    reactions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")
      reactionBy = optional(object({
        odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
        application = optional(any)
        audience    = optional(any)
        device      = optional(any)
        group       = optional(any)
        user        = optional(any)
      }))
      reactionType = optional(string)
    })))
    replies   = optional(any)
    replyTo   = optional(any)
    replyToId = optional(string)
  }))
  default = null
}

variable "reply_to" {
  description = "The parent message to which this message is a reply, if it is part of a reply chain."
  type        = any
  default     = null
}

variable "reply_to_id" {
  description = "The ID of the parent message to which this message is a reply, if applicable."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
