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

variable "actions" {
  description = "Actions to be taken on a message when the corresponding conditions are fulfilled."
  type        = any
  default     = null
}

variable "conditions" {
  description = "Conditions that when fulfilled trigger the corresponding actions for that rule."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name of the rule."
  type        = string
  default     = null
}

variable "exceptions" {
  description = "Exception conditions for the rule."
  type        = any
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the rule is enabled to be applied to messages."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.messageRule"
  nullable    = false
}

variable "sequence" {
  description = "Indicates the order in which the rule is executed, among other rules."
  type        = number
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["hasError", "id", "isReadOnly"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
