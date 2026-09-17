variable "description" {
  description = "The description of the site list."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the site list."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user who last modified the site list."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the site list was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.browserSiteList"
  nullable    = false
}

variable "published_by" {
  description = "The user who published the site list."
  type        = any
  default     = null
}

variable "published_date_time" {
  description = "The date and time when the site list was published."
  type        = string
  default     = null
}

variable "revision" {
  description = "The current revision of the site list."
  type        = string
  default     = null
}

variable "shared_cookies" {
  description = "A collection of shared cookies defined for the site list."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.browserSharedCookie")
    comment         = optional(string)
    createdDateTime = optional(string)
    deletedDateTime = optional(string)
    displayName     = optional(string)
    history = optional(list(object({
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
    })))
    hostOnly             = optional(bool)
    hostOrDomain         = optional(string)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    path                 = optional(string)
    sourceEnvironment    = optional(string)
    status               = optional(string)
  }))
  default = null
}

variable "sites" {
  description = "A collection of sites defined for the site list."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.browserSite")
    allowRedirect     = optional(bool)
    comment           = optional(string)
    compatibilityMode = optional(string)
    createdDateTime   = optional(string)
    deletedDateTime   = optional(string)
    history = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.browserSiteHistory")
      allowRedirect     = optional(bool)
      comment           = optional(string)
      compatibilityMode = optional(any)
      lastModifiedBy    = optional(any)
      mergeType         = optional(any)
      publishedDateTime = optional(string)
      targetEnvironment = optional(any)
    })))
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    mergeType            = optional(string)
    status               = optional(string)
    targetEnvironment    = optional(string)
    webUrl               = optional(string)
  }))
  default = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["draft", "published", "pending", "unknownFutureValue"], var.status)
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
