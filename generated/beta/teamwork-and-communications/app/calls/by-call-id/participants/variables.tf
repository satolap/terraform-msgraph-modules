variable "call_id" {
  description = "The unique identifier of call"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.call_id)) > 0
    error_message = "call_id must not be empty."
  }
}

variable "info" {
  description = "Microsoft Graph info property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.participantInfo")
    identity = optional(object({
      odata_type  = optional(string, "#microsoft.graph.identitySet")
      application = optional(any)
      device      = optional(any)
      user        = optional(any)
    }))
    nonAnonymizedIdentity = optional(any)
  })
  default = null
}

variable "is_identity_anonymized" {
  description = "Microsoft Graph isIdentityAnonymized property."
  type        = bool
  default     = null
}

variable "is_in_lobby" {
  description = "true if the participant is in lobby."
  type        = bool
  default     = null
}

variable "is_muted" {
  description = "true if the participant is muted (client or server muted)."
  type        = bool
  default     = null
}

variable "media_streams" {
  description = "The list of media streams."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.mediaStream")
    direction   = optional(string)
    label       = optional(string)
    mediaType   = optional(string)
    serverMuted = optional(bool)
    sourceId    = optional(string)
  }))
  default = null
}

variable "metadata" {
  description = "A blob of data provided by the participant in the roster."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.participant"
  nullable    = false
}

variable "preferred_display_name" {
  description = "The participant's preferred display name that overrides the original display name."
  type        = string
  default     = null
}

variable "recording_info" {
  description = "Information on whether the participant has recording capability."
  type        = any
  default     = null
}

variable "removed_state" {
  description = "Indicates the reason why the participant was removed from the roster."
  type        = any
  default     = null
}

variable "restricted_experience" {
  description = "Indicates the reason or reasons why media content from this participant is restricted."
  type        = any
  default     = null
}

variable "roster_sequence_number" {
  description = "Indicates the roster sequence number the participant was last updated in."
  type        = number
  default     = null
}

variable "synthetic_media_detection" {
  description = "The latest synthetic media detection result reported for this participant by an in-call detection bot. Nullable. Set to null when no detection is reported. Populated asynchronously after a successful call to reportSyntheticMedia."
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
