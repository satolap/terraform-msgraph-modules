variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "managed_device_id" {
  description = "The unique identifier of managedDevice"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_device_id)) > 0
    error_message = "managed_device_id must not be empty."
  }
}

variable "display_name" {
  description = "The name of the policy for this policyBase"
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version of the policy"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceConfigurationState"
  nullable    = false
}

variable "platform_type" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platform_type == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "windows10XProfile", "androidAOSP", "all"], var.platform_type)
    error_message = "platform_type must be one of the documented enum values."
  }
}

variable "setting_count" {
  description = "Count of how many setting a policy holds"
  type        = number
  default     = null
}

variable "setting_states" {
  description = "Microsoft Graph settingStates property."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.deviceConfigurationSettingState")
    currentValue        = optional(string)
    errorCode           = optional(number)
    errorDescription    = optional(string)
    instanceDisplayName = optional(string)
    setting             = optional(string)
    settingInstanceId   = optional(string)
    settingName         = optional(string)
    sources = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.settingSource")
      displayName = optional(string)
      id          = optional(string)
      sourceType  = optional(string)
    })))
    state             = optional(string)
    userEmail         = optional(string)
    userId            = optional(string)
    userName          = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_id_2" {
  description = "User unique identifier, must be Guid"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User Principal Name"
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
