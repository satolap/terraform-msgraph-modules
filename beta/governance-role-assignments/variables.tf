variable "assignment_state" {
  description = "The state of the assignment. The value can be Eligible for eligible assignment or Active if it's directly assigned Active by administrators, or activated on an eligible assignment by the users."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "For a non-permanent role assignment, this is the time when the role assignment is expired. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "external_id" {
  description = "The external ID the resource that is used to identify the role assignment in the provider."
  type        = string
  default     = null
}

variable "linked_eligible_role_assignment_id" {
  description = "If this is an active assignment and created due to activation on an eligible assignment, it represents the ID of that eligible assignment; Otherwise, the value is null."
  type        = string
  default     = null
}

variable "member_type" {
  description = "The type of member. The value can be: Inherited (if the role assignment is inherited from a parent resource scope), Group (if the role assignment isn't inherited, but comes from the membership of a group assignment), or User (if the role assignment isn't inherited or from a group assignment)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceRoleAssignment"
  nullable    = false
}

variable "resource_id" {
  description = "Required. The ID of the resource that the role assignment is associated with."
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "Required. The ID of the role definition that the role assignment is associated with."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "The start time of the role assignment. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null
}

variable "subject_id" {
  description = "Required. The ID of the subject that the role assignment is associated with."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "linkedEligibleRoleAssignment", "resource", "roleDefinition", "subject"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
