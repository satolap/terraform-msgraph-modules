variable "display_name" {
  description = "The name of the source system. Maximum supported length is 100 characters."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.industryData.sourceSystemDefinition"
  nullable    = false
}

variable "user_matching_settings" {
  description = "A collection of user matching settings by roleGroup."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.industryData.userMatchingSetting")
    matchTarget   = optional(any)
    priorityOrder = optional(number)
    roleGroup = optional(object({
      odata_type  = optional(string, "#microsoft.graph.industryData.roleGroup")
      displayName = optional(string)
      roles = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.industryData.roleReferenceValue")
        code       = optional(string)
        value      = optional(any)
      })))
    }))
    sourceIdentifier = optional(object({
      odata_type = optional(string, "#microsoft.graph.industryData.identifierTypeReferenceValue")
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
  }))
  default = null
}

variable "vendor" {
  description = "The name of the vendor who supplies the source system. Maximum supported length is 100 characters."
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
