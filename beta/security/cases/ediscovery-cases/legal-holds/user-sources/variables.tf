variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "ediscovery_hold_policy_id" {
  description = "The unique identifier of ediscoveryHoldPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_hold_policy_id)) > 0
    error_message = "ediscovery_hold_policy_id must not be empty."
  }
}

variable "created_by" {
  description = "The user who created the dataSource."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time the dataSource was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the dataSource and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "email" {
  description = "Email address of the user's mailbox."
  type        = string
  default     = null
}

variable "hold_status" {
  description = "The hold status of the dataSource.The possible values are: notApplied, applied, applying, removing, partial"
  type        = string
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial", "unknownFutureValue"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
  }
}

variable "included_sources" {
  description = "Specifies which sources are included in this group. The possible values are: mailbox, site."
  type        = string
  default     = null

  validation {
    condition     = var.included_sources == null ? true : try(alltrue([for value in split(",", var.included_sources) : contains(["mailbox", "site", "unknownfuturevalue"], lower(trimspace(value)))]), false)
    error_message = "included_sources must be one or more of the documented enum values, separated by commas."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.userSource"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "siteWebUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
