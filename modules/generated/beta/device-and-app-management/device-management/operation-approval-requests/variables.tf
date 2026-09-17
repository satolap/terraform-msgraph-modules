variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.operationApprovalRequest"
  nullable    = false
}

variable "status" {
  description = "Indicates the status of the Approval Request. The status of a request will change when an action is successfully performed on it, such as when it is `approved` or `rejected`, or when the request's expiration DateTime passes and the result is `expired`."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "needsApproval", "approved", "rejected", "cancelled", "completed", "expired", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["approvalJustification", "approver", "expirationDateTime", "id", "lastModifiedDateTime", "requestDateTime", "requestJustification", "requestor", "requiredOperationApprovalPolicyTypes"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
