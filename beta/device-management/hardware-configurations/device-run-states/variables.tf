variable "hardware_configuration_id" {
  description = "The unique identifier of hardwareConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.hardware_configuration_id)) > 0
    error_message = "hardware_configuration_id must not be empty."
  }
}

variable "assignment_filter_ids" {
  description = "A list of identifier strings of different assignment filters applied"
  type        = string
  default     = null
}

variable "configuration_error" {
  description = "Error from the hardware configuration execution"
  type        = string
  default     = null
}

variable "configuration_output" {
  description = "Output of the hardware configuration execution"
  type        = string
  default     = null
}

variable "configuration_state" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.configuration_state == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], var.configuration_state)
    error_message = "configuration_state must be one of the documented enum values."
  }
}

variable "device_name" {
  description = "The name of the device"
  type        = string
  default     = null
}

variable "internal_version" {
  description = "The Policy internal version"
  type        = number
  default     = null
}

variable "last_state_update_date_time" {
  description = "The last timestamp of when the hardware configuration executed"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.hardwareConfigurationDeviceState"
  nullable    = false
}

variable "os_version" {
  description = "Operating system version of the device (E.g. 10.0.19042.1165, 10.0.19042.1288 etc.)"
  type        = string
  default     = null
}

variable "upn" {
  description = "User Principal Name (UPN)."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "userId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
