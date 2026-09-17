variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegeManagementElevationRequest"
  nullable    = false
}

variable "reviewer_justification" {
  description = "An optional justification provided by approver at approval or denied time. This field will be String.Empty if approver decides to not provide a justification. For example: 'Run this installer today'"
  type        = string
  default     = null
}

variable "status" {
  description = "Indicates state of elevation request"
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["none", "pending", "approved", "denied", "expired", "unknownFutureValue", "revoked", "completed"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["applicationDetail", "deviceName", "id", "requestCreatedDateTime", "requestExpiryDateTime", "requestJustification", "requestLastModifiedDateTime", "requestedByUserId", "requestedByUserPrincipalName", "requestedOnDeviceId", "reviewCompletedByUserId", "reviewCompletedByUserPrincipalName", "reviewCompletedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
