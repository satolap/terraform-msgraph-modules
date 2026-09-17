variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "mail_folder_id" {
  description = "The unique identifier of mailFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mail_folder_id)) > 0
    error_message = "mail_folder_id must not be empty."
  }
}

variable "mail_folder_id1" {
  description = "The unique identifier of mailFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mail_folder_id1)) > 0
    error_message = "mail_folder_id1 must not be empty."
  }
}

variable "message_id" {
  description = "The unique identifier of message"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.message_id)) > 0
    error_message = "message_id must not be empty."
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
