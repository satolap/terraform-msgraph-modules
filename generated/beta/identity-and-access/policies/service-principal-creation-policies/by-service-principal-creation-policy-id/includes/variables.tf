variable "service_principal_creation_policy_id" {
  description = "The unique identifier of servicePrincipalCreationPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.service_principal_creation_policy_id)) > 0
    error_message = "service_principal_creation_policy_id must not be empty."
  }
}

variable "application_ids" {
  description = "Microsoft Graph applicationIds property."
  type        = list(string)
  default     = null
}

variable "application_publisher_ids" {
  description = "Microsoft Graph applicationPublisherIds property."
  type        = list(string)
  default     = null
}

variable "application_tenant_ids" {
  description = "Microsoft Graph applicationTenantIds property."
  type        = list(string)
  default     = null
}

variable "applications_from_verified_publisher_only" {
  description = "Microsoft Graph applicationsFromVerifiedPublisherOnly property."
  type        = bool
  default     = null
}

variable "certified_applications_only" {
  description = "Microsoft Graph certifiedApplicationsOnly property."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.servicePrincipalCreationConditionSet"
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
