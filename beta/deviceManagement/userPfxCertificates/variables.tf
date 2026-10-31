variable "createdDateTime" {
  description = "Date/time when this PFX certificate was imported."
  type        = string
  default     = null
}

variable "encryptedPfxBlob" {
  description = "Encrypted PFX blob."
  type        = string
  default     = null
}

variable "encryptedPfxPassword" {
  description = "Encrypted PFX password."
  type        = string
  default     = null
  sensitive   = true
}

variable "expirationDateTime" {
  description = "Certificate's validity expiration date/time."
  type        = string
  default     = null
}

variable "intendedPurpose" {
  description = "Supported values for the intended purpose of a user PFX certificate."
  type        = string
  default     = null

  validation {
    condition     = var.intendedPurpose == null ? true : contains(["unassigned", "smimeEncryption", "smimeSigning", "vpn", "wifi"], var.intendedPurpose)
    error_message = "intendedPurpose must be one of the documented enum values."
  }
}

variable "keyName" {
  description = "Name of the key (within the provider) used to encrypt the blob."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
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

variable "paddingScheme" {
  description = "Supported values for the padding scheme used by encryption provider."
  type        = string
  default     = null

  validation {
    condition     = var.paddingScheme == null ? true : contains(["none", "pkcs1", "oaepSha1", "oaepSha256", "oaepSha384", "oaepSha512"], var.paddingScheme)
    error_message = "paddingScheme must be one of the documented enum values."
  }
}

variable "providerName" {
  description = "Crypto provider used to encrypt this blob."
  type        = string
  default     = null
}

variable "startDateTime" {
  description = "Certificate's validity start date/time."
  type        = string
  default     = null
}

variable "thumbprint" {
  description = "SHA-1 thumbprint of the PFX certificate."
  type        = string
  default     = null
}

variable "userPrincipalName" {
  description = "User Principal Name of the PFX certificate."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
