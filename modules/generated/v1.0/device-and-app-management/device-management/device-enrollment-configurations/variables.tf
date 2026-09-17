variable "assignments" {
  description = "The list of group assignments for the device configuration profile"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.enrollmentConfigurationAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "Created date time in UTC of the device enrollment configuration"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the device enrollment configuration"
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the device enrollment configuration"
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version of the device enrollment configuration"
  type        = number
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modified date time in UTC of the device enrollment configuration"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceEnrollmentConfiguration"
  nullable    = false
}

variable "priority" {
  description = "Priority is used when a user exists in multiple groups that are assigned enrollment configuration. Users are subject only to the configuration with the lowest priority value."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
