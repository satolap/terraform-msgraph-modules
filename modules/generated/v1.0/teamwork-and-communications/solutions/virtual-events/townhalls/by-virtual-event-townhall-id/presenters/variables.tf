variable "virtual_event_townhall_id" {
  description = "The unique identifier of virtualEventTownhall"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_townhall_id)) > 0
    error_message = "virtual_event_townhall_id must not be empty."
  }
}

variable "email" {
  description = "Email address of the presenter."
  type        = string
  default     = null
}

variable "identity" {
  description = "Identity information of the presenter. The supported identities are: communicationsGuestIdentity and communicationsUserIdentity."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.virtualEventPresenter"
  nullable    = false
}

variable "presenter_details" {
  description = "Other details about the presenter. This property returns null when the virtual event type is virtualEventTownhall."
  type        = any
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
