variable "domain" {
  description = "The URI for which the cookie is valid."
  type        = string
  default     = null
}

variable "first_seen_date_time" {
  description = "The first date and time when this hostCookie was observed by Microsoft Defender Threat Intelligence. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "host" {
  description = "Microsoft Graph host property."
  type        = any
  default     = null
}

variable "last_seen_date_time" {
  description = "The most recent date and time when this hostCookie was observed by Microsoft Defender Threat Intelligence. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the cookie, for example, JSESSIONID or SEARCH_NAMESITE."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.hostCookie"
  nullable    = false
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
