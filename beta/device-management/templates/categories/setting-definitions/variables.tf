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

variable "constraints" {
  description = "Collection of constraints for the setting value"
  type        = any
  default     = null
}

variable "dependencies" {
  description = "Collection of dependencies on other settings"
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.deviceManagementSettingDependency")
    constraints  = optional(any)
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
  description = "The data type of the value"
  type        = string
  default     = null

  validation {
    condition     = var.value_type == null ? true : contains(["integer", "boolean", "string", "complex", "collection", "abstractComplex"], var.value_type)
    error_message = "value_type must be one of the documented enum values."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
