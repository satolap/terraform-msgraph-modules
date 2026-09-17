variable "domain_id" {
  description = "The unique identifier of domain"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.domain_id)) > 0
    error_message = "domain_id must not be empty."
  }
}

variable "is_optional" {
  description = "If false, the customer must configure this record at the DNS host for Microsoft Online Services to operate correctly with the domain."
  type        = bool
  default     = null
}

variable "label" {
  description = "Value used when configuring the name of the DNS record at the DNS host."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.domainDnsRecord"
  nullable    = false
}

variable "record_type" {
  description = "Indicates what type of DNS record this entity represents. The value can be CName, Mx, Srv, or Txt."
  type        = string
  default     = null
}

variable "supported_service" {
  description = "Microsoft Online Service or feature that has a dependency on this DNS record. Can be one of the following values: null, Email, Sharepoint, EmailInternalRelayOnly, OfficeCommunicationsOnline, SharePointDefaultDomain, FullRedelegation, SharePointPublic, OrgIdAuthentication, Yammer, Intune."
  type        = string
  default     = null
}

variable "ttl" {
  description = "Value to use when configuring the time-to-live (ttl) property of the DNS record at the DNS host. Not nullable."
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
