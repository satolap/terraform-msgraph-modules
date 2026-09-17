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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.engagementConversationMessageReaction"
  nullable    = false
}

variable "reaction_by" {
  description = "The Viva Engage identities."
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

variable "reaction_type" {
  description = "Types of reactions to conversation messages."
  type        = string
  default     = null

  validation {
    condition     = var.reaction_type == null ? true : contains(["like", "love", "celebrate", "thank", "laugh", "sad", "happy", "excited", "smile", "silly", "intenseLaugh", "starStruck", "goofy", "thinking", "surprised", "mindBlown", "scared", "crying", "shocked", "angry", "agree", "praise", "takingNotes", "heartBroken", "support", "confirmed", "watching", "brain", "medal", "bullseye", "unknownFutureValue"], var.reaction_type)
    error_message = "reaction_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
