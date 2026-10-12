variable "mdm_windows_information_protection_policy_id" {
  description = "The unique identifier of mdmWindowsInformationProtectionPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mdm_windows_information_protection_policy_id)) > 0
    error_message = "mdm_windows_information_protection_policy_id must not be empty."
  }
}

variable "display_name" {
  description = "The friendly name"
  type        = string
  default     = null
}

variable "file" {
  description = "File as a byte array"
  type        = string
  default     = null
}

variable "file_hash" {
  description = "SHA256 hash of the file"
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsInformationProtectionAppLockerFile"
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
