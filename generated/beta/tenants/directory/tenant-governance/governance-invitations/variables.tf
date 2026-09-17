variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Microsoft Graph expirationDateTime property."
  type        = string
  default     = null
}

variable "governed_tenant_id" {
  description = "Microsoft Graph governedTenantId property."
  type        = string
  default     = null
}

variable "governed_tenant_name" {
  description = "Microsoft Graph governedTenantName property."
  type        = string
  default     = null
}

variable "governing_tenant_id" {
  description = "Microsoft Graph governingTenantId property."
  type        = string
  default     = null
}

variable "governing_tenant_name" {
  description = "Microsoft Graph governingTenantName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceInvitation"
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
