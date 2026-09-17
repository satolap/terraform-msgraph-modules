variable "billing_policy_id" {
  description = "Microsoft Graph billingPolicyId property."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The identity of the person who created the policy."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the policy was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the policy."
  type        = string
  default     = null
}

variable "drive_exclusion_units" {
  description = "The drive exclusion units associated with the OneDrive for work or school protection policy."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.driveExclusionUnit")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    directoryObjectId    = optional(string)
    error                = optional(any)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    policyId             = optional(string)
  }))
  default = null
}

variable "drive_exclusion_units_bulk_addition_jobs" {
  description = "The list of bulk addition jobs for drive exclusion units associated with the OneDrive for work or school protection policy."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.driveExclusionUnitsBulkAdditionJob")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    displayName          = optional(string)
    drives               = optional(list(string))
    error                = optional(any)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    status               = optional(string)
  }))
  default = null
}

variable "drive_inclusion_rules" {
  description = "Contains the details of the OneDrive for Work or School protection rule."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.driveProtectionRule")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    driveExpression      = optional(string)
    error                = optional(any)
    isAutoApplyEnabled   = optional(bool)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    status               = optional(any)
  }))
  default = null
}

variable "drive_protection_units" {
  description = "Contains the protection units associated with a  OneDrive for Work or School protection policy."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.driveProtectionUnit")
    backupRetentionPeriodInDays = optional(number)
    billingPolicyId             = optional(string)
    createdBy                   = optional(any)
    createdDateTime             = optional(string)
    directoryObjectId           = optional(string)
    error                       = optional(any)
    lastModifiedBy              = optional(any)
    lastModifiedDateTime        = optional(string)
    offboardRequestedDateTime   = optional(string)
    policyId                    = optional(string)
    protectionSources           = optional(string)
    status                      = optional(any)
  }))
  default = null
}

variable "drive_protection_units_bulk_addition_jobs" {
  description = "Microsoft Graph driveProtectionUnitsBulkAdditionJobs property."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.driveProtectionUnitsBulkAdditionJob")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    directoryObjectIds   = optional(list(string))
    displayName          = optional(string)
    drives               = optional(list(string))
    error                = optional(any)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    status               = optional(string)
  }))
  default = null
}

variable "is_enabled" {
  description = "Indicates whether the policy is enabled."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the person who last modified the policy."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the policy was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.oneDriveForBusinessProtectionPolicy"
  nullable    = false
}

variable "offboard_requested_date_time" {
  description = "The date and time when offboarding was requested for the protection policy. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "protection_mode" {
  description = "The backup mode for the protection policy. The possible values are: standard, fullServiceBackup, unknownFutureValue. When set to fullServiceBackup, the entire workload is backed up and specific items can be excluded using exclusion units. When set to standard, only the items explicitly added as protection units are backed up."
  type        = any
  default     = null

  validation {
    condition     = var.protection_mode == null ? true : contains(["standard", "fullServiceBackup", "unknownFutureValue"], var.protection_mode)
    error_message = "protection_mode must be one of the documented enum values."
  }
}

variable "protection_policy_artifact_count" {
  description = "The count of artifacts in the protection policy by status. Returned only on $select."
  type        = any
  default     = null
}

variable "retention_settings" {
  description = "Contains the retention setting details for the policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.retentionSetting")
    interval   = optional(string)
    period     = optional(string)
  }))
  default = null
}

variable "status" {
  description = "The aggregated status of the protection units associated with the policy. The possible values are: inactive, activeWithErrors, updating, active, unknownFutureValue, offboardRequested, offboarded. You must use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: offboardRequested, offboarded."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["inactive", "activeWithErrors", "updating", "active", "unknownFutureValue", "offboardRequested", "offboarded"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
