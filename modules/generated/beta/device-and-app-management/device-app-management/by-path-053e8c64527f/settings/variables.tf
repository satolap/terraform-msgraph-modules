variable "targeted_managed_app_configuration_id" {
  description = "The unique identifier of targetedManagedAppConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.targeted_managed_app_configuration_id)) > 0
    error_message = "targeted_managed_app_configuration_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationSetting"
  nullable    = false
}

variable "setting_instance" {
  description = "Setting instance within policy"
  type = object({
    odata_type                       = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingInstance")
    settingDefinitionId              = optional(string)
    settingInstanceTemplateReference = optional(any)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "settingDefinitions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
