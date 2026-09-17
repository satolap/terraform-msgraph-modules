variable "calendar_id" {
  description = "The unique identifier of calendar"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.calendar_id)) > 0
    error_message = "calendar_id must not be empty."
  }
}

variable "allowed_roles" {
  description = "List of allowed sharing or delegating permission levels for the calendar. The possible values are: none, freeBusyRead, limitedRead, read, write, delegateWithoutPrivateEventAccess, delegateWithPrivateEventAccess, custom."
  type        = any
  default     = null
}

variable "is_inside_organization" {
  description = "True if the user in context (share recipient or delegate) is inside the same organization as the calendar owner."
  type        = bool
  default     = null
}

variable "is_removable" {
  description = "True if the user can be removed from the list of recipients or delegates for the specified calendar, false otherwise. The 'My organization' user determines the permissions other people within your organization have to the given calendar. You can't remove 'My organization' as a recipient to a calendar."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.calendarPermission"
  nullable    = false
}

variable "role" {
  description = "Current permission level of the calendar share recipient or delegate."
  type        = any
  default     = null

  validation {
    condition     = var.role == null ? true : contains(["none", "freeBusyRead", "limitedRead", "read", "write", "delegateWithoutPrivateEventAccess", "delegateWithPrivateEventAccess", "custom"], var.role)
    error_message = "role must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["emailAddress", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
