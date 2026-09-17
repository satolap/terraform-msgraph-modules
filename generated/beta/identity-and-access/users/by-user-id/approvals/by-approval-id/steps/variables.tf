variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "approval_id" {
  description = "The unique identifier of approval"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.approval_id)) > 0
    error_message = "approval_id must not be empty."
  }
}

variable "justification" {
  description = "The justification associated with the approval step decision."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.approvalStep"
  nullable    = false
}

variable "review_result" {
  description = "The result of this approval record. Possible values include: NotReviewed, Approved, Denied."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignedToMe", "displayName", "id", "reviewedBy", "reviewedDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
