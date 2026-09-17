variable "device_management_resource_access_profile_base_id" {
  description = "The unique identifier of deviceManagementResourceAccessProfileBase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_resource_access_profile_base_id)) > 0
    error_message = "device_management_resource_access_profile_base_id must not be empty."
  }
}

variable "intent" {
  description = "The administrator intent for the assignment of the profile."
  type        = string
  default     = null

  validation {
    condition     = var.intent == null ? true : contains(["apply", "remove"], var.intent)
    error_message = "intent must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementResourceAccessProfileAssignment"
  nullable    = false
}

variable "source_id" {
  description = "The identifier of the source of the assignment."
  type        = string
  default     = null
}

variable "target" {
  description = "Base type for assignment targets."
  type = object({
    odata_type                                 = optional(string, "#microsoft.graph.deviceAndAppManagementAssignmentTarget")
    deviceAndAppManagementAssignmentFilterId   = optional(string)
    deviceAndAppManagementAssignmentFilterType = optional(string)
  })
  default = null
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
