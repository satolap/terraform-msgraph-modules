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
  type        = string
  default     = null

  validation {
    condition     = var.eligibility_filtering_enabled_entities == null ? true : try(alltrue([for value in split(",", var.eligibility_filtering_enabled_entities) : contains(["none", "swaprequest", "offershiftrequest"], lower(trimspace(value)))]), false)
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

  validation {
    condition     = (var.encryption == null ? true : alltrue([(var.encryption["protocol"] == null ? true : alltrue([(var.encryption["protocol"] == null ? true : contains(["sharedSecret"], var.encryption["protocol"]))]))]))
    error_message = "encryption: nested required attributes must be non-null and enum values must be supported input members."
  }
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
  type        = string
  default     = null

  validation {
    condition     = var.supported_entities == null ? true : try(alltrue([for value in split(",", var.supported_entities) : contains(["none", "shift", "swaprequest", "usershiftpreferences", "openshift", "openshiftrequest", "offershiftrequest"], lower(trimspace(value)))]), false)
    error_message = "supported_entities must be one or more of the documented enum values, separated by commas."
  }
}

variable "supports" {
  description = "The Shifts entities supported for synchronous change notifications. Shifts make a callback to the url provided on client changes on those entities added here. By default, no entities are supported for change notifications. The possible values are: none, shift, swapRequest, openshift, openShiftRequest, userShiftPreferences, offerShiftRequest, unknownFutureValue, timeCard, timeOffReason, timeOff, timeOffRequest. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: timeCard, timeOffReason, timeOff, timeOffRequest. If selecting more than one value, all values must start with the first letter in uppercase."
  type        = string
  default     = null

  validation {
    condition     = var.supports == null ? true : try(alltrue([for value in split(",", var.supports) : contains(["none", "shift", "swaprequest", "usershiftpreferences", "openshift", "openshiftrequest", "offershiftrequest"], lower(trimspace(value)))]), false)
    error_message = "supports must be one or more of the documented enum values, separated by commas."
  }
}

variable "url" {
  description = "Workforce Integration URL for callbacks from the Shifts service."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
