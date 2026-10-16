variable "device_configuration_id" {
  description = "The unique identifier of deviceConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_configuration_id)) > 0
    error_message = "device_configuration_id must not be empty."
  }
}

variable "device_configuration" {
  description = "The navigation link to the Device Configuration being targeted."
  type        = any
  default     = null
}

variable "exclude_group" {
  description = "Indicates if this group is should be excluded. Defaults that the group should be included"
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceConfigurationGroupAssignment"
  nullable    = false
}

variable "target_group_id" {
  description = "The Id of the AAD group we are targeting the device configuration to."
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
