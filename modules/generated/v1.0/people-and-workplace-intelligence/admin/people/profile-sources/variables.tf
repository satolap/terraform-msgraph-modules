variable "display_name" {
  description = "Name of the profile source intended to inform users about the profile source name."
  type        = string
  default     = null
}

variable "kind" {
  description = "Type of the profile source."
  type        = string
  default     = null
}

variable "localizations" {
  description = "Alternative localized labels specified by an administrator."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.profileSourceLocalization")
    displayName = optional(string)
    languageTag = optional(string)
    webUrl      = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.profileSource"
  nullable    = false
}

variable "source_id" {
  description = "Profile source identifier used as an alternate key."
  type        = string
  default     = null
}

variable "web_url" {
  description = "Web URL of the profile source that directs users to the page view of the profile data."
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
