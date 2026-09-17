variable "certificate_based_auth_pki_id" {
  description = "The unique identifier of certificateBasedAuthPki"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.certificate_based_auth_pki_id)) > 0
    error_message = "certificate_based_auth_pki_id must not be empty."
  }
}

variable "certificate" {
  description = "The public key of the certificate authority."
  type        = string
  default     = null
}

variable "certificate_authority_type" {
  description = "The type of certificate authority. The possible values are: root, intermediate, unknownFutureValue. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.certificate_authority_type == null ? true : contains(["root", "intermediate", "unknownFutureValue"], var.certificate_authority_type)
    error_message = "certificate_authority_type must be one of the documented enum values."
  }
}

variable "certificate_revocation_list_url" {
  description = "The URL to check if the certificate is revoked."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the certificate authority was created."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "delta_certificate_revocation_list_url" {
  description = "Microsoft Graph deltaCertificateRevocationListUrl property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the certificate authority."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The date and time when the certificate authority expires. Supports $filter (eq) and $orderby."
  type        = string
  default     = null
}

variable "is_issuer_hint_enabled" {
  description = "Indicates whether the certificate picker presents the certificate authority to the user to use for authentication. Default value is false. Optional."
  type        = bool
  default     = null
}

variable "issuer" {
  description = "The issuer of the certificate authority."
  type        = string
  default     = null
}

variable "issuer_subject_key_identifier" {
  description = "The subject key identifier of certificate authority."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateAuthorityDetail"
  nullable    = false
}

variable "thumbprint" {
  description = "The thumbprint of certificate authority certificate. Supports $filter (eq, startswith)."
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
