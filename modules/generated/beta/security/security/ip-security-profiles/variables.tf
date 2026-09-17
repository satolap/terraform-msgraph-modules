variable "activity_group_names" {
  description = "Microsoft Graph activityGroupNames property."
  type        = list(string)
  default     = null
}

variable "address" {
  description = "Microsoft Graph address property."
  type        = string
  default     = null
}

variable "azure_subscription_id" {
  description = "Microsoft Graph azureSubscriptionId property."
  type        = string
  default     = null
}

variable "azure_tenant_id" {
  description = "Microsoft Graph azureTenantId property."
  type        = string
  default     = null
}

variable "count_hits" {
  description = "Microsoft Graph countHits property."
  type        = number
  default     = null
}

variable "count_hosts" {
  description = "Microsoft Graph countHosts property."
  type        = number
  default     = null
}

variable "first_seen_date_time" {
  description = "Microsoft Graph firstSeenDateTime property."
  type        = string
  default     = null
}

variable "ip_categories" {
  description = "Microsoft Graph ipCategories property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.ipCategory")
    description = optional(string)
    name        = optional(string)
    vendor      = optional(string)
  }))
  default = null
}

variable "ip_reference_data" {
  description = "Microsoft Graph ipReferenceData property."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.ipReferenceData")
    asn                 = optional(number)
    city                = optional(string)
    countryOrRegionCode = optional(string)
    organization        = optional(string)
    state               = optional(string)
    vendor              = optional(string)
  }))
  default = null
}

variable "last_seen_date_time" {
  description = "Microsoft Graph lastSeenDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ipSecurityProfile"
  nullable    = false
}

variable "risk_score" {
  description = "Microsoft Graph riskScore property."
  type        = string
  default     = null
}

variable "tags" {
  description = "Microsoft Graph tags property."
  type        = list(string)
  default     = null
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
