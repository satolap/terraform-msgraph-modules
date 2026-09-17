variable "allotment" {
  description = "The allotment from which licenses are assigned. Not nullable."
  type        = any
  default     = null
}

variable "assigned_to" {
  description = "Microsoft Graph assignedTo property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  })
  default = null
}

variable "disabled_service_plan_ids" {
  description = "The list of disabled service plans for this assignment. Not nullable."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudLicensing.assignment"
  nullable    = false
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
