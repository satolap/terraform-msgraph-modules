variable "active_occurrence_status" {
  description = "The status of the active occurence of the schedule if one exists. The possible values are: grantingFailed, granted, granting, revoked, revoking, revokingFailed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.active_occurrence_status == null ? true : contains(["grantingFailed", "granted", "granting", "revoked", "revoking", "revokingFailed", "unknownFutureValue"], var.active_occurrence_status)
    error_message = "active_occurrence_status must be one of the documented enum values."
  }
}

variable "modification_date_time" {
  description = "Time when the change occurred."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permissionsRequestChange"
  nullable    = false
}

variable "permissions_request_id" {
  description = "The ID of the scheduledPermissionsRequest object."
  type        = string
  default     = null
}

variable "status_detail" {
  description = "Microsoft Graph statusDetail property."
  type        = string
  default     = null

  validation {
    condition     = var.status_detail == null ? true : contains(["submitted", "approved", "completed", "canceled", "rejected", "unknownFutureValue"], var.status_detail)
    error_message = "status_detail must be one of the documented enum values."
  }
}

variable "ticket_id" {
  description = "Represents the ticketing system identifier."
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
