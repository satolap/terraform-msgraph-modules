variable "browser_site_list_id" {
  description = "The unique identifier of browserSiteList"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.browser_site_list_id)) > 0
    error_message = "browser_site_list_id must not be empty."
  }
}

variable "comment" {
  description = "The comment for the shared cookie."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the shared cookie was created."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "The date and time when the shared cookie was deleted."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the cookie."
  type        = string
  default     = null
}

variable "history" {
  description = "The history of modifications applied to the cookie."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.browserSharedCookieHistory")
    comment      = optional(string)
    displayName  = optional(string)
    hostOnly     = optional(bool)
    hostOrDomain = optional(string)
    lastModifiedBy = optional(object({
      odata_type  = optional(string, "#microsoft.graph.identitySet")
      application = optional(any)
      device      = optional(any)
      user        = optional(any)
    }))
    path              = optional(string)
    publishedDateTime = optional(string)
    sourceEnvironment = optional(any)
  }))
  default = null
}

variable "host_only" {
  description = "Controls whether a cookie is a host-only or domain cookie."
  type        = bool
  default     = null
}

variable "host_or_domain" {
  description = "The URL of the cookie."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user who last modified the cookie."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the cookie was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.browserSharedCookie"
  nullable    = false
}

variable "path" {
  description = "The path of the cookie."
  type        = string
  default     = null
}

variable "source_environment" {
  description = "Microsoft Graph sourceEnvironment property."
  type        = string
  default     = null

  validation {
    condition     = var.source_environment == null ? true : contains(["microsoftEdge", "internetExplorer11", "both", "unknownFutureValue"], var.source_environment)
    error_message = "source_environment must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["published", "pendingAdd", "pendingEdit", "pendingDelete", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
