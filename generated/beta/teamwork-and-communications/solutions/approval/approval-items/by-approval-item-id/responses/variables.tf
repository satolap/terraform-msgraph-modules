variable "approval_item_id" {
  description = "The unique identifier of approvalItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.approval_item_id)) > 0
    error_message = "approval_item_id must not be empty."
  }
}

variable "comments" {
  description = "The comment made by the approver."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The identity set of the approver."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.approvalItemResponse"
  nullable    = false
}

variable "response" {
  description = "Approver response based on the response options. The default response options are 'Approved' and 'Rejected'. The approval item creator can also define custom response options during approval item creation."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "owners"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
