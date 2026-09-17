variable "accounts" {
  description = "Microsoft Graph accounts property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.userAccount")
    displayName      = optional(string)
    lastSeenDateTime = optional(string)
    riskScore        = optional(string)
    service          = optional(string)
    signinName       = optional(string)
    status           = optional(any)
  }))
  default = null
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

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
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
  default     = "#microsoft.graph.userSecurityProfile"
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

variable "user_principal_name" {
  description = "Microsoft Graph userPrincipalName property."
  type        = string
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
