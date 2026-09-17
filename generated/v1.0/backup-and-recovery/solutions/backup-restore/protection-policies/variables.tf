variable "created_by" {
  description = "The identity of person who created the policy."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time of creation of the policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the policy to be created."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "Microsoft Graph isEnabled property."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the person who last modified the policy."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The timestamp of the last modification of the policy."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.protectionPolicyBase"
  nullable    = false
}

variable "protection_policy_artifact_count" {
  description = "Microsoft Graph protectionPolicyArtifactCount property."
  type        = any
  default     = null
}

variable "retention_settings" {
  description = "Contains the retention setting details for the policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.retentionSetting")
    interval   = optional(string)
    period     = optional(string)
  }))
  default = null
}

variable "status" {
  description = "The aggregated status of the protection units associated with the policy. The possible values are: inactive, activeWithErrors, updating, active, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["inactive", "activeWithErrors", "updating", "active", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
