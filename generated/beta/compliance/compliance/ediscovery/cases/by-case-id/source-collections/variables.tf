variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "add_to_review_set_operation" {
  description = "Adds the results of the sourceCollection to the specified reviewSet."
  type        = any
  default     = null
}

variable "additional_sources" {
  description = "Adds an additional source to the sourceCollection."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ediscovery.dataSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    holdStatus      = optional(any)
  }))
  default = null
}

variable "content_query" {
  description = "The query string in KQL (Keyword Query Language) query. For details, see Keyword queries and search conditions for Content Search and eDiscovery. You can refine searches by using fields paired with values; for example, subject:'Quarterly Financials' AND Date>=06/01/2016 AND Date<=07/01/2016."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The user who created the sourceCollection."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time the sourceCollection was created."
  type        = string
  default     = null
}

variable "custodian_sources" {
  description = "Custodian sources that are included in the sourceCollection."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ediscovery.dataSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    holdStatus      = optional(any)
  }))
  default = null
}

variable "data_source_scopes" {
  description = "When specified, the collection spans across a service for an entire workload. The possible values are: none, allTenantMailboxes, allTenantSites, allCaseCustodians, allCaseNoncustodialDataSources."
  type        = any
  default     = null

  validation {
    condition     = var.data_source_scopes == null ? true : contains(["none", "allTenantMailboxes", "allTenantSites", "allCaseCustodians", "allCaseNoncustodialDataSources", "unknownFutureValue"], var.data_source_scopes)
    error_message = "data_source_scopes must be one of the documented enum values."
  }
}

variable "description" {
  description = "The description of the sourceCollection."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the sourceCollection."
  type        = string
  default     = null
}

variable "last_estimate_statistics_operation" {
  description = "The last estimate operation associated with the sourceCollection."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The last user who modified the sourceCollection."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The last date and time the sourceCollection was modified."
  type        = string
  default     = null
}

variable "noncustodial_sources" {
  description = "noncustodialDataSource sources that are included in the sourceCollection"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.noncustodialDataSource")
    applyHoldToSource    = optional(bool)
    createdDateTime      = optional(string)
    dataSource           = optional(any)
    displayName          = optional(string)
    holdStatus           = optional(any)
    lastIndexOperation   = optional(any)
    lastModifiedDateTime = optional(string)
    releasedDateTime     = optional(string)
    status               = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.sourceCollection"
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
