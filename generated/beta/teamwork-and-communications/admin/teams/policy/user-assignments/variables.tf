variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAdministration.teamsPolicyUserAssignment"
  nullable    = false
}

variable "policy_id" {
  description = "The unique identifier (GUID) of the policy within the specified policy type."
  type        = string
  default     = null
}

variable "policy_type" {
  description = "The type of Teams policy assigned or unassigned, such as teamsMeetingBroadcastPolicy."
  type        = string
  default     = null
}

variable "user_id" {
  description = "The unique identifier (GUID) of the user."
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
