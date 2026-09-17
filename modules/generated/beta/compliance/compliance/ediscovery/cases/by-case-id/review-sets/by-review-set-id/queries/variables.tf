variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "review_set_id" {
  description = "The unique identifier of reviewSet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.review_set_id)) > 0
    error_message = "review_set_id must not be empty."
  }
}

variable "created_by" {
  description = "The user who created the query."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time and date when the query was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the query."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user who last modified the query."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the query was last modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.reviewSetQuery"
  nullable    = false
}

variable "query" {
  description = "The query string in KQL (Keyword Query Language) query. For details, see Document metadata fields in Advanced eDiscovery.  This field maps directly to the keywords condition.  You can refine searches by using fields listed in the searchable field name paired with values; for example, subject:'Quarterly Financials' AND Date>=06/01/2016 AND Date<=07/01/2016."
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
