variable "assignments" {
  description = "The list of group assignments of the profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsFeatureUpdateProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "createdDateTime" {
  description = "The date time that the profile was created."
  type        = string
  default     = null
}

variable "deployableContentDisplayName" {
  description = "Friendly display name of the quality update profile deployable content"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the profile which is specified by the user."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the profile."
  type        = string
  default     = null
}

variable "endOfSupportDate" {
  description = "The last supported date for a feature update"
  type        = string
  default     = null
}

variable "featureUpdateVersion" {
  description = "The feature update version that will be deployed to the devices targeted by this profile. The version could be any supported version for example 1709, 1803 or 1809 and so on."
  type        = string
  default     = null
}

variable "installFeatureUpdatesOptional" {
  description = "If true, the Windows 11 update will become optional"
  type        = bool
  default     = null
}

variable "installLatestWindows10OnWindows11IneligibleDevice" {
  description = "If true, the latest Microsoft Windows 10 update will be installed on devices ineligible for Microsoft Windows 11"
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date time that the profile was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsFeatureUpdateProfile"
  nullable    = false
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this Feature Update entity."
  type        = list(string)
  default     = null
}

variable "rolloutSettings" {
  description = "The windows update rollout settings, including offer start date time, offer end date time, and days between each set of offers."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.windowsUpdateRolloutSettings")
    offerEndDateTimeInUTC   = optional(string)
    offerIntervalInDays     = optional(number)
    offerStartDateTimeInUTC = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
