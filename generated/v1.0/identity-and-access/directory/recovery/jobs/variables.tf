variable "filtering_criteria" {
  description = "Optional filtering criteria used to scope the job to specific entity types or entity IDs."
  type        = any
  default     = null
}

variable "job_completion_date_time" {
  description = "The date and time when the job completed. Null if the job is still running."
  type        = string
  default     = null
}

variable "job_start_date_time" {
  description = "The date and time when the job started."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.entraRecoveryServices.recoveryJobBase"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["initialized", "running", "successful", "failed", "abandoned", "unknownFutureValue", "calculating", "loadingData"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "target_state_date_time" {
  description = "The target snapshot timestamp to which the tenant is being restored. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "total_changed_links_calculated" {
  description = "The total count of changed directory object links (relationships) calculated by the job. null until the job completes calculation. Not all calculated link changes may be successfully applied; see totalLinksModified on derived types for the count of links that were actually modified."
  type        = number
  default     = null
}

variable "total_changed_objects_calculated" {
  description = "The total count of changed directory objects calculated by the job. null until the job completes calculation. Not all calculated object changes may be successfully applied; see totalObjectsModified on derived types for the count of objects that were actually modified."
  type        = number
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
