variable "expiration_date_time" {
  description = "Expiration date time of the restore point."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.restorePoint"
  nullable    = false
}

variable "protection_date_time" {
  description = "Date time when the restore point was created."
  type        = string
  default     = null
}

variable "protection_unit" {
  description = "The site, drive, or mailbox unit protected under a protection policy. Supports $expand and $filter on protectionUnit/policyId using the eq operator."
  type        = any
  default     = null
}

variable "tags" {
  description = "The type of the restore point. The possible values are: none, fastRestore, unknownFutureValue, includeNewerItems. Use the Prefer: include-unknown-enum-members request header to get the following value in this evolvable enum: includeNewerItems."
  type        = any
  default     = null

  validation {
    condition     = var.tags == null ? true : contains(["none", "fastRestore", "unknownFutureValue", "includeNewerItems"], var.tags)
    error_message = "tags must be one of the documented enum values."
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
