variable "planner_roster_id" {
  description = "The unique identifier of plannerRoster"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_roster_id)) > 0
    error_message = "planner_roster_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerRosterMember"
  nullable    = false
}

variable "roles" {
  description = "Additional roles associated with the PlannerRosterMember, which determines permissions of the member in the plannerRoster. Currently there are no available roles to assign, and every member has full control over the contents of the plannerRoster."
  type        = list(string)
  default     = null
}

variable "tenant_id" {
  description = "Identifier of the tenant the user belongs to. Currently only the users from the same tenant can be added to a plannerRoster."
  type        = string
  default     = null
}

variable "user_id" {
  description = "Identifier of the user."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
