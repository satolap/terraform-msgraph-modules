variable "created_by" {
  description = "Identity of the user who created the landing page."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the landing page was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the landing page as defined by the user."
  type        = string
  default     = null
}

variable "details" {
  description = "The detail information for a landing page associated with a simulation during its creation."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.landingPageDetail")
    content           = optional(string)
    isDefaultLangauge = optional(bool)
    language          = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The display name of the landing page."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "The source of the content. The possible values are: unknown, global, tenant, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["unknown", "global", "tenant", "unknownFutureValue"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "last_modified_by" {
  description = "Email identity of the user who last modified the landing page."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time when the landing page was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "locale" {
  description = "Content locale."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.landingPage"
  nullable    = false
}

variable "status" {
  description = "The status of the simulation. The possible values are: unknown, draft, ready, archive, delete, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "draft", "ready", "archive", "delete", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "supported_locales" {
  description = "Supported locales."
  type        = list(string)
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
