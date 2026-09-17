variable "approval_settings" {
  description = "The list of approval settings for this policy. The maximun number of approval settings supported for one policy is 6. The expected number of approval settings for one policy from UX is 4."
  type = list(object({
    odata_type                   = optional(string, "#microsoft.graph.windowsQualityUpdateApprovalSetting")
    approvalMethodType           = optional(string)
    deferredDeploymentInDay      = optional(number)
    windowsQualityUpdateCadence  = optional(string)
    windowsQualityUpdateCategory = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "List of the groups this profile is assgined to."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsQualityUpdatePolicyAssignment")
    target = optional(object({
      odata_type                                 = optional(string, "#microsoft.graph.deviceAndAppManagementAssignmentTarget")
      deviceAndAppManagementAssignmentFilterId   = optional(string)
      deviceAndAppManagementAssignmentFilterType = optional(string)
    }))
  }))
  default = null
}

variable "description" {
  description = "The description of the policy which is specified by the user. Max allowed length is 1500 chars."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the policy. Max allowed length is 200 chars."
  type        = string
  default     = null
}

variable "hotpatch_enabled" {
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

variable "role_scope_tag_ids" {
  description = "List of the scope tag ids for this profile."
  type        = list(string)
  default     = null
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
