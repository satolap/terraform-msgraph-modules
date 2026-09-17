variable "created_date_time" {
  description = "Date/time when this PFX certificate was imported."
  type        = string
  default     = null
}

variable "encrypted_pfx_blob" {
  description = "Encrypted PFX blob."
  type        = string
  default     = null
}

variable "encrypted_pfx_password" {
  description = "Encrypted PFX password."
  type        = string
  default     = null
  sensitive   = true
}

variable "expiration_date_time" {
  description = "Certificate's validity expiration date/time."
  type        = string
  default     = null
}

variable "intended_purpose" {
  description = "Supported values for the intended purpose of a user PFX certificate."
  type        = string
  default     = null

  validation {
    condition     = var.intended_purpose == null ? true : contains(["unassigned", "smimeEncryption", "smimeSigning", "vpn", "wifi"], var.intended_purpose)
    error_message = "intended_purpose must be one of the documented enum values."
  }
}

variable "key_name" {
  description = "Name of the key (within the provider) used to encrypt the blob."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Date/time when this PFX certificate was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userPFXCertificate"
  nullable    = false
}

variable "padding_scheme" {
  description = "Supported values for the padding scheme used by encryption provider."
  type        = string
  default     = null

  validation {
    condition     = var.padding_scheme == null ? true : contains(["none", "pkcs1", "oaepSha1", "oaepSha256", "oaepSha384", "oaepSha512"], var.padding_scheme)
    error_message = "padding_scheme must be one of the documented enum values."
  }
}

variable "provider_name" {
  description = "Crypto provider used to encrypt this blob."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "Certificate's validity start date/time."
  type        = string
  default     = null
}

variable "thumbprint" {
  description = "SHA-1 thumbprint of the PFX certificate."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User Principal Name of the PFX certificate."
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
