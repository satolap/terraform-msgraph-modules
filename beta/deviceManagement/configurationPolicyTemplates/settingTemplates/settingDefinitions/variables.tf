variable "deviceManagementConfigurationPolicyTemplate-id" {
  description = "The unique identifier of deviceManagementConfigurationPolicyTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.deviceManagementConfigurationPolicyTemplate-id)) > 0
    error_message = "deviceManagementConfigurationPolicyTemplate-id must not be empty."
  }
}

variable "deviceManagementConfigurationSettingTemplate-id" {
  description = "The unique identifier of deviceManagementConfigurationSettingTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.deviceManagementConfigurationSettingTemplate-id)) > 0
    error_message = "deviceManagementConfigurationSettingTemplate-id must not be empty."
  }
}

variable "accessTypes" {
  description = "Read/write access mode of the setting"
  type        = string
  default     = null

  validation {
    condition     = var.accessTypes == null ? true : try(alltrue([for value in split(",", var.accessTypes) : contains(["none", "add", "copy", "delete", "get", "replace", "execute"], lower(trimspace(value)))]), false)
    error_message = "accessTypes must be one or more of the documented enum values, separated by commas."
  }
}

variable "applicability" {
  description = "Details which device setting is applicable on. Supports: $filters."
  type        = any
  default     = null
}

variable "baseUri" {
  description = "Base CSP Path"
  type        = string
  default     = null
}

variable "categoryId" {
  description = "Specify category in which the setting is under. Support $filters."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the setting."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Name of the setting. For example: Allow Toast."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Item Version"
  type        = string
  default     = null
}

variable "helpText" {
  description = "Help text of the setting. Give more details of the setting."
  type        = string
  default     = null
}

variable "infoUrls" {
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
  type = object({
    odata_type          = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingOccurrence")
    maxDeviceOccurrence = optional(number)
    minDeviceOccurrence = optional(number)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationSettingDefinition"
  nullable    = false
}

variable "offsetUri" {
  description = "Offset CSP Path from Base"
  type        = string
  default     = null
}

variable "referredSettingInformationList" {
  description = "List of referred setting information."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.deviceManagementConfigurationReferredSettingInformation")
    settingDefinitionId = optional(string)
  }))
  default = null
}

variable "riskLevel" {
  description = "Setting RiskLevel"
  type        = string
  default     = null

  validation {
    condition     = var.riskLevel == null ? true : try(alltrue([for value in split(",", var.riskLevel) : contains(["low", "medium", "high"], lower(trimspace(value)))]), false)
    error_message = "riskLevel must be one or more of the documented enum values, separated by commas."
  }
}

variable "rootDefinitionId" {
  description = "Root setting definition id if the setting is a child setting."
  type        = string
  default     = null
}

variable "settingUsage" {
  description = "Supported setting types"
  type        = string
  default     = null

  validation {
    condition     = var.settingUsage == null ? true : try(alltrue([for value in split(",", var.settingUsage) : contains(["none", "configuration", "compliance", "reusablesetting"], lower(trimspace(value)))]), false)
    error_message = "settingUsage must be one or more of the documented enum values, separated by commas."
  }
}

variable "uxBehavior" {
  description = "Setting control type representation in the UX"
  type        = string
  default     = null

  validation {
    condition     = var.uxBehavior == null ? true : contains(["default", "dropdown", "smallTextBox", "largeTextBox", "toggle", "multiheaderGrid", "contextPane"], var.uxBehavior)
    error_message = "uxBehavior must be one of the documented enum values."
  }
}

variable "visibility" {
  description = "Supported setting types"
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : try(alltrue([for value in split(",", var.visibility) : contains(["none", "settingscatalog", "template"], lower(trimspace(value)))]), false)
    error_message = "visibility must be one or more of the documented enum values, separated by commas."
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
