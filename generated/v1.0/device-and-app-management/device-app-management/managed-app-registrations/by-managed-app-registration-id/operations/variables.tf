variable "managed_app_registration_id" {
  description = "The unique identifier of managedAppRegistration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_app_registration_id)) > 0
    error_message = "managed_app_registration_id must not be empty."
  }
}

variable "display_name" {
  description = "The operation name."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The last time the app operation was modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedAppOperation"
  nullable    = false
}

variable "state" {
  description = "The current state of the operation"
  type        = string
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
