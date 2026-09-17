variable "managed_e_book_id" {
  description = "The unique identifier of managedEBook"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_e_book_id)) > 0
    error_message = "managed_e_book_id must not be empty."
  }
}

variable "install_intent" {
  description = "Possible values for the install intent chosen by the admin."
  type        = string
  default     = null

  validation {
    condition     = var.install_intent == null ? true : contains(["available", "required", "uninstall", "availableWithoutEnrollment"], var.install_intent)
    error_message = "install_intent must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedEBookAssignment"
  nullable    = false
}

variable "target" {
  description = "The assignment target for eBook."
  type        = any
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
