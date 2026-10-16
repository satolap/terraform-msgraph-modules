variable "windows_feature_update_profile_id" {
  description = "The unique identifier of windowsFeatureUpdateProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.windows_feature_update_profile_id)) > 0
    error_message = "windows_feature_update_profile_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsFeatureUpdateProfileAssignment"
  nullable    = false
}

variable "target" {
  description = "The assignment target that the feature update profile is assigned to."
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
