variable "active_user_count" {
  description = "Active user count of the given tenant."
  type        = number
  default     = null
}

variable "average_comparative_scores" {
  description = "Average score by different scopes (for example, average by industry, average by seating) and control category (Identity, Data, Device, Apps, Infrastructure) within the scope."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.averageComparativeScore")
    averageScore = optional(any)
    basis        = optional(string)
  }))
  default = null
}

variable "azure_tenant_id" {
  description = "GUID string for tenant ID."
  type        = string
  default     = null
}

variable "control_scores" {
  description = "Contains tenant scores for a set of controls."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.controlScore")
    controlCategory = optional(string)
    controlName     = optional(string)
    description     = optional(string)
    score           = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "When the report was created."
  type        = string
  default     = null
}

variable "current_score" {
  description = "Tenant current attained score on specified date."
  type        = any
  default     = null
}

variable "enabled_services" {
  description = "Microsoft-provided services for the tenant (for example, Exchange online, Skype, SharePoint)."
  type        = list(string)
  default     = null
}

variable "licensed_user_count" {
  description = "Licensed user count of the given tenant."
  type        = number
  default     = null
}

variable "max_score" {
  description = "Tenant maximum possible score on specified date."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.secureScore"
  nullable    = false
}

variable "vendor_information" {
  description = "Microsoft Graph vendorInformation property."
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
