variable "complete_after_date_time" {
  description = "Date and time after which the migration should be performed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2024, is 2024-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the job. Must be unique per tenant."
  type        = string
  default     = null
}

variable "exchange_settings" {
  description = "Settings to use for migration of Exchange workload. Nullable."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.exchangeOnlineCrossTenantMigrationSettings")
    sourceEndpoint       = optional(string)
    targetDeliveryDomain = optional(string)
  })
  default = null
}

variable "job_type" {
  description = "Microsoft Graph jobType property."
  type        = string
  default     = null

  validation {
    condition     = var.job_type == null ? true : contains(["validate", "migrate"], var.job_type)
    error_message = "job_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.crossTenantMigrationJob"
  nullable    = false
}

variable "resource_type" {
  description = "Type of resource being migrated. Only Users is currently supported."
  type        = string
  default     = null
}

variable "resources" {
  description = "IDs (GUID) of the resources that are migrated with the migration job."
  type        = list(string)
  default     = null
}

variable "source_tenant_id" {
  description = "ID (GUID) of the tenant that content is migrated from."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["submitted", "approved", "processing", "cuttingOver", "inProgress", "completed", "completedWithErrors", "failed", "cancelled", "pendingCancel", "adminActionRequired", "validateSubmitted", "validateProcessing", "validateInProgress", "validatePassed", "validateFailed", "pendingDelete", "deleted"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "users" {
  description = "Details and status of the users migrated in this migration job."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.crossTenantMigrationTask")
    currentStatus = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.crossTenantMigrationServiceStatusDetails")
      errors     = optional(any)
      message    = optional(string)
      service    = optional(string)
      status     = optional(string)
    })))
    lastUpdatedDateTime = optional(string)
    taskType            = optional(string)
  }))
  default = null

  validation {
    condition     = (var.users == null ? true : alltrue([alltrue([for input0 in var.users : (input0 == null ? true : alltrue([(input0["currentStatus"] == null ? true : alltrue([alltrue([for input2 in input0["currentStatus"] : (input2 == null ? true : alltrue([(input2["status"] == null ? true : alltrue([(input2["status"] == null ? true : contains(["notStarted", "valid", "invalid", "error", "inProgress", "completed", "failed", "cancelled", "pendingCancel", "syncing", "synced", "finalizing", "forceComplete"], input2["status"]))]))]))])]))]))])]))
    error_message = "users: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "workloads" {
  description = "Workloads to migrate. Supported workloads are Teams, Exchange, and ODSP (OneDrive/SharePoint)."
  type        = list(string)
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastUpdatedDateTime", "message", "targetTenantId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
