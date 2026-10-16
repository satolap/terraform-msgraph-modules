variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "change_key" {
  description = "The version of the task group."
  type        = string
  default     = null
}

variable "group_key" {
  description = "The unique GUID identifier for the task group."
  type        = string
  default     = null
}

variable "is_default_group" {
  description = "True if the task group is the default task group."
  type        = bool
  default     = null
}

variable "name" {
  description = "The name of the task group."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.outlookTaskGroup"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "taskFolders"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
