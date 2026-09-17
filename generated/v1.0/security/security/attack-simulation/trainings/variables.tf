variable "availability_status" {
  description = "Training availability status. The possible values are: unknown, notAvailable, available, archive, delete, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.availability_status == null ? true : contains(["unknown", "notAvailable", "available", "archive", "delete", "unknownFutureValue"], var.availability_status)
    error_message = "availability_status must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "Identity of the user who created the training."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the training was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "The description for the training."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the training."
  type        = string
  default     = null
}

variable "duration_in_minutes" {
  description = "Training duration."
  type        = number
  default     = null
}

variable "graph_source" {
  description = "Training content source. The possible values are: unknown, global, tenant, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["unknown", "global", "tenant", "unknownFutureValue"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "has_evaluation" {
  description = "Indicates whether the training has any evaluation."
  type        = bool
  default     = null
}

variable "language_details" {
  description = "Language specific details on a training."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.trainingLanguageDetail")
    content              = optional(string)
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    isDefaultLangauge    = optional(bool)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    locale               = optional(string)
  }))
  default = null
}

variable "last_modified_by" {
  description = "Identity of the user who last modified the training."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time when the training was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.training"
  nullable    = false
}

variable "supported_locales" {
  description = "Supported locales for content for the associated training."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "Training tags."
  type        = list(string)
  default     = null
}

variable "type" {
  description = "The type of training. The possible values are: unknown, phishing, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["unknown", "phishing", "unknownFutureValue"], var.type)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
