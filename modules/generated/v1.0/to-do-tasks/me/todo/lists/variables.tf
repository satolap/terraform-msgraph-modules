variable "display_name" {
  description = "The name of the task list."
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the task list. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "is_owner" {
  description = "True if the user is owner of the given task list."
  type        = bool
  default     = null
}

variable "is_shared" {
  description = "True if the task list is shared with other users"
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.todoTaskList"
  nullable    = false
}

variable "wellknown_list_name" {
  description = "Microsoft Graph wellknownListName property."
  type        = string
  default     = null

  validation {
    condition     = var.wellknown_list_name == null ? true : contains(["none", "defaultList", "flaggedEmails", "unknownFutureValue"], var.wellknown_list_name)
    error_message = "wellknown_list_name must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "tasks"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
