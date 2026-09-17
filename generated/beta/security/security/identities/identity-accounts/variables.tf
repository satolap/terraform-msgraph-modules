variable "accounts" {
  description = "Collection of accounts of the identity in different identity providers."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.security.account")
    actions          = optional(list(string))
    identifier       = optional(string)
    identityProvider = optional(string)
  }))
  default = null
}

variable "cloud_security_identifier" {
  description = "The cloud security identifier of the identityAccount."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The  Active Directory display name of the identityAccount."
  type        = string
  default     = null
}

variable "domain" {
  description = "The Active Directory domain name of the identityAccount."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "Boolean indicating if the identityAccounts is enabled."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.identityAccounts"
  nullable    = false
}

variable "on_premises_security_identifier" {
  description = "The on-premises security identifier of the identityAccount."
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
