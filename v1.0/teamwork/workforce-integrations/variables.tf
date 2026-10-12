variable "api_version" {
  description = "API version for the callback URL. Start with 1."
  type        = number
  default     = null
}

variable "created_by" {
  description = "Identity of the creator of the entity."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Name of the workforce integration."
  type        = string
  default     = null
}

variable "eligibility_filtering_enabled_entities" {
  description = "Support to view eligibility-filtered results. The possible values are: none, swapRequest, offerShiftRequest, unknownFutureValue, timeOffReason. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: timeOffReason."
  type        = string
  default     = null

  validation {
    condition     = var.eligibility_filtering_enabled_entities == null ? true : try(alltrue([for value in split(",", var.eligibility_filtering_enabled_entities) : contains(["none", "swaprequest", "offershiftrequest", "unknownfuturevalue", "timeoffreason"], lower(trimspace(value)))]), false)
    error_message = "eligibility_filtering_enabled_entities must be one or more of the documented enum values, separated by commas."
  }
}

variable "encryption" {
  description = "The workforce integration encryption resource."
  type = object({
    odata_type = optional(string, "#microsoft.graph.workforceIntegrationEncryption")
    protocol   = optional(string)
    secret     = optional(string)
  })
  default   = null
  sensitive = true
}

variable "is_active" {
  description = "Indicates whether this workforce integration is currently active and available."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workforceIntegration"
  nullable    = false
}

variable "supported_entities" {
  description = "The Shifts entities supported for synchronous change notifications. Shifts call back to the provided URL when client changes occur to the entities specified in this property. By default, no entities are supported for change notifications. The possible values are: none, shift, swapRequest, userShiftPreferences, openShift, openShiftRequest, offerShiftRequest, unknownFutureValue, timeCard, timeOffReason, timeOff, timeOffRequest. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: timeCard , timeOffReason , timeOff , timeOffRequest."
  type        = string
  default     = null

  validation {
    condition     = var.supported_entities == null ? true : try(alltrue([for value in split(",", var.supported_entities) : contains(["none", "shift", "swaprequest", "usershiftpreferences", "openshift", "openshiftrequest", "offershiftrequest", "unknownfuturevalue", "timecard", "timeoffreason", "timeoff", "timeoffrequest"], lower(trimspace(value)))]), false)
    error_message = "supported_entities must be one or more of the documented enum values, separated by commas."
  }
}

variable "url" {
  description = "Workforce Integration URL for callbacks from the Shifts service."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
