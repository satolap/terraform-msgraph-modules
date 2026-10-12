variable "audience" {
  description = "Specifies the audience to target."
  type        = any
  default     = null
}

variable "compliance_change_rules" {
  description = "Rules for governing the automatic creation of compliance changes."
  type        = any
  default     = null
}

variable "compliance_changes" {
  description = "Compliance changes like content approvals which result in the automatic creation of deployments using the audience and deploymentSettings of the policy."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the update policy was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "deployment_settings" {
  description = "Settings for governing how to deploy content."
  type = object({
    odata_type = optional(string, "#microsoft.graph.windowsUpdates.deploymentSettings")
    contentApplicability = optional(object({
      odata_type              = optional(string, "#microsoft.graph.windowsUpdates.contentApplicabilitySettings")
      offerWhileRecommendedBy = optional(list(string))
      safeguard = optional(object({
        odata_type = optional(string, "#microsoft.graph.windowsUpdates.safeguardSettings")
        disabledSafeguardProfiles = optional(list(object({
          odata_type = optional(string, "#microsoft.graph.windowsUpdates.safeguardProfile")
          category   = optional(string)
        })))
      }))
    }))
    expedite = optional(object({
      odata_type      = optional(string, "#microsoft.graph.windowsUpdates.expediteSettings")
      isExpedited     = optional(bool)
      isReadinessTest = optional(bool)
    }))
    monitoring = optional(object({
      odata_type = optional(string, "#microsoft.graph.windowsUpdates.monitoringSettings")
      monitoringRules = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.windowsUpdates.monitoringRule")
        action     = optional(string)
        signal     = optional(string)
        threshold  = optional(number)
      })))
    }))
    schedule = optional(object({
      odata_type     = optional(string, "#microsoft.graph.windowsUpdates.scheduleSettings")
      gradualRollout = optional(any)
      startDateTime  = optional(string)
    }))
    userExperience = optional(object({
      odata_type            = optional(string, "#microsoft.graph.windowsUpdates.userExperienceSettings")
      daysUntilForcedReboot = optional(number)
      isHotpatchEnabled     = optional(bool)
      offerAsOptional       = optional(bool)
    }))
  })
  default = null
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
