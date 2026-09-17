variable "access_package_assignment_id" {
  description = "The unique identifier of accessPackageAssignment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_assignment_id)) > 0
    error_message = "access_package_assignment_id must not be empty."
  }
}

variable "custom_extension" {
  description = "Indicates the custom workflow extension that is executed at this stage. Nullable. Supports $expand."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.customExtensionStageSetting"
  nullable    = false
}

variable "stage" {
  description = "Microsoft Graph stage property."
  type        = string
  default     = null

  validation {
    condition     = var.stage == null ? true : contains(["assignmentRequestCreated", "assignmentRequestApproved", "assignmentRequestGranted", "assignmentRequestRemoved", "assignmentFourteenDaysBeforeExpiration", "assignmentOneDayBeforeExpiration", "unknownFutureValue"], var.stage)
    error_message = "stage must be one of the documented enum values."
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
