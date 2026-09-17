variable "assignments" {
  description = "A list of the Entra user group ids that hardware configuration will be applied to. Only security groups and Office 365 Groups are supported. Optional."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.hardwareConfigurationAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "configuration_file_content" {
  description = "The file content contains custom hardware settings that will be applied to the assigned devices' BIOS. Max allowed file size is 5KB. Represented as bytes. Required."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the hardware configuration. Use this to provide context, purpose, applications, etc of the BIOS configuration profile for your organization's admins. Max length is 1000 characters. Optional."
  type        = string
  default     = null
}

variable "file_name" {
  description = "The file name for the BIOS configuration profile's ConfigurationFileContent. Max length is 150 characters. Required."
  type        = string
  default     = null
}

variable "hardware_configuration_format" {
  description = "Indicates the supported oems of hardware configuration"
  type        = string
  default     = null

  validation {
    condition     = var.hardware_configuration_format == null ? true : contains(["dell", "surface", "surfaceDock"], var.hardware_configuration_format)
    error_message = "hardware_configuration_format must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.hardwareConfiguration"
  nullable    = false
}

variable "per_device_password_disabled" {
  description = "When TRUE, indicates whether the policy-assigned devices' passwords are disabled. When FALSE, indicates they are enabled. Default is FALSE. Required."
  type        = bool
  default     = null
  sensitive   = true
}

variable "role_scope_tag_ids" {
  description = "A list of unique Scope Tag IDs associated with the hardware configuration. Optional."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "deviceRunStates", "displayName", "id", "lastModifiedDateTime", "runSummary", "userRunStates", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
