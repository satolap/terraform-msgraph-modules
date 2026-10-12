variable "display_name" {
  description = "The name of the role group."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.industryData.roleGroup"
  nullable    = false
}

variable "roles" {
  description = "The set of roles included in the role group."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.industryData.roleReferenceValue")
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
