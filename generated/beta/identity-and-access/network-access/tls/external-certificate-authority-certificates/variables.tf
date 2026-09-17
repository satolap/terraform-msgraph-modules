variable "certificate" {
  description = "The signed X.509 certificate in PEM format."
  type        = string
  default     = null
}

variable "chain" {
  description = "The certificate chain in PEM format, containing all intermediate certificates up to the root CA."
  type        = string
  default     = null
}

variable "common_name" {
  description = "The common name (CN) field of the certificate. Supports $filter (eq, ne, startsWith)"
  type        = string
  default     = null
}

variable "name" {
  description = "The display name of the CA. Supports $filter (eq, ne, startsWith)"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.externalCertificateAuthorityCertificate"
  nullable    = false
}

variable "organization_name" {
  description = "The organization name (OU) field of the certificate. Supports $filter (eq, ne, startsWith)"
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["csrGenerated", "enrolling", "active", "unknownFutureValue", "expiring", "expired", "enabled", "disabled", "creating", "revoked"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "validity" {
  description = "Microsoft Graph validity property."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.networkaccess.validityDate")
    endDateTime   = optional(string)
    startDateTime = optional(string)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["certificateSigningRequest", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
