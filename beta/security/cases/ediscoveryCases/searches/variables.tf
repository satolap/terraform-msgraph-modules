variable "ediscoveryCase-id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscoveryCase-id)) > 0
    error_message = "ediscoveryCase-id must not be empty."
  }
}

variable "addToReviewSetOperation" {
  description = "Adds the results of the eDiscovery search to the specified reviewSet."
  type        = any
  default     = null
}

variable "additionalSources" {
  description = "Adds an additional source to the eDiscovery search."
  type        = any
  default     = null
}

variable "contentQuery" {
  description = "Microsoft Graph contentQuery property."
  type        = string
  default     = null
}

variable "createdBy" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "custodianSources" {
  description = "Custodian sources that are included in the eDiscovery search."
  type        = any
  default     = null
}

variable "dataSourceScopes" {
  description = "When specified, the collection spans across a service for an entire workload. The possible values are: none, allTenantMailboxes, allTenantSites, allCaseCustodians, allCaseNoncustodialDataSources."
  type        = string
  default     = null

  validation {
    condition     = var.dataSourceScopes == null ? true : try(alltrue([for value in split(",", var.dataSourceScopes) : contains(["none", "alltenantmailboxes", "alltenantsites", "allcasecustodians", "allcasenoncustodialdatasources"], lower(trimspace(value)))]), false)
    error_message = "dataSourceScopes must be one or more of the documented enum values, separated by commas."
  }
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "lastEstimateStatisticsOperation" {
  description = "The last estimate operation associated with the eDiscovery search."
  type        = any
  default     = null
}

variable "lastModifiedBy" {
  description = "Microsoft Graph lastModifiedBy property."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "noncustodialSources" {
  description = "noncustodialDataSource sources that are included in the eDiscovery search"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")
    createdDateTime      = optional(string)
    dataSource           = optional(any)
    displayName          = optional(string)
    holdStatus           = optional(string)
    lastIndexOperation   = optional(any)
    lastModifiedDateTime = optional(string)
    releasedDateTime     = optional(string)
    status               = optional(string)
  }))
  default = null

  validation {
    condition     = (var.noncustodialSources == null ? true : alltrue([alltrue([for input0 in var.noncustodialSources : (input0 == null ? true : alltrue([(input0["holdStatus"] == null ? true : alltrue([(input0["holdStatus"] == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial"], input0["holdStatus"]))])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["active", "released"], input0["status"]))]))]))])]))
    error_message = "noncustodialSources: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoverySearch"
  nullable    = false
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
