variable "online_meeting_engagement_conversation_id" {
  description = "The unique identifier of onlineMeetingEngagementConversation"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.online_meeting_engagement_conversation_id)) > 0
    error_message = "online_meeting_engagement_conversation_id must not be empty."
  }
}

variable "engagement_conversation_message_id" {
  description = "The unique identifier of engagementConversationMessage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.engagement_conversation_message_id)) > 0
    error_message = "engagement_conversation_message_id must not be empty."
  }
}

variable "engagement_conversation_message_id1" {
  description = "The unique identifier of engagementConversationMessage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.engagement_conversation_message_id1)) > 0
    error_message = "engagement_conversation_message_id1 must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.engagementConversationMessageReaction"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "reactionBy", "reactionType"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
