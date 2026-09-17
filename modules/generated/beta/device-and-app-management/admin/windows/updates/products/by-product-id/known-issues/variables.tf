variable "product_id" {
  description = "The unique identifier of product"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.product_id)) > 0
    error_message = "product_id must not be empty."
  }
}

variable "description" {
  description = "The description of the particular known issue."
  type        = string
  default     = null
}

variable "known_issue_histories" {
  description = "Microsoft Graph knownIssueHistories property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsUpdates.knownIssueHistoryItem")
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.windowsUpdates.itemBody")
      content     = optional(string)
      contentType = optional(any)
    }))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.knownIssue"
  nullable    = false
}

variable "originating_knowledge_base_article" {
  description = "Knowledge base article associated with the release when the known issue was first reported."
  type        = any
  default     = null
}

variable "resolved_date_time" {
  description = "The date and time when the known issue was resolved or mitigated. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "resolving_knowledge_base_article" {
  description = "Knowledge base article associated with the release when the known issue was resolved or mitigated."
  type        = any
  default     = null
}

variable "safeguard_hold_ids" {
  description = "Microsoft Graph safeguardHoldIds property."
  type        = list(number)
  default     = null
}

variable "start_date_time" {
  description = "The date and time when the known issue was first reported. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["resolved", "mitigatedExternal", "mitigated", "resolvedExternal", "confirmed", "reported", "investigating", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "title" {
  description = "The title of the known issue."
  type        = string
  default     = null
}

variable "web_view_url" {
  description = "The URL to the known issue in the Windows Release Health dashboard on Microsoft 365 admin center."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastUpdatedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
