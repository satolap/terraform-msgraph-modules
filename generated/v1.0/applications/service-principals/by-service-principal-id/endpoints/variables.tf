variable "service_principal_id" {
  description = "The unique identifier of servicePrincipal"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.service_principal_id)) > 0
    error_message = "service_principal_id must not be empty."
  }
}

variable "capability" {
  description = "Microsoft Graph capability property."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.endpoint"
  nullable    = false
}

variable "provider_id" {
  description = "Microsoft Graph providerId property."
  type        = string
  default     = null
}

variable "provider_name" {
  description = "Microsoft Graph providerName property."
  type        = string
  default     = null
}

variable "provider_resource_id" {
  description = "Microsoft Graph providerResourceId property."
  type        = string
  default     = null
}

variable "uri" {
  description = "Microsoft Graph uri property."
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
