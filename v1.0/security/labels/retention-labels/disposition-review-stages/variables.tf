variable "retention_label_id" {
  description = "The unique identifier of retentionLabel"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.retention_label_id)) > 0
    error_message = "retention_label_id must not be empty."
  }
}

variable "name" {
  description = "Name representing each stage within a collection."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.dispositionReviewStage"
  nullable    = false
}

variable "reviewers_email_addresses" {
  description = "A collection of reviewers at each stage."
  type        = list(string)
  default     = null
}

variable "stage_number" {
  description = "The unique sequence number for each stage of the disposition review."
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
