variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "add_to_review_set_operation" {
  description = "Adds the results of the eDiscovery search to the specified reviewSet."
  type        = any
  default     = null
}

variable "additional_sources" {
  description = "Adds an additional source to the eDiscovery search."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.security.dataSource")
    createdBy       = optional(any)
    createdDateTime = optional(string)
    displayName     = optional(string)
    holdStatus      = optional(any)
  }))
  default = null
}

variable "content_query" {
  description = "Microsoft Graph contentQuery property."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "custodian_sources" {
  description = "Custodian sources that are included in the eDiscovery search."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.security.dataSource")
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
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "last_estimate_statistics_operation" {
  description = "The last estimate operation associated with the eDiscovery search."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "Microsoft Graph lastModifiedBy property."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "noncustodial_sources" {
  description = "noncustodialDataSource sources that are included in the eDiscovery search"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")
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
  default     = "#microsoft.graph.security.ediscoverySearch"
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
