variable "training_id" {
  description = "The unique identifier of training"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.training_id)) > 0
    error_message = "training_id must not be empty."
  }
}

variable "content" {
  description = "Language specific content for the training."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity of the user who created the language details."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the language details were created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "Description as defined by the user."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name as defined by the user."
  type        = string
  default     = null
}

variable "is_default_langauge" {
  description = "Indicates whether the training has a default language."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the user who last modified the details."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time when the trainingLanguageDetail was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "locale" {
  description = "Content locale for the training detail."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.trainingLanguageDetail"
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
