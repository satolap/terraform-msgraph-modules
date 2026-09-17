variable "external_connection_id" {
  description = "The unique identifier of externalConnection"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.external_connection_id)) > 0
    error_message = "external_connection_id must not be empty."
  }
}

variable "error" {
  description = "If status is failed, provides more information about the error that caused the failure."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalConnectors.connectionOperation"
  nullable    = false
}

variable "status" {
  description = "Indicates the status of the asynchronous operation. The possible values are: unspecified, inprogress, completed, failed."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unspecified", "inprogress", "completed", "failed", "unknownFutureValue"], var.status)
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
