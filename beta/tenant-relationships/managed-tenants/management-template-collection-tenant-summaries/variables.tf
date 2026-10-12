variable "complete_steps_count" {
  description = "Microsoft Graph completeStepsCount property."
  type        = number
  default     = null
}

variable "complete_users_count" {
  description = "Microsoft Graph completeUsersCount property."
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

variable "dismissed_steps_count" {
  description = "Microsoft Graph dismissedStepsCount property."
  type        = number
  default     = null
}

variable "excluded_users_count" {
  description = "Microsoft Graph excludedUsersCount property."
  type        = number
  default     = null
}

variable "excluded_users_distinct_count" {
  description = "Microsoft Graph excludedUsersDistinctCount property."
  type        = number
  default     = null
}

variable "incomplete_steps_count" {
  description = "Microsoft Graph incompleteStepsCount property."
  type        = number
  default     = null
}

variable "incomplete_users_count" {
  description = "Microsoft Graph incompleteUsersCount property."
  type        = number
  default     = null
}

variable "ineligible_steps_count" {
  description = "Microsoft Graph ineligibleStepsCount property."
  type        = number
  default     = null
}

variable "is_complete" {
  description = "Microsoft Graph isComplete property."
  type        = bool
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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplateCollectionTenantSummary"
  nullable    = false
}

variable "regressed_steps_count" {
  description = "Microsoft Graph regressedStepsCount property."
  type        = number
  default     = null
}

variable "regressed_users_count" {
  description = "Microsoft Graph regressedUsersCount property."
  type        = number
  default     = null
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
  type        = string
  default     = null
}

variable "unlicensed_users_count" {
  description = "Microsoft Graph unlicensedUsersCount property."
  type        = number
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
