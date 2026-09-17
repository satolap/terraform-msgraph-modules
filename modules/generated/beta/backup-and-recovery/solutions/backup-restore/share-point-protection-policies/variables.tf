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
  default     = "#microsoft.graph.sharePointProtectionPolicy"
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

variable "site_exclusion_units" {
  description = "The site exclusion units associated with the SharePoint protection policy."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.siteExclusionUnit")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    error                = optional(any)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    policyId             = optional(string)
    siteId               = optional(string)
  }))
  default = null
}

variable "site_exclusion_units_bulk_addition_jobs" {
  description = "The list of bulk addition jobs for site exclusion units associated with the SharePoint protection policy."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.siteExclusionUnitsBulkAdditionJob")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    displayName          = optional(string)
    error                = optional(any)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    siteWebUrls          = optional(list(string))
    status               = optional(string)
  }))
  default = null
}

variable "site_inclusion_rules" {
  description = "The rules associated with the SharePoint Protection policy."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.siteProtectionRule")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    error                = optional(any)
    isAutoApplyEnabled   = optional(bool)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    siteExpression       = optional(string)
    status               = optional(any)
  }))
  default = null
}

variable "site_protection_units" {
  description = "The protection units (sites) that are protected under the site protection policy."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.siteProtectionUnit")
    backupRetentionPeriodInDays = optional(number)
    billingPolicyId             = optional(string)
    createdBy                   = optional(any)
    createdDateTime             = optional(string)
    error                       = optional(any)
    lastModifiedBy              = optional(any)
    lastModifiedDateTime        = optional(string)
    offboardRequestedDateTime   = optional(string)
    policyId                    = optional(string)
    protectionSources           = optional(string)
    siteId                      = optional(string)
    status                      = optional(any)
  }))
  default = null
}

variable "site_protection_units_bulk_addition_jobs" {
  description = "Microsoft Graph siteProtectionUnitsBulkAdditionJobs property."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.siteProtectionUnitsBulkAdditionJob")
    createdBy            = optional(any)
    createdDateTime      = optional(string)
    displayName          = optional(string)
    error                = optional(any)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    siteIds              = optional(list(string))
    siteWebUrls          = optional(list(string))
    status               = optional(string)
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
