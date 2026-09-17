variable "privileged_access_id" {
  description = "The unique identifier of privilegedAccess"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.privileged_access_id)) > 0
    error_message = "privileged_access_id must not be empty."
  }
}

variable "assignment_state" {
  description = "Required. The state of the assignment. The possible values are: Eligible (for eligible assignment),  Active (if it is directly assigned), Active (by administrators, or activated on an eligible assignment by the users)."
  type        = string
  default     = null
}

variable "linked_eligible_role_assignment_id" {
  description = "If this is a request for role activation, it represents the id of the eligible assignment being referred; Otherwise, the value is null."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceRoleAssignmentRequest"
  nullable    = false
}

variable "reason" {
  description = "A message provided by users and administrators when create the request about why it is needed."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "Required. The unique identifier of the Azure resource that is associated with the role assignment request. Azure resources can include subscriptions, resource groups, virtual machines, and SQL databases."
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "Required. The identifier of the Azure role definition that the role assignment request is associated with."
  type        = string
  default     = null
}

variable "schedule" {
  description = "The schedule object of the role assignment request."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the role assignment request."
  type        = any
  default     = null
}

variable "subject_id" {
  description = "Required. The unique identifier of the principal or subject that the role assignment request is associated with. Principals can be users, groups, or service principals."
  type        = string
  default     = null
}

variable "type" {
  description = "Required. Representing the type of the operation on the role assignment. The possible values are: AdminAdd , UserAdd , AdminUpdate , AdminRemove , UserRemove , UserExtend , AdminExtend , UserRenew , AdminRenew."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "requestedDateTime", "resource", "roleDefinition", "subject"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
