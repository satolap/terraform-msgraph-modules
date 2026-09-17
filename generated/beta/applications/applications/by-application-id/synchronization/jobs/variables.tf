variable "application_id" {
  description = "The unique identifier of application"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.application_id)) > 0
    error_message = "application_id must not be empty."
  }
}

variable "bulk_upload" {
  description = "The bulk upload operation for the job."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.synchronizationJob"
  nullable    = false
}

variable "schema" {
  description = "The synchronization schema configured for the job."
  type        = any
  default     = null
}

variable "status" {
  description = "Status of the job, which includes when the job was last run, current job state, and errors."
  type        = any
  default     = null
}

variable "synchronization_job_settings" {
  description = "Settings associated with the job. Some settings are inherited from the template."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "template_id" {
  description = "Identifier of the synchronization template this job is based on."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "schedule"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
