variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.resourceConnection"
  nullable    = false
}

variable "state" {
  description = "The state of the connection. The possible values are: connected, notAuthorized, notFound, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["connected", "notAuthorized", "notFound", "unknownFutureValue"], var.state)
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
