variable "api_version" {
  description = "API version for the callback URL. Start with 1."
  type        = number
  default     = null
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Name of the workforce integration."
  type        = string
  default     = null
}

variable "eligibility_filtering_enabled_entities" {
  description = "Microsoft Graph eligibilityFilteringEnabledEntities property."
  type        = any
  default     = null

  validation {
    condition     = var.eligibility_filtering_enabled_entities == null ? true : contains(["none", "swapRequest", "offerShiftRequest", "unknownFutureValue", "timeOffReason"], var.eligibility_filtering_enabled_entities)
    error_message = "eligibility_filtering_enabled_entities must be one of the documented enum values."
  }
}

variable "encryption" {
  description = "The workforce integration encryption resource."
  type        = any
  default     = null
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
  description = "This property has replaced supports in v1.0. We recommend that you use this property instead of supports. The supports property is still supported in beta for the time being. The possible values are: none, shift, swapRequest, openshift, openShiftRequest, userShiftPreferences, offerShiftRequest, unknownFutureValue, timeCard, timeOffReason, timeOff, timeOffRequest. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: timeCard, timeOffReason, timeOff, timeOffRequest. If selecting more than one value, all values must start with the first letter in uppercase."
  type        = any
  default     = null

  validation {
    condition     = var.supported_entities == null ? true : contains(["none", "shift", "swapRequest", "userShiftPreferences", "openShift", "openShiftRequest", "offerShiftRequest", "unknownFutureValue", "timeCard", "timeOffReason", "timeOff", "timeOffRequest"], var.supported_entities)
    error_message = "supported_entities must be one of the documented enum values."
  }
}

variable "supports" {
  description = "The Shifts entities supported for synchronous change notifications. Shifts make a callback to the url provided on client changes on those entities added here. By default, no entities are supported for change notifications. The possible values are: none, shift, swapRequest, openshift, openShiftRequest, userShiftPreferences, offerShiftRequest, unknownFutureValue, timeCard, timeOffReason, timeOff, timeOffRequest. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: timeCard, timeOffReason, timeOff, timeOffRequest. If selecting more than one value, all values must start with the first letter in uppercase."
  type        = any
  default     = null

  validation {
    condition     = var.supports == null ? true : contains(["none", "shift", "swapRequest", "userShiftPreferences", "openShift", "openShiftRequest", "offerShiftRequest", "unknownFutureValue", "timeCard", "timeOffReason", "timeOff", "timeOffRequest"], var.supports)
    error_message = "supports must be one of the documented enum values."
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
