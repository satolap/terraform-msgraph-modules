variable "allow_email_notification" {
  description = "Indicates whether email notification is enabled."
  type        = bool
  default     = null
}

variable "approval_type" {
  description = "The workflow type of the approval item. The possible values are: basic, basicAwaitAll, custom, customAwaitAll. Required."
  type        = any
  default     = null

  validation {
    condition     = var.approval_type == null ? true : contains(["basic", "basicAwaitAll", "custom", "customAwaitAll", "unknownFutureValue"], var.approval_type)
    error_message = "approval_type must be one of the documented enum values."
  }
}

variable "approvers" {
  description = "The identity of the principals to whom the approval item was initially assigned. Required."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.approvalIdentitySet")
    application = optional(any)
    device      = optional(any)
    group       = optional(any)
    user        = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The description of the approval request."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The displayName of the approval request. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.approvalItem"
  nullable    = false
}

variable "requests" {
  description = "A collection of requests created for each approver on the approval item."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.approvalItemRequest")
  }))
  default = null
}

variable "response_prompts" {
  description = "Approval response prompts. Only provide a value for this property when creating a custom approval item. For custom approval items, supply two response prompt strings. The default response prompts are 'Approve' and 'Reject'."
  type        = list(string)
  default     = null
}

variable "responses" {
  description = "A collection of responses created for the approval item."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.approvalItemResponse")
    comments   = optional(string)
    createdBy  = optional(any)
    response   = optional(string)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["allowCancel", "completedDateTime", "createdDateTime", "id", "owner", "result", "state", "viewPoint"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
