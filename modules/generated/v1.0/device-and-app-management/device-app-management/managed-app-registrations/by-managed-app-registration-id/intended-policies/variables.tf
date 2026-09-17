variable "managed_app_registration_id" {
  description = "The unique identifier of managedAppRegistration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_app_registration_id)) > 0
    error_message = "managed_app_registration_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "description" {
  description = "The policy's description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Last time the policy was modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedAppPolicy"
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
