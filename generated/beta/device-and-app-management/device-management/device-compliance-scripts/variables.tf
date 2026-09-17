variable "assignments" {
  description = "The list of group assignments for the device compliance script"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceHealthScriptAssignment")
    runRemediationScript = optional(bool)
    runSchedule          = optional(any)
    target               = optional(any)
  }))
  default = null
}

variable "description" {
  description = "Description of the device compliance script"
  type        = string
  default     = null
}

variable "detection_script_content" {
  description = "The entire content of the detection powershell script"
  type        = string
  default     = null
}

variable "device_run_states" {
  description = "List of run states for the device compliance script across all devices"
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.deviceComplianceScriptDeviceState")
    detectionState              = optional(string)
    expectedStateUpdateDateTime = optional(string)
    lastStateUpdateDateTime     = optional(string)
    lastSyncDateTime            = optional(string)
    managedDevice               = optional(any)
    scriptError                 = optional(string)
    scriptOutput                = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "Name of the device compliance script"
  type        = string
  default     = null
}

variable "enforce_signature_check" {
  description = "Indicate whether the script signature needs be checked"
  type        = bool
  default     = null
}

variable "graph_version" {
  description = "Version of the device compliance script"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceComplianceScript"
  nullable    = false
}

variable "platform" {
  description = "Indicates the device platform on which the device compliance script will be executed. Possible values are: windows10AndLater (default), linux. The default value is windows10AndLater."
  type        = any
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["windows10", "linux", "macOS", "unknownFutureValue"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "publisher" {
  description = "Name of the device compliance script publisher"
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tag IDs for the device compliance script"
  type        = list(string)
  default     = null
}

variable "run_as32_bit" {
  description = "Indicate whether PowerShell script(s) should run as 32-bit"
  type        = bool
  default     = null
}

variable "run_as_account" {
  description = "Indicates the type of execution context the app runs in."
  type        = string
  default     = null

  validation {
    condition     = var.run_as_account == null ? true : contains(["system", "user"], var.run_as_account)
    error_message = "run_as_account must be one of the documented enum values."
  }
}

variable "run_summary" {
  description = "High level run summary for device compliance script."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
