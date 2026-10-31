variable "deviceManagementTemplate-id" {
  description = "The unique identifier of deviceManagementTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.deviceManagementTemplate-id)) > 0
    error_message = "deviceManagementTemplate-id must not be empty."
  }
}

variable "categories" {
  description = "Collection of setting categories within the template"
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.deviceManagementTemplateSettingCategory")
    displayName         = optional(string)
    hasRequiredSetting  = optional(bool)
    recommendedSettings = optional(any)
    settingDefinitions  = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The template's description"
  type        = string
  default     = null
}

variable "displayName" {
  description = "The template's display name"
  type        = string
  default     = null
}

variable "intentCount" {
  description = "Number of Intents created from this template."
  type        = number
  default     = null
}

variable "isDeprecated" {
  description = "The template is deprecated or not. Intents cannot be created from a deprecated template."
  type        = bool
  default     = null
}

variable "migratableTo" {
  description = "Collection of templates this template can migrate to"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementTemplate"
  nullable    = false
}

variable "platformType" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platformType == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "windows10XProfile", "androidAOSP", "all"], var.platformType)
    error_message = "platformType must be one of the documented enum values."
  }
}

variable "publishedDateTime" {
  description = "When the template was published"
  type        = string
  default     = null
}

variable "settings" {
  description = "Collection of all settings this template has"
  type        = any
  default     = null
}

variable "templateSubtype" {
  description = "Template subtype"
  type        = string
  default     = null

  validation {
    condition     = var.templateSubtype == null ? true : contains(["none", "firewall", "diskEncryption", "attackSurfaceReduction", "endpointDetectionReponse", "accountProtection", "antivirus", "firewallSharedAppList", "firewallSharedIpList", "firewallSharedPortlist"], var.templateSubtype)
    error_message = "templateSubtype must be one of the documented enum values."
  }
}

variable "templateType" {
  description = "Template type"
  type        = string
  default     = null

  validation {
    condition     = var.templateType == null ? true : contains(["securityBaseline", "specializedDevices", "advancedThreatProtectionSecurityBaseline", "deviceConfiguration", "custom", "securityTemplate", "microsoftEdgeSecurityBaseline", "microsoftOffice365ProPlusSecurityBaseline", "deviceCompliance", "deviceConfigurationForOffice365", "cloudPC", "firewallSharedSettings"], var.templateType)
    error_message = "templateType must be one of the documented enum values."
  }
}

variable "versionInfo" {
  description = "The template's version information"
  type        = string
  default     = null
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
