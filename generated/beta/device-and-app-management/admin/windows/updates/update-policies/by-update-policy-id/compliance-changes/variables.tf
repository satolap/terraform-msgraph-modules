variable "update_policy_id" {
  description = "The unique identifier of updatePolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.update_policy_id)) > 0
    error_message = "update_policy_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The date and time when a compliance change was created."
  type        = string
  default     = null
}

variable "is_revoked" {
  description = "True indicates that a compliance change is revoked, preventing further application. Revoking a compliance change is a final action."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.complianceChange"
  nullable    = false
}

variable "revoked_date_time" {
  description = "The date and time when the compliance change was revoked."
  type        = string
  default     = null
}

variable "update_policy" {
  description = "The policy this compliance change is a member of."
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
