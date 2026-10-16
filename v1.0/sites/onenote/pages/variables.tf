variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "content" {
  description = "The page's HTML content."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onenotePage"
  nullable    = false
}

variable "title" {
  description = "The title of the page."
  type        = string
  default     = null
}

variable "user_tags" {
  description = "Microsoft Graph userTags property."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["contentUrl", "createdByAppId", "createdDateTime", "id", "lastModifiedDateTime", "level", "links", "order", "parentNotebook", "parentSection", "self"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
