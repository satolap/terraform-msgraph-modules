variable "azure_tenant_id" {
  description = "Microsoft Graph azureTenantId property."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Microsoft Graph enabled property."
  type        = bool
  default     = null
}

variable "graph_provider" {
  description = "Microsoft Graph provider property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.providerTenantSetting"
  nullable    = false
}

variable "vendor" {
  description = "Microsoft Graph vendor property."
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
