variable "created_by" {
  description = "The identity of person who created the rule."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time of creation of the rule."
  type        = string
  default     = null
}

variable "drive_expression" {
  description = "Contains a drive expression. For examples, see driveExpression examples."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains error details if an operation on a rule fails."
  type        = any
  default     = null
}

variable "is_auto_apply_enabled" {
  description = "true indicates that the protection rule is dynamic; false that it's static."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the person who last modified the rule."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of the last modification made to the rule."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.driveProtectionRule"
  nullable    = false
}

variable "status" {
  description = "The status of the protection rule. The possible values are: draft, active, completed, completedWithErrors, unknownFutureValue, updateRequested, deleteRequested. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: updateRequested , deleteRequested. The draft member is currently unsupported."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["draft", "active", "completed", "completedWithErrors", "unknownFutureValue", "updateRequested", "deleteRequested"], var.status)
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
