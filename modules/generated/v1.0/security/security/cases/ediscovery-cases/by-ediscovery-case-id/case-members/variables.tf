variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "display_name" {
  description = "The display name of the eDiscovery case member. Allowed only for case members of type roleGroup."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryCaseMember"
  nullable    = false
}

variable "recipient_type" {
  description = "Specifies the recipient type of the eDiscovery case member. The possible values are: user, roleGroup, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.recipient_type == null ? true : contains(["user", "roleGroup", "unknownFutureValue"], var.recipient_type)
    error_message = "recipient_type must be one of the documented enum values."
  }
}

variable "smtp_address" {
  description = "The smtp address of the eDiscovery case member. Allowed only for case members of type user."
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
