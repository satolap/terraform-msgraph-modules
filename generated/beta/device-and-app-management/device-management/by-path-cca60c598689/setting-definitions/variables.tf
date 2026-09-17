variable "device_management_configuration_policy_template_id" {
  description = "The unique identifier of deviceManagementConfigurationPolicyTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_configuration_policy_template_id)) > 0
    error_message = "device_management_configuration_policy_template_id must not be empty."
  }
}

variable "device_management_configuration_setting_template_id" {
  description = "The unique identifier of deviceManagementConfigurationSettingTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_configuration_setting_template_id)) > 0
    error_message = "device_management_configuration_setting_template_id must not be empty."
  }
}

variable "access_types" {
  description = "Microsoft Graph accessTypes property."
  type        = string
  default     = null

  validation {
    condition     = var.access_types == null ? true : contains(["none", "add", "copy", "delete", "get", "replace", "execute"], var.access_types)
    error_message = "access_types must be one of the documented enum values."
  }
}

variable "applicability" {
  description = "Details which device setting is applicable on. Supports: $filters."
  type        = any
  default     = null
}

variable "base_uri" {
  description = "Base CSP Path"
  type        = string
  default     = null
}

variable "category_id" {
  description = "Specify category in which the setting is under. Support $filters."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the setting."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the setting. For example: Allow Toast."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Item Version"
  type        = string
  default     = null
}

variable "help_text" {
  description = "Help text of the setting. Give more details of the setting."
  type        = string
  default     = null
}

variable "info_urls" {
  description = "List of links more info for the setting can be found at."
  type        = list(string)
  default     = null
}

variable "keywords" {
  description = "Tokens which to search settings on"
  type        = list(string)
  default     = null
}

variable "name" {
  description = "Name of the item"
  type        = string
  default     = null
}

variable "occurrence" {
  description = "Indicates whether the setting is required or not"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationSettingDefinition"
  nullable    = false
}

variable "offset_uri" {
  description = "Offset CSP Path from Base"
  type        = string
  default     = null
}

variable "referred_setting_information_list" {
  description = "List of referred setting information."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.deviceManagementConfigurationReferredSettingInformation")
    settingDefinitionId = optional(string)
  }))
  default = null
}

variable "risk_level" {
  description = "Setting RiskLevel"
  type        = string
  default     = null

  validation {
    condition     = var.risk_level == null ? true : contains(["low", "medium", "high"], var.risk_level)
    error_message = "risk_level must be one of the documented enum values."
  }
}

variable "root_definition_id" {
  description = "Root setting definition id if the setting is a child setting."
  type        = string
  default     = null
}

variable "setting_usage" {
  description = "Supported setting types"
  type        = string
  default     = null

  validation {
    condition     = var.setting_usage == null ? true : contains(["none", "configuration", "compliance", "reusableSetting", "unknownFutureValue"], var.setting_usage)
    error_message = "setting_usage must be one of the documented enum values."
  }
}

variable "ux_behavior" {
  description = "Setting control type representation in the UX"
  type        = string
  default     = null

  validation {
    condition     = var.ux_behavior == null ? true : contains(["default", "dropdown", "smallTextBox", "largeTextBox", "toggle", "multiheaderGrid", "contextPane", "unknownFutureValue"], var.ux_behavior)
    error_message = "ux_behavior must be one of the documented enum values."
  }
}

variable "visibility" {
  description = "Supported setting types"
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : contains(["none", "settingsCatalog", "template", "unknownFutureValue"], var.visibility)
    error_message = "visibility must be one of the documented enum values."
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
