variable "device_management_template_id" {
  description = "The unique identifier of deviceManagementTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_template_id)) > 0
    error_message = "device_management_template_id must not be empty."
  }
}

variable "device_management_template_id1" {
  description = "The unique identifier of deviceManagementTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_template_id1)) > 0
    error_message = "device_management_template_id1 must not be empty."
  }
}

variable "display_name" {
  description = "The category name"
  type        = string
  default     = null
}

variable "has_required_setting" {
  description = "The category contains top level required setting"
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementTemplateSettingCategory"
  nullable    = false
}

variable "recommended_settings" {
  description = "The settings this category contains"
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.deviceManagementSettingInstance")
    definitionId = optional(string)
    valueJson    = optional(string)
  }))
  default = null
}

variable "setting_definitions" {
  description = "The setting definitions this category contains"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementSettingDefinition")
    constraints = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.deviceManagementConstraint")
    })))
    dependencies = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.deviceManagementSettingDependency")
      constraints  = optional(any)
      definitionId = optional(string)
    })))
    description      = optional(string)
    displayName      = optional(string)
    documentationUrl = optional(string)
    headerSubtitle   = optional(string)
    headerTitle      = optional(string)
    isTopLevel       = optional(bool)
    keywords         = optional(list(string))
    placeholderText  = optional(string)
    valueType        = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
