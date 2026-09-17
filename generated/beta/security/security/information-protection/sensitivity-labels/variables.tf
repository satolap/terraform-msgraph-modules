variable "color" {
  description = "The color that the UI should display for the label, if configured."
  type        = string
  default     = null
}

variable "content_formats" {
  description = "Returns the supported content formats for the label."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "The admin-defined description for the label."
  type        = string
  default     = null
}

variable "has_protection" {
  description = "Indicates whether the label has protection actions (such as encryption or do not forward) configured."
  type        = bool
  default     = null
}

variable "is_active" {
  description = "Indicates whether the label is active or not. Active labels should be hidden or disabled in the UI."
  type        = bool
  default     = null
}

variable "is_appliable" {
  description = "Indicates whether the label can be applied to content. False if the label is a parent with child labels."
  type        = bool
  default     = null
}

variable "name" {
  description = "The plaintext name of the label."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.sensitivityLabel"
  nullable    = false
}

variable "parent" {
  description = "Microsoft Graph parent property."
  type        = any
  default     = null
}

variable "sensitivity" {
  description = "The sensitivity value of the label, where lower is less sensitive."
  type        = number
  default     = null
}

variable "tooltip" {
  description = "The tooltip that should be displayed for the label in a UI."
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
