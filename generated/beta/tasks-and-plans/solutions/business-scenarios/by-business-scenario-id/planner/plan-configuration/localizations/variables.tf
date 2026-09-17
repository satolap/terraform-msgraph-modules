variable "business_scenario_id" {
  description = "The unique identifier of businessScenario"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.business_scenario_id)) > 0
    error_message = "business_scenario_id must not be empty."
  }
}

variable "buckets" {
  description = "Localized names for configured buckets in the plan configuration."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.plannerPlanConfigurationBucketLocalization")
    externalBucketId = optional(string)
    name             = optional(string)
  }))
  default = null
}

variable "language_tag" {
  description = "The language code associated with the localized names in this object."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerPlanConfigurationLocalization"
  nullable    = false
}

variable "plan_title" {
  description = "Localized title of the plan."
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
