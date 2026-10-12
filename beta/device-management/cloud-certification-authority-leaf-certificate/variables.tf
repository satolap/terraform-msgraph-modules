variable "certificate_status" {
  description = "Enum type of possible leaf certificate statuses. These statuses indicate whether certificates are active and usable or unusable if they have been revoked or expired."
  type        = string
  default     = null

  validation {
    condition     = var.certificate_status == null ? true : contains(["unknown", "active", "revoked", "expired", "unknownFutureValue"], var.certificate_status)
    error_message = "certificate_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudCertificationAuthorityLeafCertificate"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["certificationAuthorityIssuerUri", "certificationAuthorityVersionNumber", "cloudCertificationAuthorityVersion", "crlDistributionPointUrl", "deviceId", "deviceName", "devicePlatform", "extendedKeyUsages", "id", "issuerId", "issuerName", "keyUsages", "ocspResponderUri", "revocationDateTime", "serialNumber", "subjectName", "thumbprint", "userId", "userPrincipalName", "validityEndDateTime", "validityStartDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
