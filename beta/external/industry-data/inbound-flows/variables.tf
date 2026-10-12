variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.industryData.inboundApiFlow", "#microsoft.graph.industryData.inboundFileFlow"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "data_connector" {
  description = "Microsoft Graph dataConnector property."
  type        = any
  default     = null
}

variable "data_domain" {
  description = "Microsoft Graph dataDomain property."
  type        = string
  default     = null

  validation {
    condition     = var.data_domain == null ? true : contains(["educationRostering", "unknownFutureValue"], var.data_domain)
    error_message = "data_domain must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The name of the activity. Maximum supported length is 100 characters."
  type        = string
  default     = null
}

variable "effective_date_time" {
  description = "The start of the time window when the flow is allowed to run. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The end of the time window when the flow is allowed to run. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "year" {
  description = "Microsoft Graph year property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.industryData.yearTimePeriodDefinition")
    displayName = optional(string)
    endDate     = optional(string)
    startDate   = optional(string)
    year = optional(object({
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "readinessStatus"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
