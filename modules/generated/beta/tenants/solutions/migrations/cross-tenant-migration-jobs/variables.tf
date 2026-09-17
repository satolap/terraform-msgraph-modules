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
  type        = any
  default     = null
}

variable "job_type" {
  description = "Microsoft Graph jobType property."
  type        = string
  default     = null

  validation {
    condition     = var.job_type == null ? true : contains(["validate", "migrate", "unknownFutureValue"], var.job_type)
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
    condition     = var.status == null ? true : contains(["submitted", "approved", "processing", "cuttingOver", "inProgress", "completed", "completedWithErrors", "failed", "cancelled", "pendingCancel", "adminActionRequired", "validateSubmitted", "validateProcessing", "validateInProgress", "validatePassed", "validateFailed", "pendingDelete", "deleted", "unknownFutureValue"], var.status)
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
}

variable "workloads" {
  description = "Workloads to migrate. Supported workloads are Teams, Exchange, and ODSP (OneDrive/SharePoint)."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastUpdatedDateTime", "message", "targetTenantId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
