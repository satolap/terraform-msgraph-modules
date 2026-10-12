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
  description = "The body of the message."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null
}

variable "conversation" {
  description = "Represents a conversation in Viva Engage."
  type        = any
  default     = null
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
  type = object({
    odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
    application = optional(any)
    audience    = optional(any)
    device      = optional(any)
    group       = optional(any)
    user        = optional(any)
  })
  default = null
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
  }))
  default = null
}

variable "replies" {
  description = "A collection of messages that are replies to this message and form a threaded discussion."
  type        = any
  default     = null
}

variable "reply_to" {
  description = "The parent message to which this message is a reply, if it is part of a reply chain."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime", "replyToId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
