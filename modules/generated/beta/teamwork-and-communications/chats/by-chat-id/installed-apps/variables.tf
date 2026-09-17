variable "chat_id" {
  description = "The unique identifier of chat"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.chat_id)) > 0
    error_message = "chat_id must not be empty."
  }
}

variable "consented_permission_set" {
  description = "The set of resource-specific permissions consented to while installing or upgrading the teamsApp."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAppInstallation"
  nullable    = false
}

variable "scope_info" {
  description = "The details of the scope in which the app is installed."
  type        = any
  default     = null
}

variable "teams_app" {
  description = "The app that is installed."
  type        = any
  default     = null
}

variable "teams_app_definition" {
  description = "The details of this version of the app."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
