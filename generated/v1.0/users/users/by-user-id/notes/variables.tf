variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "attachments" {
  description = "The file attachments for the note. Only inline image attachments (image/png, image/jpeg, image/gif, or image/bmp) are supported, with a maximum size of 3 MB per attachment. Use $expand to retrieve attachments."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.attachment")
    contentType          = optional(string)
    isInline             = optional(bool)
    lastModifiedDateTime = optional(string)
    name                 = optional(string)
    size                 = optional(number)
  }))
  default = null
}

variable "body" {
  description = "The content of the note. Supports text or html content types."
  type        = any
  default     = null
}

variable "categories" {
  description = "The categories associated with the item"
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the note."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "multi_value_extended_properties" {
  description = "The collection of multi-value extended properties defined for the note."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")
    value      = optional(list(string))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.note"
  nullable    = false
}

variable "single_value_extended_properties" {
  description = "The collection of single-value extended properties defined for the note."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")
    value      = optional(string)
  }))
  default = null
}

variable "subject" {
  description = "The title of the note. Supports $filter (eq, ne, startsWith) and $orderby."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["bodyPreview", "changeKey", "hasAttachments", "id", "isDeleted"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
