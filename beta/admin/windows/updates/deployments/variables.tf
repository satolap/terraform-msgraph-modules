variable "audience" {
  description = "Specifies the audience to which content is deployed."
  type        = any
  default     = null
}

variable "content" {
  description = "Specifies what content to deploy. Cannot be changed. Returned by default."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.deployment"
  nullable    = false
}

variable "settings" {
  description = "Settings specified on the specific deployment governing how to deploy content. Returned by default."
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

variable "state" {
  description = "Execution status of the deployment. Returned by default."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.windowsUpdates.deploymentState")
    effectiveValue = optional(string)
    requestedValue = optional(string)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
