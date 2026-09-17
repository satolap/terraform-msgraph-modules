variable "assignment_state" {
  description = "Microsoft Graph assignmentState property."
  type        = string
  default     = null
}

variable "duration" {
  description = "Microsoft Graph duration property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedRoleAssignmentRequest"
  nullable    = false
}

variable "reason" {
  description = "Microsoft Graph reason property."
  type        = string
  default     = null
}

variable "requested_date_time" {
  description = "Microsoft Graph requestedDateTime property."
  type        = string
  default     = null
}

variable "role_id" {
  description = "Microsoft Graph roleId property."
  type        = string
  default     = null
}

variable "role_info" {
  description = "Microsoft Graph roleInfo property."
  type        = any
  default     = null
}

variable "schedule" {
  description = "Microsoft Graph schedule property."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null
}

variable "ticket_number" {
  description = "Microsoft Graph ticketNumber property."
  type        = string
  default     = null
}

variable "ticket_system" {
  description = "Microsoft Graph ticketSystem property."
  type        = string
  default     = null
}

variable "type" {
  description = "Microsoft Graph type property."
  type        = string
  default     = null
}

variable "user_id" {
  description = "Microsoft Graph userId property."
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
