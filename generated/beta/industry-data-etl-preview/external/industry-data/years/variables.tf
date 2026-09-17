variable "display_name" {
  description = "The name of the year. Maximum supported length is 100 characters."
  type        = string
  default     = null
}

variable "end_date" {
  description = "The last day of the year using ISO 8601 format for date."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.industryData.yearTimePeriodDefinition"
  nullable    = false
}

variable "start_date" {
  description = "The first day of the year using ISO 8601 format for date."
  type        = string
  default     = null
}

variable "year" {
  description = "Microsoft Graph year property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.industryData.yearReferenceValue")
    code       = optional(string)
    value = optional(object({
      odata_type    = optional(string, "#microsoft.graph.industryData.referenceDefinition")
      code          = optional(string)
      displayName   = optional(string)
      isDisabled    = optional(bool)
      referenceType = optional(string)
      sortIndex     = optional(number)
    }))
  })
  default = null
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
