variable "b2c_identity_user_flow_id" {
  description = "The unique identifier of b2cIdentityUserFlow"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.b2c_identity_user_flow_id)) > 0
    error_message = "b2c_identity_user_flow_id must not be empty."
  }
}

variable "default_pages" {
  description = "Collection of pages with the default content to display in a user flow for a specified language. This collection doesn't allow any kind of modification."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")
  }))
  default = null
}

variable "is_enabled" {
  description = "Indicates whether the language is enabled within the user flow."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userFlowLanguageConfiguration"
  nullable    = false
}

variable "overrides_pages" {
  description = "Collection of pages with the overrides messages to display in a user flow for a specified language. This collection only allows to modify the content of the page, any other modification isn't allowed (creation or deletion of pages)."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
