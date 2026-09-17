variable "created_date_time" {
  description = "The date and time when the snapshot was created."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.entraRecoveryServices.snapshot"
  nullable    = false
}

variable "recovery_jobs" {
  description = "Collection of recovery jobs created for this snapshot."
  type = list(object({
    odata_type                    = optional(string, "#microsoft.graph.entraRecoveryServices.recoveryJob")
    filteringCriteria             = optional(any)
    jobCompletionDateTime         = optional(string)
    jobStartDateTime              = optional(string)
    status                        = optional(string)
    targetStateDateTime           = optional(string)
    totalChangedLinksCalculated   = optional(number)
    totalChangedObjectsCalculated = optional(number)
    totalFailedChanges            = optional(number)
    totalLinksModified            = optional(number)
    totalObjectsModified          = optional(number)
  }))
  default = null
}

variable "recovery_preview_jobs" {
  description = "Collection of preview jobs created for this snapshot."
  type = list(object({
    odata_type                    = optional(string, "#microsoft.graph.entraRecoveryServices.recoveryPreviewJob")
    filteringCriteria             = optional(any)
    jobCompletionDateTime         = optional(string)
    jobStartDateTime              = optional(string)
    status                        = optional(string)
    targetStateDateTime           = optional(string)
    totalChangedLinksCalculated   = optional(number)
    totalChangedObjectsCalculated = optional(number)
  }))
  default = null
}

variable "total_changed_objects" {
  description = "The total number of changed objects identified in this snapshot."
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
