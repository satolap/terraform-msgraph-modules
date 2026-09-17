variable "device_management_template_id" {
  description = "The unique identifier of deviceManagementTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_template_id)) > 0
    error_message = "device_management_template_id must not be empty."
  }
}

variable "device_management_template_setting_category_id" {
  description = "The unique identifier of deviceManagementTemplateSettingCategory"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_template_setting_category_id)) > 0
    error_message = "device_management_template_setting_category_id must not be empty."
  }
}

variable "definition_id" {
  description = "The ID of the setting definition for this instance"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementSettingInstance"
  nullable    = false
}

variable "value_json" {
  description = "JSON representation of the value"
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
