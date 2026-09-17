variable "assignments" {
  description = "The list of assignments for the device configuration profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementResourceAccessProfileAssignment")
    intent     = optional(string)
    sourceId   = optional(string)
    target = optional(object({
      odata_type                                 = optional(string, "#microsoft.graph.deviceAndAppManagementAssignmentTarget")
      deviceAndAppManagementAssignmentFilterId   = optional(string)
      deviceAndAppManagementAssignmentFilterType = optional(string)
    }))
  }))
  default = null
}

variable "creation_date_time" {
  description = "DateTime profile was created"
  type        = string
  default     = null
}

variable "description" {
  description = "Profile description"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Profile display name"
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the profile"
  type        = number
  default     = null
}

variable "last_modified_date_time" {
  description = "DateTime profile was last modified"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementResourceAccessProfileBase"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "Scope Tags"
  type        = list(string)
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
