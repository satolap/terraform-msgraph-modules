variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "conversation_id" {
  description = "The unique identifier of conversation"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.conversation_id)) > 0
    error_message = "conversation_id must not be empty."
  }
}

variable "conversation_thread_id" {
  description = "The unique identifier of conversationThread"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.conversation_thread_id)) > 0
    error_message = "conversation_thread_id must not be empty."
  }
}

variable "post_id" {
  description = "The unique identifier of post"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.post_id)) > 0
    error_message = "post_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.extension"
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
