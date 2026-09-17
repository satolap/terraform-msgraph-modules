variable "description" {
  description = "The description of the connected organization."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the connected organization. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "external_sponsors" {
  description = "Microsoft Graph externalSponsors property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "internal_sponsors" {
  description = "Microsoft Graph internalSponsors property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.connectedOrganization"
  nullable    = false
}

variable "state" {
  description = "The state of a connected organization defines whether assignment policies with requestor scope type AllConfiguredConnectedOrganizationSubjects are applicable or not. The possible values are: configured, proposed."
  type        = any
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["configured", "proposed", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "identitySources", "modifiedBy", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
