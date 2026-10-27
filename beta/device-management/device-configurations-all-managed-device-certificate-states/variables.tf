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
