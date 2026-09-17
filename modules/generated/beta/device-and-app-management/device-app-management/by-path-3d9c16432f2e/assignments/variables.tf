variable "windows_defender_application_control_supplemental_policy_id" {
  description = "The unique identifier of windowsDefenderApplicationControlSupplementalPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.windows_defender_application_control_supplemental_policy_id)) > 0
    error_message = "windows_defender_application_control_supplemental_policy_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsDefenderApplicationControlSupplementalPolicyAssignment"
  nullable    = false
}

variable "target" {
  description = "The target group assignment defined by the admin."
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
