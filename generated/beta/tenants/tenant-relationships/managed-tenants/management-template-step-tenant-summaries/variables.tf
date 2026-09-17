variable "assigned_tenants_count" {
  description = "Microsoft Graph assignedTenantsCount property."
  type        = number
  default     = null
}

variable "compliant_tenants_count" {
  description = "Microsoft Graph compliantTenantsCount property."
  type        = number
  default     = null
}

variable "created_by_user_id" {
  description = "Microsoft Graph createdByUserId property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "dismissed_tenants_count" {
  description = "Microsoft Graph dismissedTenantsCount property."
  type        = number
  default     = null
}

variable "ineligible_tenants_count" {
  description = "Microsoft Graph ineligibleTenantsCount property."
  type        = number
  default     = null
}

variable "last_action_by_user_id" {
  description = "Microsoft Graph lastActionByUserId property."
  type        = string
  default     = null
}

variable "last_action_date_time" {
  description = "Microsoft Graph lastActionDateTime property."
  type        = string
  default     = null
}

variable "management_template_collection_display_name" {
  description = "Microsoft Graph managementTemplateCollectionDisplayName property."
  type        = string
  default     = null
}

variable "management_template_collection_id" {
  description = "Microsoft Graph managementTemplateCollectionId property."
  type        = string
  default     = null
}

variable "management_template_display_name" {
  description = "Microsoft Graph managementTemplateDisplayName property."
  type        = string
  default     = null
}

variable "management_template_id" {
  description = "Microsoft Graph managementTemplateId property."
  type        = string
  default     = null
}

variable "management_template_step_display_name" {
  description = "Microsoft Graph managementTemplateStepDisplayName property."
  type        = string
  default     = null
}

variable "management_template_step_id" {
  description = "Microsoft Graph managementTemplateStepId property."
  type        = string
  default     = null
}

variable "not_compliant_tenants_count" {
  description = "Microsoft Graph notCompliantTenantsCount property."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplateStepTenantSummary"
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
