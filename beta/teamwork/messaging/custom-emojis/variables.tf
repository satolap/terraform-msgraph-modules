variable "content_bytes" {
  description = "The base64-encoded image content of the emoji. Supported formats include PNG and GIF."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.customEmojiFromIdentitySet")
    application = optional(any)
    device      = optional(any)
    user        = optional(any)
  })
  default = null
}

variable "created_date_time" {
  description = "The date and time when the emoji was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2024, is 2024-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The unique display name of the custom emoji. Key. Must be unique and must not conflict with existing emoji names."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamworkCustomEmoji"
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
