variable "audience" {
  description = "Specifies the audience to target."
  type        = any
  default     = null
}

variable "compliance_change_rules" {
  description = "Rules for governing the automatic creation of compliance changes."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.windowsUpdates.complianceChangeRule")
    createdDateTime       = optional(string)
    lastEvaluatedDateTime = optional(string)
    lastModifiedDateTime  = optional(string)
  }))
  default = null
}

variable "compliance_changes" {
  description = "Compliance changes like content approvals which result in the automatic creation of deployments using the audience and deploymentSettings of the policy."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.windowsUpdates.complianceChange")
    createdDateTime = optional(string)
    isRevoked       = optional(bool)
    revokedDateTime = optional(string)
    updatePolicy    = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time when the update policy was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "deployment_settings" {
  description = "Settings for governing how to deploy content."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.updatePolicy"
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
