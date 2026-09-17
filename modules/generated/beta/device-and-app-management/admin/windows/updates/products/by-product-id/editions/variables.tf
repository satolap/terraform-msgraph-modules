variable "product_id" {
  description = "The unique identifier of product"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.product_id)) > 0
    error_message = "product_id must not be empty."
  }
}

variable "device_family" {
  description = "The device family targeted by the edition."
  type        = string
  default     = null
}

variable "is_in_service" {
  description = "Indicates whether the edition is in service or out of service."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.edition"
  nullable    = false
}

variable "servicing_periods" {
  description = "Microsoft Graph servicingPeriods property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsUpdates.servicingPeriod")
    name       = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["endOfServiceDateTime", "generalAvailabilityDateTime", "id", "name", "releasedName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
