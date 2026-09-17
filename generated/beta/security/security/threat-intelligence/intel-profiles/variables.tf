variable "aliases" {
  description = "A list of commonly-known aliases for the threat intelligence included in the intelligenceProfile."
  type        = list(string)
  default     = null
}

variable "countries_or_regions_of_origin" {
  description = "The country/region of origin for the given actor or threat associated with this intelligenceProfile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.intelligenceProfileCountryOrRegionOfOrigin")
    code       = optional(string)
    label      = optional(string)
  }))
  default = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.formattedContent")
    content    = optional(string)
    format     = optional(any)
  })
  default = null
}

variable "first_active_date_time" {
  description = "The date and time when this intelligenceProfile was first active.  The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "indicators" {
  description = "Includes an assemblage of high-fidelity network indicators of compromise."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.intelligenceProfileIndicator")
    artifact = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.artifact")
    }))
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    source            = optional(string)
  }))
  default = null
}

variable "kind" {
  description = "Microsoft Graph kind property."
  type        = string
  default     = null

  validation {
    condition     = var.kind == null ? true : contains(["actor", "tool", "unknownFutureValue"], var.kind)
    error_message = "kind must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.intelligenceProfile"
  nullable    = false
}

variable "summary" {
  description = "Microsoft Graph summary property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.formattedContent")
    content    = optional(string)
    format     = optional(any)
  })
  default = null
}

variable "targets" {
  description = "Known targets related to this intelligenceProfile."
  type        = list(string)
  default     = null
}

variable "title" {
  description = "The title of this intelligenceProfile."
  type        = string
  default     = null
}

variable "tradecraft" {
  description = "Formatted information featuring a description of the distinctive tactics, techniques, and procedures (TTP) of the group, followed by a list of all known custom, commodity, and publicly available implants used by the group."
  type        = any
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
