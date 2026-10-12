variable "board_support_package_version" {
  description = "The version of the Board Support Package (BSP. E.g.: 01.18.02.00)"
  type        = string
  default     = null
}

variable "description" {
  description = "Artifact description. (e.g.: `LifeGuard Update 98 (released 24-September-2021)"
  type        = string
  default     = null
}

variable "device_model" {
  description = "Applicable device model (e.g.: TC8300)"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.zebraFotaArtifact"
  nullable    = false
}

variable "os_version" {
  description = "Artifact OS version (e.g.: 8.1.0)"
  type        = string
  default     = null
}

variable "patch_version" {
  description = "Artifact patch version (e.g.: U00)"
  type        = string
  default     = null
}

variable "release_notes_url" {
  description = "Artifact release notes URL (e.g.: https://www.zebra.com/<filename.pdf>)"
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
