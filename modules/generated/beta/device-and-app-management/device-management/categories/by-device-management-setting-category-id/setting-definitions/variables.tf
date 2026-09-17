variable "device_management_setting_category_id" {
  description = "The unique identifier of deviceManagementSettingCategory"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_setting_category_id)) > 0
    error_message = "device_management_setting_category_id must not be empty."
  }
}

variable "constraints" {
  description = "Collection of constraints for the setting value"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementConstraint")
  }))
  default = null
}

variable "dependencies" {
  description = "Collection of dependencies on other settings"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementSettingDependency")
    constraints = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.deviceManagementConstraint")
    })))
    definitionId = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The setting's description"
  type        = string
  default     = null
}

variable "display_name" {
  description = "The setting's display name"
  type        = string
  default     = null
}

variable "documentation_url" {
  description = "Url to setting documentation"
  type        = string
  default     = null
}

variable "header_subtitle" {
  description = "subtitle of the setting header for more details about the category/section"
  type        = string
  default     = null
}

variable "header_title" {
  description = "title of the setting header represents a category/section of a setting/settings"
  type        = string
  default     = null
}

variable "is_top_level" {
  description = "If the setting is top level, it can be configured without the need to be wrapped in a collection or complex setting"
  type        = bool
  default     = null
}

variable "keywords" {
  description = "Keywords associated with the setting"
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementSettingDefinition"
  nullable    = false
}

variable "placeholder_text" {
  description = "Placeholder text as an example of valid input"
  type        = string
  default     = null
}

variable "value_type" {
  description = "Microsoft Graph valueType property."
  type        = string
  default     = null

  validation {
    condition     = var.value_type == null ? true : contains(["integer", "boolean", "string", "complex", "collection", "abstractComplex"], var.value_type)
    error_message = "value_type must be one of the documented enum values."
  }
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
