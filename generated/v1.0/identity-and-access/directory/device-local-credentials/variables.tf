variable "credentials" {
  description = "The credentials of the device's local administrator account backed up to Azure Active Directory."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.deviceLocalCredential")
    accountName    = optional(string)
    accountSid     = optional(string)
    backupDateTime = optional(string)
    passwordBase64 = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "device_name" {
  description = "Display name of the device that the local credentials are associated with."
  type        = string
  default     = null
}

variable "last_backup_date_time" {
  description = "When the local administrator account credential was backed up to Azure Active Directory."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceLocalCredentialInfo"
  nullable    = false
}

variable "refresh_date_time" {
  description = "When the local administrator account credential will be refreshed and backed up to Azure Active Directory."
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
