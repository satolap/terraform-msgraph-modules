variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "custodian_id" {
  description = "The unique identifier of custodian"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.custodian_id)) > 0
    error_message = "custodian_id must not be empty."
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
  description = "The display name of the dataSource, and is the name of the SharePoint site."
  type        = string
  default     = null
}

variable "email" {
  description = "Email address of the user's mailbox."
  type        = string
  default     = null
}

variable "hold_status" {
  description = "Microsoft Graph holdStatus property."
  type        = any
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial", "unknownFutureValue"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
  }
}

variable "included_sources" {
  description = "Specifies which sources are included in this group. The possible values are: mailbox, site."
  type        = any
  default     = null

  validation {
    condition     = var.included_sources == null ? true : contains(["mailbox", "site"], var.included_sources)
    error_message = "included_sources must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.userSource"
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
