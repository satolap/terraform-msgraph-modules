variable "device_management_reusable_policy_setting_id" {
  description = "The unique identifier of deviceManagementReusablePolicySetting"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_reusable_policy_setting_id)) > 0
    error_message = "device_management_reusable_policy_setting_id must not be empty."
  }
}

variable "assignments" {
  description = "Policy assignments"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationPolicyAssignment")
    source     = optional(string)
    sourceId   = optional(string)
    target     = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["source"] == null ? true : alltrue([(input0["source"] == null ? true : contains(["direct", "policySets"], input0["source"]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "created_date_time" {
  description = "Policy creation date and time"
  type        = string
  default     = null
}

variable "creation_source" {
  description = "Policy creation source"
  type        = string
  default     = null
}

variable "description" {
  description = "Policy description"
  type        = string
  default     = null
}

variable "disable_entra_group_policy_assignment" {
  description = "Indicates whether Entra Group policy assignment is disabled"
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Policy last modification date and time"
  type        = string
  default     = null
}

variable "name" {
  description = "Policy name"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationPolicy"
  nullable    = false
}

variable "platforms" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platforms == null ? true : try(alltrue([for value in split(",", var.platforms) : contains(["none", "android", "ios", "macos", "windows10x", "windows10", "linux"], lower(trimspace(value)))]), false)
    error_message = "platforms must be one or more of the documented enum values, separated by commas."
  }
}

variable "priority_meta_data" {
  description = "Indicates the priority of each policies that are selected by the admin during enrollment process"
  type = object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementPriorityMetaData")
    priority   = optional(number)
  })
  default = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "setting_count" {
  description = "Number of settings"
  type        = number
  default     = null
}

variable "settings" {
  description = "Policy settings"
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.deviceManagementConfigurationSetting")
    settingInstance = optional(any)
  }))
  default = null
}

variable "technologies" {
  description = "Describes which technology this setting can be deployed with"
  type        = string
  default     = null

  validation {
    condition     = var.technologies == null ? true : try(alltrue([for value in split(",", var.technologies) : contains(["none", "mdm", "windows10xmanagement", "configmanager", "intunemanagementextension", "thirdparty", "documentgateway", "appleremotemanagement", "microsoftsense", "exchangeonline", "mobileapplicationmanagement", "linuxmdm", "enrollment", "endpointprivilegemanagement"], lower(trimspace(value)))]), false)
    error_message = "technologies must be one or more of the documented enum values, separated by commas."
  }
}

variable "template_reference" {
  description = "Template reference information"
  type = object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationPolicyTemplateReference")
    templateId = optional(string)
  })
  default = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isAssigned"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
