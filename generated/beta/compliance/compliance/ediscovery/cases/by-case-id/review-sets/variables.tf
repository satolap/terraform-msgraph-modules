variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "display_name" {
  description = "The review set name. The name is unique with a maximum limit of 64 characters."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.reviewSet"
  nullable    = false
}

variable "queries" {
  description = "Microsoft Graph queries property."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.reviewSetQuery")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    displayName          = optional(string)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    query                = optional(string)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
