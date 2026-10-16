variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "planner_plan_id" {
  description = "The unique identifier of plannerPlan"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_plan_id)) > 0
    error_message = "planner_plan_id must not be empty."
  }
}

variable "planner_task_id" {
  description = "The unique identifier of plannerTask"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_task_id)) > 0
    error_message = "planner_task_id must not be empty."
  }
}

variable "content" {
  description = "The content of the chat message. Supports plain text and sanitized HTML."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The identity of the user who created the message."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the message was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Microsoft Graph deletedDateTime property."
  type        = string
  default     = null
}

variable "edited_date_time" {
  description = "Microsoft Graph editedDateTime property."
  type        = string
  default     = null
}

variable "mentions" {
  description = "The list of mentions in the message."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.plannerTaskChatMention")
    mentionType = optional(string)
    mentioned   = optional(string)
    position    = optional(number)
  }))
  default = null
}

variable "message_type" {
  description = "Microsoft Graph messageType property."
  type        = string
  default     = null

  validation {
    condition     = var.message_type == null ? true : contains(["richTextHtml", "plainText", "unknownFutureValue"], var.message_type)
    error_message = "message_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerTaskChatMessage"
  nullable    = false
}

variable "parent_entity_id" {
  description = "The ID of the parent plannerTask that this message belongs to."
  type        = string
  default     = null
}

variable "reactions" {
  description = "The reactions on the message."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.plannerTaskChatReaction")
    reactionEvents = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.plannerTaskChatReactionEvent")
      createdBy       = optional(any)
      createdDateTime = optional(string)
    })))
    reactionType = optional(string)
  }))
  default = null
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
