variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "display_name" {
  description = "Display name of this group of settings, which comes from the associated template."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupSetting"
  nullable    = false
}

variable "values" {
  description = "Collection of name-value pairs corresponding to the name and defaultValue properties in the referenced groupSettingTemplates object."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.settingValue")
    name       = optional(string)
    value      = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "templateId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
