variable "certificate_authorities" {
  description = "Multi-value property that represents a list of trusted certificate authorities."
  type = list(object({
    odata_type                        = optional(string, "#microsoft.graph.certificateAuthority")
    certificate                       = optional(string)
    certificateRevocationListUrl      = optional(string)
    deltaCertificateRevocationListUrl = optional(string)
    isRootAuthority                   = optional(bool)
  }))
  default = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Friendly name. Supports $filter (eq, in)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mutualTlsOauthConfiguration"
  nullable    = false
}

variable "tls_client_auth_parameter" {
  description = "Microsoft Graph tlsClientAuthParameter property."
  type        = string
  default     = null

  validation {
    condition     = var.tls_client_auth_parameter == null ? true : contains(["tls_client_auth_subject_dn", "tls_client_auth_san_dns", "tls_client_auth_san_uri", "tls_client_auth_san_ip", "tls_client_auth_san_email", "unknownFutureValue"], var.tls_client_auth_parameter)
    error_message = "tls_client_auth_parameter must be one of the documented enum values."
  }
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
