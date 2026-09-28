variable "child_host" {
  description = "Microsoft Graph childHost property."
  type        = any
  default     = null
}

variable "first_seen_date_time" {
  description = "The first date and time when Microsoft Defender Threat Intelligence observed the hostPair. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_seen_date_time" {
  description = "The last date and time when Microsoft Defender Threat Intelligence observed the hostPair. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "link_kind" {
  description = "The reason that two hosts are identified as hostPair."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.hostPair"
  nullable    = false
}

variable "parent_host" {
  description = "Microsoft Graph parentHost property."
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
