variable "deviceManagementScript-id" {
  description = "The unique identifier of deviceManagementScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.deviceManagementScript-id)) > 0
    error_message = "deviceManagementScript-id must not be empty."
  }
}

variable "deviceManagementScriptUserState-id" {
  description = "The unique identifier of deviceManagementScriptUserState"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.deviceManagementScriptUserState-id)) > 0
    error_message = "deviceManagementScriptUserState-id must not be empty."
  }
}

variable "errorCode" {
  description = "Error code corresponding to erroneous execution of the device management script."
  type        = number
  default     = null
}

variable "errorDescription" {
  description = "Error description corresponding to erroneous execution of the device management script."
  type        = string
  default     = null
}

variable "lastStateUpdateDateTime" {
  description = "Latest time the device management script executes."
  type        = string
  default     = null
}

variable "managedDevice" {
  description = "The managed devices that executes the device management script."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementScriptDeviceState"
  nullable    = false
}

variable "resultMessage" {
  description = "Details of execution output."
  type        = string
  default     = null
}

variable "runState" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.runState == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], var.runState)
    error_message = "runState must be one of the documented enum values."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
