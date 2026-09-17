variable "assignments" {
  description = "The list of group assignments for the device management script."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementScriptAssignment")
    target     = optional(any)
  }))
  default = null
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
}

variable "display_name" {
  description = "Name of the device management script."
  type        = string
  default     = null
}

variable "enforce_signature_check" {
  description = "Indicate whether the script signature needs be checked."
  type        = bool
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
  default     = "#microsoft.graph.deviceManagementScript"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tag IDs for this PowerShellScript instance."
  type        = list(string)
  default     = null
}

variable "run_as32_bit" {
  description = "A value indicating whether the PowerShell script should run as 32-bit"
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
