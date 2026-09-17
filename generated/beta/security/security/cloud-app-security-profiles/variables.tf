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

variable "deployment_package_url" {
  description = "Microsoft Graph deploymentPackageUrl property."
  type        = string
  default     = null
}

variable "destination_service_name" {
  description = "Microsoft Graph destinationServiceName property."
  type        = string
  default     = null
}

variable "is_signed" {
  description = "Microsoft Graph isSigned property."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "manifest" {
  description = "Microsoft Graph manifest property."
  type        = string
  default     = null
}

variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudAppSecurityProfile"
  nullable    = false
}

variable "permissions_required" {
  description = "Microsoft Graph permissionsRequired property."
  type        = any
  default     = null

  validation {
    condition     = var.permissions_required == null ? true : contains(["unknown", "anonymous", "guest", "user", "administrator", "system", "unknownFutureValue"], var.permissions_required)
    error_message = "permissions_required must be one of the documented enum values."
  }
}

variable "platform" {
  description = "Microsoft Graph platform property."
  type        = string
  default     = null
}

variable "policy_name" {
  description = "Microsoft Graph policyName property."
  type        = string
  default     = null
}

variable "publisher" {
  description = "Microsoft Graph publisher property."
  type        = string
  default     = null
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

variable "type" {
  description = "Microsoft Graph type property."
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
