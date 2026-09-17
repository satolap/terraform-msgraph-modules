variable "body" {
  description = "Microsoft Graph body property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.formattedContent")
    content    = optional(string)
    format     = optional(any)
  })
  default = null
}

variable "created_date_time" {
  description = "The date and time when this article was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "image_url" {
  description = "URL of the header image for this article, used for display purposes."
  type        = string
  default     = null
}

variable "indicators" {
  description = "Indicators related to this article."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.articleIndicator")
    artifact = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.artifact")
    }))
    source = optional(string)
  }))
  default = null
}

variable "is_featured" {
  description = "Indicates whether this article is currently featured by Microsoft."
  type        = bool
  default     = null
}

variable "last_updated_date_time" {
  description = "The most recent date and time when this article was updated. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.article"
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

variable "tags" {
  description = "Tags for this article, communicating keywords, or key concepts."
  type        = list(string)
  default     = null
}

variable "title" {
  description = "The title of this article."
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
