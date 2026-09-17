variable "chat_id" {
  description = "The unique identifier of chat"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.chat_id)) > 0
    error_message = "chat_id must not be empty."
  }
}

variable "chat_message_id" {
  description = "The unique identifier of chatMessage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.chat_message_id)) > 0
    error_message = "chat_message_id must not be empty."
  }
}

variable "chat_message_id1" {
  description = "The unique identifier of chatMessage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.chat_message_id1)) > 0
    error_message = "chat_message_id1 must not be empty."
  }
}

variable "content_bytes" {
  description = "Write only. Bytes for the hosted content (such as images)."
  type        = string
  default     = null
}

variable "content_type" {
  description = "Write only. Content type. such as image/png, image/jpg."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.chatMessageHostedContent"
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
