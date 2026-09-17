variable "display_name" {
  description = "Display name of the agreement. The display name is used for internal tracking of the agreement but isn't shown to end users who view the agreement. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "file" {
  description = "Default PDF linked to this agreement."
  type        = any
  default     = null
}

variable "files" {
  description = "PDFs linked to this agreement. This property is in the process of being deprecated. Use the  file property instead. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.agreementFileLocalization")
    createdDateTime = optional(string)
    displayName     = optional(string)
    isMajorVersion  = optional(bool)
  }))
  default = null
}

variable "is_per_device_acceptance_required" {
  description = "Indicates whether end users are required to accept this agreement on every device that they access it from. The end user is required to register their device in Microsoft Entra ID, if they haven't already done so. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_viewing_before_acceptance_required" {
  description = "Indicates whether the user has to expand the agreement before accepting. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agreement"
  nullable    = false
}

variable "terms_expiration" {
  description = "Expiration schedule and frequency of agreement for all users. Supports $filter (eq)."
  type        = any
  default     = null
}

variable "user_reaccept_required_frequency" {
  description = "The duration after which the user must reaccept the terms of use. The value is represented in ISO 8601 format for durations. Supports $filter (eq)."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["acceptances", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
