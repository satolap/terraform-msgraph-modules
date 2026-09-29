variable "content_metadata" {
  description = "Microsoft Graph contentMetadata property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.processContentRequest")
    activityMetadata = optional(object({
      odata_type = optional(string, "#microsoft.graph.activityMetadata")
      activity   = optional(string)
    }))
    contentEntries = optional(any)
    deviceMetadata = optional(object({
      odata_type = optional(string, "#microsoft.graph.deviceMetadata")
      deviceType = optional(string)
      ipAddress  = optional(string)
      operatingSystemSpecifications = optional(object({
        odata_type              = optional(string, "#microsoft.graph.operatingSystemSpecifications")
        operatingSystemPlatform = optional(string)
        operatingSystemVersion  = optional(string)
      }))
    }))
    integratedAppMetadata = optional(any)
    protectedAppMetadata = optional(object({
      odata_type          = optional(string, "#microsoft.graph.protectedApplicationMetadata")
      applicationLocation = optional(any)
      name                = optional(string)
      version             = optional(string)
    }))
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.contentActivity"
  nullable    = false
}

variable "scope_identifier" {
  description = "The scope identified from computed protection scopes."
  type        = string
  default     = null
}

variable "user_id" {
  description = "ID of the user."
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
