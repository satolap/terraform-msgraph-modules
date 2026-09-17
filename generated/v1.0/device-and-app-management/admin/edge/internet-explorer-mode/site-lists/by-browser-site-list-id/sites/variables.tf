variable "browser_site_list_id" {
  description = "The unique identifier of browserSiteList"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.browser_site_list_id)) > 0
    error_message = "browser_site_list_id must not be empty."
  }
}

variable "allow_redirect" {
  description = "Controls the behavior of redirected sites. If true, indicates that the site will open in Internet Explorer 11 or Microsoft Edge even if the site is navigated to as part of a HTTP or meta refresh redirection chain."
  type        = bool
  default     = null
}

variable "comment" {
  description = "The comment for the site."
  type        = string
  default     = null
}

variable "compatibility_mode" {
  description = "Microsoft Graph compatibilityMode property."
  type        = string
  default     = null

  validation {
    condition     = var.compatibility_mode == null ? true : contains(["default", "internetExplorer8Enterprise", "internetExplorer7Enterprise", "internetExplorer11", "internetExplorer10", "internetExplorer9", "internetExplorer8", "internetExplorer7", "internetExplorer5", "unknownFutureValue"], var.compatibility_mode)
    error_message = "compatibility_mode must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "The date and time when the site was created."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "The date and time when the site was deleted."
  type        = string
  default     = null
}

variable "history" {
  description = "The history of modifications applied to the site."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.browserSiteHistory")
    allowRedirect     = optional(bool)
    comment           = optional(string)
    compatibilityMode = optional(any)
    lastModifiedBy    = optional(any)
    mergeType         = optional(any)
    publishedDateTime = optional(string)
    targetEnvironment = optional(any)
  }))
  default = null
}

variable "last_modified_by" {
  description = "The user who last modified the site."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the site was last modified."
  type        = string
  default     = null
}

variable "merge_type" {
  description = "Microsoft Graph mergeType property."
  type        = string
  default     = null

  validation {
    condition     = var.merge_type == null ? true : contains(["noMerge", "default", "unknownFutureValue"], var.merge_type)
    error_message = "merge_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.browserSite"
  nullable    = false
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

variable "target_environment" {
  description = "Microsoft Graph targetEnvironment property."
  type        = string
  default     = null

  validation {
    condition     = var.target_environment == null ? true : contains(["internetExplorerMode", "internetExplorer11", "microsoftEdge", "configurable", "none", "unknownFutureValue"], var.target_environment)
    error_message = "target_environment must be one of the documented enum values."
  }
}

variable "web_url" {
  description = "The URL of the site."
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
