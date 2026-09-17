variable "service_update_message_id" {
  description = "The unique identifier of serviceUpdateMessage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.service_update_message_id)) > 0
    error_message = "service_update_message_id must not be empty."
  }
}

variable "content" {
  description = "The attachment content."
  type        = string
  default     = null
}

variable "content_type" {
  description = "Microsoft Graph contentType property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.serviceAnnouncementAttachment"
  nullable    = false
}

variable "size" {
  description = "Microsoft Graph size property."
  type        = number
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
