variable "device_id" {
  description = "The unique identifier of device"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_id)) > 0
    error_message = "device_id must not be empty."
  }
}

variable "catalog_id" {
  description = "Product id corresponding to the usage right."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.usageRight"
  nullable    = false
}

variable "service_identifier" {
  description = "Identifier of the service corresponding to the usage right."
  type        = string
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["active", "inactive", "warning", "suspended", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
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
