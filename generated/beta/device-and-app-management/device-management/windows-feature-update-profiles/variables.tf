variable "assignments" {
  description = "The list of group assignments of the profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsFeatureUpdateProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date time that the profile was created."
  type        = string
  default     = null
}

variable "deployable_content_display_name" {
  description = "Friendly display name of the quality update profile deployable content"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the profile which is specified by the user."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the profile."
  type        = string
  default     = null
}

variable "end_of_support_date" {
  description = "The last supported date for a feature update"
  type        = string
  default     = null
}

variable "feature_update_version" {
  description = "The feature update version that will be deployed to the devices targeted by this profile. The version could be any supported version for example 1709, 1803 or 1809 and so on."
  type        = string
  default     = null
}

variable "install_feature_updates_optional" {
  description = "If true, the Windows 11 update will become optional"
  type        = bool
  default     = null
}

variable "install_latest_windows10_on_windows11_ineligible_device" {
  description = "If true, the latest Microsoft Windows 10 update will be installed on devices ineligible for Microsoft Windows 11"
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
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

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Feature Update entity."
  type        = list(string)
  default     = null
}

variable "rollout_settings" {
  description = "The windows update rollout settings, including offer start date time, offer end date time, and days between each set of offers."
  type        = any
  default     = null
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
