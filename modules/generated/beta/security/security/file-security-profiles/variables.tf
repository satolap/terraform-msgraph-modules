variable "activity_group_names" {
  description = "Microsoft Graph activityGroupNames property."
  type        = list(string)
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

variable "certificate_thumbprint" {
  description = "Microsoft Graph certificateThumbprint property."
  type        = string
  default     = null
}

variable "extensions" {
  description = "Microsoft Graph extensions property."
  type        = list(string)
  default     = null
}

variable "file_type" {
  description = "Microsoft Graph fileType property."
  type        = string
  default     = null
}

variable "first_seen_date_time" {
  description = "Microsoft Graph firstSeenDateTime property."
  type        = string
  default     = null
}

variable "hashes" {
  description = "Microsoft Graph hashes property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.fileHash")
    hashType   = optional(any)
    hashValue  = optional(string)
  }))
  default = null
}

variable "last_seen_date_time" {
  description = "Microsoft Graph lastSeenDateTime property."
  type        = string
  default     = null
}

variable "malware_states" {
  description = "Microsoft Graph malwareStates property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.malwareState")
    category   = optional(string)
    family     = optional(string)
    name       = optional(string)
    severity   = optional(string)
    wasRunning = optional(bool)
  }))
  default = null
}

variable "names" {
  description = "Microsoft Graph names property."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.fileSecurityProfile"
  nullable    = false
}

variable "risk_score" {
  description = "Microsoft Graph riskScore property."
  type        = string
  default     = null
}

variable "size" {
  description = "Microsoft Graph size property."
  type        = number
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

variable "vulnerability_states" {
  description = "Microsoft Graph vulnerabilityStates property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.vulnerabilityState")
    cve        = optional(string)
    severity   = optional(string)
    wasRunning = optional(bool)
  }))
  default = null
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
