variable "device_management_template_id" {
  description = "The unique identifier of deviceManagementTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_template_id)) > 0
    error_message = "device_management_template_id must not be empty."
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

variable "display_name" {
  description = "The template's display name"
  type        = string
  default     = null
}

variable "intent_count" {
  description = "Number of Intents created from this template."
  type        = number
  default     = null
}

variable "is_deprecated" {
  description = "The template is deprecated or not. Intents cannot be created from a deprecated template."
  type        = bool
  default     = null
}

variable "migratable_to" {
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

variable "platform_type" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platform_type == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "windows10XProfile", "androidAOSP", "all"], var.platform_type)
    error_message = "platform_type must be one of the documented enum values."
  }
}

variable "published_date_time" {
  description = "When the template was published"
  type        = string
  default     = null
}

variable "settings" {
  description = "Collection of all settings this template has"
  type        = any
  default     = null
}

variable "template_subtype" {
  description = "Template subtype"
  type        = string
  default     = null

  validation {
    condition     = var.template_subtype == null ? true : contains(["none", "firewall", "diskEncryption", "attackSurfaceReduction", "endpointDetectionReponse", "accountProtection", "antivirus", "firewallSharedAppList", "firewallSharedIpList", "firewallSharedPortlist"], var.template_subtype)
    error_message = "template_subtype must be one of the documented enum values."
  }
}

variable "template_type" {
  description = "Template type"
  type        = string
  default     = null

  validation {
    condition     = var.template_type == null ? true : contains(["securityBaseline", "specializedDevices", "advancedThreatProtectionSecurityBaseline", "deviceConfiguration", "custom", "securityTemplate", "microsoftEdgeSecurityBaseline", "microsoftOffice365ProPlusSecurityBaseline", "deviceCompliance", "deviceConfigurationForOffice365", "cloudPC", "firewallSharedSettings"], var.template_type)
    error_message = "template_type must be one of the documented enum values."
  }
}

variable "version_info" {
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
