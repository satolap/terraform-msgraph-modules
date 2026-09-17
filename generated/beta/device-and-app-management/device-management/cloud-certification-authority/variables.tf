variable "certificate_key_size" {
  description = "Enum of possible cloud certification authority certificate cryptography and key size combinations."
  type        = string
  default     = null

  validation {
    condition     = var.certificate_key_size == null ? true : contains(["unknown", "rsa2048", "rsa3072", "rsa4096", "eCP256", "eCP256k", "eCP384", "eCP521", "unknownFutureValue"], var.certificate_key_size)
    error_message = "certificate_key_size must be one of the documented enum values."
  }
}

variable "certification_authority_status" {
  description = "Enum type of possible certification authority statuses. These statuses indicate whether a certification authority is currently able to issue certificates, temporarily paused, pending signing, revoked, or expired."
  type        = string
  default     = null

  validation {
    condition     = var.certification_authority_status == null ? true : contains(["unknown", "active", "paused", "revoked", "signingPending", "unknownFutureValue", "expired"], var.certification_authority_status)
    error_message = "certification_authority_status must be one of the documented enum values."
  }
}

variable "cloud_certification_authority_hashing_algorithm" {
  description = "Enum type of possible certificate hashing algorithms used by the certification authority to create certificates."
  type        = string
  default     = null

  validation {
    condition     = var.cloud_certification_authority_hashing_algorithm == null ? true : contains(["unknown", "sha256", "sha384", "sha512", "unknownFutureValue"], var.cloud_certification_authority_hashing_algorithm)
    error_message = "cloud_certification_authority_hashing_algorithm must be one of the documented enum values."
  }
}

variable "cloud_certification_authority_leaf_certificate" {
  description = "Required OData property to expose leaf certificate API."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.cloudCertificationAuthorityLeafCertificate")
    certificateStatus = optional(string)
  }))
  default = null
}

variable "cloud_certification_authority_type" {
  description = "Enum type of possible certificate authority types. This feature supports a two-tier certification authority model with a root certification authority and one or more child issuing (intermediate) certification authorities."
  type        = string
  default     = null

  validation {
    condition     = var.cloud_certification_authority_type == null ? true : contains(["unknown", "rootCertificationAuthority", "issuingCertificationAuthority", "issuingCertificationAuthorityWithExternalRoot", "unknownFutureValue"], var.cloud_certification_authority_type)
    error_message = "cloud_certification_authority_type must be one of the documented enum values."
  }
}

variable "description" {
  description = "The certification authority description displayed in the Intune admin console. Nullable. Read/write. Returns null if not set."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The certification authority display name the Intune admin console. Read/write. Supports $select and $orderby."
  type        = string
  default     = null
}

variable "e_tag" {
  description = "ETag for optimistic concurrency control. Read/write."
  type        = string
  default     = null
}

variable "issuer_common_name" {
  description = "Microsoft Graph issuerCommonName property."
  type        = string
  default     = null
}

variable "key_platform" {
  description = "Enum type of possible key platforms used by the certification authority."
  type        = string
  default     = null

  validation {
    condition     = var.key_platform == null ? true : contains(["unknown", "software", "hardwareSecurityModule", "unknownFutureValue"], var.key_platform)
    error_message = "key_platform must be one of the documented enum values."
  }
}

variable "last_modified_date_time" {
  description = "Last modification date and time of this certification authority entity instance. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: '2014-01-01T00:00:00Z'. Nullable. Read/write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudCertificationAuthority"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this entity instance. Scope tags limit access to an entity instance. Nullable. Read/write."
  type        = list(string)
  default     = null
}

variable "validity_period_in_years" {
  description = "The certification authority validity period in years configured by admins."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activeVersion", "certificateDownloadUrl", "certificateRevocationListUrl", "certificateSigningRequest", "certificationAuthorityIssuerId", "certificationAuthorityIssuerUri", "commonName", "countryName", "createdDateTime", "extendedKeyUsages", "geographicRegion", "id", "localityName", "ocspResponderUri", "organizationName", "organizationUnit", "rootCertificateCommonName", "scepServerUrl", "serialNumber", "stateName", "subjectName", "thumbprint", "validityEndDateTime", "validityStartDateTime", "versionNumber", "versions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
