variable "certificate_expiration_date_time" {
  description = "Certificate expiry date"
  type        = string
  default     = null
}

variable "certificate_extended_key_usages" {
  description = "Enhanced Key Usage"
  type        = string
  default     = null
}

variable "certificate_issuance_date_time" {
  description = "Issuance date"
  type        = string
  default     = null
}

variable "certificate_issuer_name" {
  description = "Issuer"
  type        = string
  default     = null
}

variable "certificate_key_usages" {
  description = "Key Usage"
  type        = number
  default     = null
}

variable "certificate_revoke_status" {
  description = "Certificate Revocation Status."
  type        = string
  default     = null

  validation {
    condition     = var.certificate_revoke_status == null ? true : contains(["none", "pending", "issued", "failed", "revoked"], var.certificate_revoke_status)
    error_message = "certificate_revoke_status must be one of the documented enum values."
  }
}

variable "certificate_revoke_status_last_change_date_time" {
  description = "The time the revoke status was last changed"
  type        = string
  default     = null
}

variable "certificate_serial_number" {
  description = "Serial number"
  type        = string
  default     = null
}

variable "certificate_subject_name" {
  description = "Certificate subject name"
  type        = string
  default     = null
}

variable "certificate_thumbprint" {
  description = "Thumbprint"
  type        = string
  default     = null
}

variable "managed_device_display_name" {
  description = "Device display name"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedAllDeviceCertificateState"
  nullable    = false
}

variable "user_principal_name" {
  description = "User principal name"
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
