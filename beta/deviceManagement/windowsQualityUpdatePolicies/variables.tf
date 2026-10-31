variable "approvalSettings" {
  description = "The list of approval settings for this policy. The maximun number of approval settings supported for one policy is 6. The expected number of approval settings for one policy from UX is 4."
  type = list(object({
    odata_type                   = optional(string, "#microsoft.graph.windowsQualityUpdateApprovalSetting")
    approvalMethodType           = optional(string)
    deferredDeploymentInDay      = optional(number)
    windowsQualityUpdateCadence  = optional(string)
    windowsQualityUpdateCategory = optional(string)
  }))
  default = null

  validation {
    condition     = (var.approvalSettings == null ? true : alltrue([alltrue([for input0 in var.approvalSettings : (input0 == null ? true : alltrue([(input0["approvalMethodType"] == null ? true : alltrue([(input0["approvalMethodType"] == null ? true : contains(["manual", "automatic"], input0["approvalMethodType"]))])), (input0["windowsQualityUpdateCadence"] == null ? true : alltrue([(input0["windowsQualityUpdateCadence"] == null ? true : contains(["monthly", "outOfBand"], input0["windowsQualityUpdateCadence"]))])), (input0["windowsQualityUpdateCategory"] == null ? true : alltrue([(input0["windowsQualityUpdateCategory"] == null ? true : contains(["all", "security", "nonSecurity"], input0["windowsQualityUpdateCategory"]))]))]))])]))
    error_message = "approvalSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "assignments" {
  description = "List of the groups this profile is assgined to."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsQualityUpdatePolicyAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The description of the policy which is specified by the user. Max allowed length is 1500 chars."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name for the policy. Max allowed length is 200 chars."
  type        = string
  default     = null
}

variable "hotpatchEnabled" {
  description = "Indicates if hotpatch is enabled for the tenants. When 'true', tenant can apply quality updates without rebooting their devices. When 'false', tenant devices will receive cold patch associated with Windows quality updates."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsQualityUpdatePolicy"
  nullable    = false
}

variable "roleScopeTagIds" {
  description = "List of the scope tag ids for this profile."
  type        = list(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
