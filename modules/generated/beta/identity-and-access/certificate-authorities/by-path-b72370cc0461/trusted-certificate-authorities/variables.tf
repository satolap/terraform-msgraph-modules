variable "certificate_based_application_configuration_id" {
  description = "The unique identifier of certificateBasedApplicationConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.certificate_based_application_configuration_id)) > 0
    error_message = "certificate_based_application_configuration_id must not be empty."
  }
}

variable "certificate" {
  description = "The trusted certificate."
  type        = string
  default     = null
}

variable "is_root_authority" {
  description = "Indicates if the certificate is a root authority. In a certificateBasedApplicationConfiguration object, at least one object in the trustedCertificateAuthorities collection must be a root authority."
  type        = bool
  default     = null
}

variable "issuer" {
  description = "The issuer of the trusted certificate."
  type        = string
  default     = null
}

variable "issuer_subject_key_identifier" {
  description = "The subject key identifier of the trusted certificate."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateAuthorityAsEntity"
  nullable    = false
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
