variable "approval_workflow_provider_id" {
  description = "The unique identifier of approvalWorkflowProvider"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.approval_workflow_provider_id)) > 0
    error_message = "approval_workflow_provider_id must not be empty."
  }
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governancePolicyTemplate"
  nullable    = false
}

variable "policy" {
  description = "Microsoft Graph policy property."
  type        = any
  default     = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
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
