variable "managed_device_id" {
  description = "The unique identifier of managedDevice"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_device_id)) > 0
    error_message = "managed_device_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.assignmentFilterEvaluationStatusDetails"
  nullable    = false
}

variable "payload_id" {
  description = "PayloadId on which filter has been applied."
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
