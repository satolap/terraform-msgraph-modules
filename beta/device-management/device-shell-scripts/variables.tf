variable "assignments" {
  description = "The list of group assignments for the device management script."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementScriptAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "block_execution_notifications" {
  description = "Does not notify the user a script is being executed"
  type        = bool
  default     = null
}

variable "description" {
  description = "Optional description for the device management script."
  type        = string
  default     = null
}

variable "device_run_states" {
  description = "List of run states for this script across all devices."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.deviceManagementScriptDeviceState")
    errorCode               = optional(number)
    errorDescription        = optional(string)
    lastStateUpdateDateTime = optional(string)
    managedDevice           = optional(any)
    resultMessage           = optional(string)
    runState                = optional(string)
  }))
  default = null

  validation {
    condition     = (var.device_run_states == null ? true : alltrue([alltrue([for input0 in var.device_run_states : (input0 == null ? true : alltrue([(input0["runState"] == null ? true : alltrue([(input0["runState"] == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], input0["runState"]))]))]))])]))
    error_message = "device_run_states: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "display_name" {
  description = "Name of the device management script."
  type        = string
  default     = null
}

variable "execution_frequency" {
  description = "The interval for script to run. If not defined the script will run once"
  type        = string
  default     = null
}

variable "file_name" {
  description = "Script file name."
  type        = string
  default     = null
}

variable "group_assignments" {
  description = "The list of group assignments for the device management script."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.deviceManagementScriptGroupAssignment")
    targetGroupId = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceShellScript"
  nullable    = false
}

variable "retry_count" {
  description = "Number of times for the script to be retried if it fails"
  type        = number
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tag IDs for this PowerShellScript instance."
  type        = list(string)
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
  description = "Run summary for device management script."
  type        = any
  default     = null
}

variable "script_content" {
  description = "The script content."
  type        = string
  default     = null
}

variable "user_run_states" {
  description = "List of run states for this script across all users."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementScriptUserState")
    deviceRunStates = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.deviceManagementScriptDeviceState")
      errorCode               = optional(number)
      errorDescription        = optional(string)
      lastStateUpdateDateTime = optional(string)
      managedDevice           = optional(any)
      resultMessage           = optional(string)
      runState                = optional(string)
    })))
    errorDeviceCount   = optional(number)
    successDeviceCount = optional(number)
    userPrincipalName  = optional(string)
  }))
  default = null

  validation {
    condition     = (var.user_run_states == null ? true : alltrue([alltrue([for input0 in var.user_run_states : (input0 == null ? true : alltrue([(input0["deviceRunStates"] == null ? true : alltrue([alltrue([for input2 in input0["deviceRunStates"] : (input2 == null ? true : alltrue([(input2["runState"] == null ? true : alltrue([(input2["runState"] == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], input2["runState"]))]))]))])]))]))])]))
    error_message = "user_run_states: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
