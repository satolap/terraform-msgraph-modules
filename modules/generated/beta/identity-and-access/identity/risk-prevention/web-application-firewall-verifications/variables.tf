variable "graph_provider" {
  description = "Reference to a provider resource associated with this verification model. Represents a WAF provider that can be used to verify or manage the host."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.webApplicationFirewallVerificationModel"
  nullable    = false
}

variable "provider_type" {
  description = "Microsoft Graph providerType property."
  type        = string
  default     = null

  validation {
    condition     = var.provider_type == null ? true : contains(["akamai", "cloudflare", "unknownFutureValue"], var.provider_type)
    error_message = "provider_type must be one of the documented enum values."
  }
}

variable "verification_result" {
  description = "An object describing the outcome of the verification operation, including status, errors or warnings"
  type        = any
  default     = null
}

variable "verified_details" {
  description = "Details of DNS configuration"
  type        = any
  default     = null
}

variable "verified_host" {
  description = "The host (domain or subdomain) that was verified as part of this verification operation."
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
