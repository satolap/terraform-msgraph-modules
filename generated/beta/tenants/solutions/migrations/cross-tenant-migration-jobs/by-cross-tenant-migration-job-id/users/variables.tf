variable "cross_tenant_migration_job_id" {
  description = "The unique identifier of crossTenantMigrationJob"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.cross_tenant_migration_job_id)) > 0
    error_message = "cross_tenant_migration_job_id must not be empty."
  }
}

variable "current_status" {
  description = "Most recent status of this migration task"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.crossTenantMigrationServiceStatusDetails")
    errors = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.error")
      code       = optional(string)
      message    = optional(string)
    })))
    message = optional(string)
    service = optional(string)
    status  = optional(string)
  }))
  default = null
}

variable "last_updated_date_time" {
  description = "Time the task was last updated"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.crossTenantMigrationTask"
  nullable    = false
}

variable "task_type" {
  description = "Type of migration task. Only Users are supported at this time."
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
