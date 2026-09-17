variable "approval_duration" {
  description = "Microsoft Graph approvalDuration property."
  type        = string
  default     = null
}

variable "approval_state" {
  description = "Microsoft Graph approvalState property."
  type        = any
  default     = null

  validation {
    condition     = var.approval_state == null ? true : contains(["pending", "approved", "denied", "aborted", "canceled"], var.approval_state)
    error_message = "approval_state must be one of the documented enum values."
  }
}

variable "approval_type" {
  description = "Microsoft Graph approvalType property."
  type        = string
  default     = null
}

variable "approver_reason" {
  description = "Microsoft Graph approverReason property."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "Microsoft Graph endDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedApproval"
  nullable    = false
}

variable "request" {
  description = "Microsoft Graph request property."
  type        = any
  default     = null
}

variable "requestor_reason" {
  description = "Microsoft Graph requestorReason property."
  type        = string
  default     = null
}

variable "role_id" {
  description = "Microsoft Graph roleId property."
  type        = string
  default     = null
}

variable "role_info" {
  description = "Microsoft Graph roleInfo property."
  type        = any
  default     = null
}

variable "start_date_time" {
  description = "Microsoft Graph startDateTime property."
  type        = string
  default     = null
}

variable "user_id" {
  description = "Microsoft Graph userId property."
  type        = string
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
