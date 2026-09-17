variable "error" {
  description = "Microsoft Graph error property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.publicError")
    code       = optional(string)
    details = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
      code       = optional(string)
      message    = optional(string)
      target     = optional(string)
    })))
    innerError = optional(any)
    message    = optional(string)
    target     = optional(string)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharePointMigrationTask"
  nullable    = false
}

variable "parameters" {
  description = "Microsoft Graph parameters property."
  type = object({
    odata_type                   = optional(string, "#microsoft.graph.sharePointMigrationTaskParameters")
    preferredLatestStartDateTime = optional(string)
    preferredStartDateTime       = optional(string)
    sourceSiteUrl                = optional(string)
    targetDataLocationCode       = optional(string)
    targetOrganizationHost       = optional(string)
    targetOrganizationId         = optional(string)
    targetSiteUrl                = optional(string)
    validateOnly                 = optional(bool)
  })
  default = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "inProgress", "completed", "cancelled", "failed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["finishedDateTime", "id", "lastUpdatedDateTime", "startedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
