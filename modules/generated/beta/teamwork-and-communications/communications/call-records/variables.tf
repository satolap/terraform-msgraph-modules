variable "end_date_time" {
  description = "UTC time when the last user left the call. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Monotonically increasing version of the call record. Higher version call records with the same ID include additional data compared to the lower version."
  type        = number
  default     = null
}

variable "join_web_url" {
  description = "Meeting URL associated to the call. May not be available for a peerToPeer call record type."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "UTC time when the call record was created. The DatetimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "modalities" {
  description = "List of all the modalities used in the call. The possible values are: unknown, audio, video, videoBasedScreenSharing, data, screenSharing, unknownFutureValue."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.callRecords.callRecord"
  nullable    = false
}

variable "organizer" {
  description = "The organizing party's identity. The organizer property is deprecated and will stop returning data on June 30, 2026. Going forward, use the organizer_v2 relationship."
  type        = any
  default     = null
}

variable "organizer_v2" {
  description = "Identity of the organizer of the call. This relationship is expanded by default in callRecord methods."
  type        = any
  default     = null
}

variable "participants" {
  description = "List of distinct identities involved in the call. Limited to 130 entries. The participants property is deprecated and will stop returning data on June 30, 2026. Going forward, use the participants_v2 relationship."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.identitySet")
    application = optional(any)
    device      = optional(any)
    user        = optional(any)
  }))
  default = null
}

variable "participants_v2" {
  description = "List of distinct participants in the call."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.callRecords.participant")
    administrativeUnitInfos = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.callRecords.administrativeUnitInfo")
      id         = optional(string)
    })))
    identity = optional(any)
  }))
  default = null
}

variable "start_date_time" {
  description = "UTC time when the first user joined the call. The DatetimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "type" {
  description = "Microsoft Graph type property."
  type        = string
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["unknown", "groupCall", "peerToPeer", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "sessions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
