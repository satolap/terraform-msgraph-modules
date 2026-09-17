variable "domain_id" {
  description = "The unique identifier of domain"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.domain_id)) > 0
    error_message = "domain_id must not be empty."
  }
}

variable "expiry_time" {
  description = "Microsoft Graph expiryTime property."
  type        = string
  default     = null
}

variable "invitation_domain" {
  description = "Microsoft Graph invitationDomain property."
  type        = string
  default     = null
}

variable "invitation_status" {
  description = "Microsoft Graph invitationStatus property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharedEmailDomainInvitation"
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
