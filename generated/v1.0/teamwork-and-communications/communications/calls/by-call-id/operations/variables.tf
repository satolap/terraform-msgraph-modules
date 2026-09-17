variable "call_id" {
  description = "The unique identifier of call"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.call_id)) > 0
    error_message = "call_id must not be empty."
  }
}

variable "client_context" {
  description = "Unique Client Context string. Max limit is 256 chars."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.commsOperation"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["NotStarted", "Running", "Completed", "Failed"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "resultInfo"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
