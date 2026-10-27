variable "assignments" {
  description = "The list of group assignments for the device health script"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceHealthScriptAssignment")
    runRemediationScript = optional(bool)
    runSchedule          = optional(any)
    target               = optional(any)
  }))
  default = null
}

variable "description" {
  description = "Description of the device health script"
  type        = string
  default     = null
}

variable "detection_script_content" {
  description = "The entire content of the detection powershell script"
  type        = string
  default     = null
}

variable "detection_script_parameters" {
  description = "List of ComplexType DetectionScriptParameters objects."
  type        = any
  default     = null
}

variable "device_health_script_type" {
  description = "Indicates the type of device script."
  type        = string
  default     = null

  validation {
    condition     = var.device_health_script_type == null ? true : contains(["deviceHealthScript", "managedInstallerScript"], var.device_health_script_type)
    error_message = "device_health_script_type must be one of the documented enum values."
  }
}

variable "device_run_states" {
  description = "List of run states for the device health script across all devices"
  type = list(object({
    odata_type                           = optional(string, "#microsoft.graph.deviceHealthScriptDeviceState")
    assignmentFilterIds                  = optional(list(string))
    detectionState                       = optional(string)
    expectedStateUpdateDateTime          = optional(string)
    lastStateUpdateDateTime              = optional(string)
    lastSyncDateTime                     = optional(string)
    managedDevice                        = optional(any)
    postRemediationDetectionScriptError  = optional(string)
    postRemediationDetectionScriptOutput = optional(string)
    preRemediationDetectionScriptError   = optional(string)
    preRemediationDetectionScriptOutput  = optional(string)
    remediationScriptError               = optional(string)
    remediationState                     = optional(string)
  }))
  default = null

  validation {
    condition     = (var.device_run_states == null ? true : alltrue([alltrue([for input0 in var.device_run_states : (input0 == null ? true : alltrue([(input0["detectionState"] == null ? true : alltrue([(input0["detectionState"] == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], input0["detectionState"]))])), (input0["remediationState"] == null ? true : alltrue([(input0["remediationState"] == null ? true : contains(["unknown", "skipped", "success", "remediationFailed", "scriptError"], input0["remediationState"]))]))]))])]))
    error_message = "device_run_states: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "display_name" {
  description = "Name of the device health script"
  type        = string
  default     = null
}

variable "enforce_signature_check" {
  description = "Indicate whether the script signature needs be checked"
  type        = bool
  default     = null
}

variable "graph_version" {
  description = "Version of the device health script"
  type        = string
  default     = null
}

variable "highest_available_version" {
  description = "Highest available version for a Microsoft Proprietary script"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceHealthScript"
  nullable    = false
}

variable "publisher" {
  description = "Name of the device health script publisher"
  type        = string
  default     = null
}

variable "remediation_script_content" {
  description = "The entire content of the remediation powershell script"
  type        = string
  default     = null
}

variable "remediation_script_parameters" {
  description = "List of ComplexType RemediationScriptParameters objects."
  type        = any
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tag IDs for the device health script"
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
  description = "High level run summary for device health script."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "isGlobalScript", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
