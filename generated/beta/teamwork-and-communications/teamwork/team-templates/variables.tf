variable "definitions" {
  description = "A generic representation of a team template definition for a team with a specific structure and configuration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.teamTemplateDefinition")
    audience             = optional(any)
    categories           = optional(list(string))
    description          = optional(string)
    displayName          = optional(string)
    iconUrl              = optional(string)
    languageTag          = optional(string)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    parentTemplateId     = optional(string)
    publisherName        = optional(string)
    shortDescription     = optional(string)
    teamDefinition       = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamTemplate"
  nullable    = false
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
