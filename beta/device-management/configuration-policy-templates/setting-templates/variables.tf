variable "device_management_configuration_policy_template_id" {
  description = "The unique identifier of deviceManagementConfigurationPolicyTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_configuration_policy_template_id)) > 0
    error_message = "device_management_configuration_policy_template_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationSettingTemplate"
  nullable    = false
}

variable "setting_definitions" {
  description = "List of related Setting Definitions"
  type        = any
  default     = null
}

variable "setting_instance_template" {
  description = "Setting Instance Template"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
