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

variable "first_seen_date_time" {
  description = "Microsoft Graph firstSeenDateTime property."
  type        = string
  default     = null
}

variable "fqdn" {
  description = "Microsoft Graph fqdn property."
  type        = string
  default     = null
}

variable "is_azure_ad_joined" {
  description = "Microsoft Graph isAzureAdJoined property."
  type        = bool
  default     = null
}

variable "is_azure_ad_registered" {
  description = "Microsoft Graph isAzureAdRegistered property."
  type        = bool
  default     = null
}

variable "is_hybrid_azure_domain_joined" {
  description = "Microsoft Graph isHybridAzureDomainJoined property."
  type        = bool
  default     = null
}

variable "last_seen_date_time" {
  description = "Microsoft Graph lastSeenDateTime property."
  type        = string
  default     = null
}

variable "logon_users" {
  description = "Microsoft Graph logonUsers property."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.logonUser")
    accountDomain     = optional(string)
    accountName       = optional(string)
    accountType       = optional(any)
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    logonId           = optional(string)
    logonTypes        = optional(any)
  }))
  default = null
}

variable "net_bios_name" {
  description = "Microsoft Graph netBiosName property."
  type        = string
  default     = null
}

variable "network_interfaces" {
  description = "Microsoft Graph networkInterfaces property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.networkInterface")
    description      = optional(string)
    ipV4Address      = optional(string)
    ipV6Address      = optional(string)
    localIpV6Address = optional(string)
    macAddress       = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.hostSecurityProfile"
  nullable    = false
}

variable "os" {
  description = "Microsoft Graph os property."
  type        = string
  default     = null
}

variable "os_version" {
  description = "Microsoft Graph osVersion property."
  type        = string
  default     = null
}

variable "parent_host" {
  description = "Microsoft Graph parentHost property."
  type        = string
  default     = null
}

variable "related_host_ids" {
  description = "Microsoft Graph relatedHostIds property."
  type        = list(string)
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
