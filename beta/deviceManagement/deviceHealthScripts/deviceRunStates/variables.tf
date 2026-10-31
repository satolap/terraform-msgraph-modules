variable "deviceHealthScript-id" {
  description = "The unique identifier of deviceHealthScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.deviceHealthScript-id)) > 0
    error_message = "deviceHealthScript-id must not be empty."
  }
}

variable "assignmentFilterIds" {
  description = "A list of the assignment filter ids used for health script applicability evaluation"
  type        = list(string)
  default     = null
}

variable "detectionState" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.detectionState == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], var.detectionState)
    error_message = "detectionState must be one of the documented enum values."
  }
}

variable "expectedStateUpdateDateTime" {
  description = "The next timestamp of when the device health script is expected to execute"
  type        = string
  default     = null
}

variable "lastStateUpdateDateTime" {
  description = "The last timestamp of when the device health script executed"
  type        = string
  default     = null
}

variable "lastSyncDateTime" {
  description = "The last time that Intune Managment Extension synced with Intune"
  type        = string
  default     = null
}

variable "managedDevice" {
  description = "The managed device on which the device health script executed"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceHealthScriptDeviceState"
  nullable    = false
}

variable "postRemediationDetectionScriptError" {
  description = "Error from the detection script after remediation"
  type        = string
  default     = null
}

variable "postRemediationDetectionScriptOutput" {
  description = "Detection script output after remediation"
  type        = string
  default     = null
}

variable "preRemediationDetectionScriptError" {
  description = "Error from the detection script before remediation"
  type        = string
  default     = null
}

variable "preRemediationDetectionScriptOutput" {
  description = "Output of the detection script before remediation"
  type        = string
  default     = null
}

variable "remediationScriptError" {
  description = "Error output of the remediation script"
  type        = string
  default     = null
}

variable "remediationState" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.remediationState == null ? true : contains(["unknown", "skipped", "success", "remediationFailed", "scriptError"], var.remediationState)
    error_message = "remediationState must be one of the documented enum values."
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
