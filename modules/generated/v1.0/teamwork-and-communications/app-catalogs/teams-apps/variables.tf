variable "app_definitions" {
  description = "The details for each version of the app."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.teamsAppDefinition")
    authorization        = optional(any)
    bot                  = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    publishingState      = optional(any)
    shortDescription     = optional(string)
    teamsAppId           = optional(string)
    version              = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The name of the catalog app provided by the app developer in the Microsoft Teams zip app package."
  type        = string
  default     = null
}

variable "external_id" {
  description = "The ID of the catalog provided by the app developer in the Microsoft Teams zip app package."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsApp"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["distributionMethod", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
