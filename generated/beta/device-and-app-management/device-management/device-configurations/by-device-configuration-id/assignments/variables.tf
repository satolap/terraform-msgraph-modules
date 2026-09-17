variable "device_configuration_id" {
  description = "The unique identifier of deviceConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_configuration_id)) > 0
    error_message = "device_configuration_id must not be empty."
  }
}

variable "graph_source" {
  description = "Represents source of assignment."
  type        = string
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["direct", "policySets"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "intent" {
  description = "The admin intent to apply or remove the profile. Possible values are: apply, remove."
  type        = any
  default     = null

  validation {
    condition     = var.intent == null ? true : contains(["apply", "remove"], var.intent)
    error_message = "intent must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceConfigurationAssignment"
  nullable    = false
}

variable "target" {
  description = "The assignment target for the device configuration."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "sourceId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
