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

  validation {
    condition     = (var.settings == null ? true : alltrue([(var.settings["contentApplicability"] == null ? true : alltrue([(var.settings["contentApplicability"]["safeguard"] == null ? true : alltrue([(var.settings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] == null ? true : alltrue([alltrue([for input3 in var.settings["contentApplicability"]["safeguard"]["disabledSafeguardProfiles"] : (input3 == null ? true : alltrue([(input3["category"] == null ? true : alltrue([(input3["category"] == null ? true : contains(["likelyIssues"], input3["category"]))]))]))])]))]))])), (var.settings["monitoring"] == null ? true : alltrue([(var.settings["monitoring"]["monitoringRules"] == null ? true : alltrue([alltrue([for input2 in var.settings["monitoring"]["monitoringRules"] : (input2 == null ? true : alltrue([(input2["action"] == null ? true : alltrue([(input2["action"] == null ? true : contains(["alertError", "offerFallback", "pauseDeployment"], input2["action"]))])), (input2["signal"] == null ? true : alltrue([(input2["signal"] == null ? true : contains(["rollback", "ineligible"], input2["signal"]))]))]))])]))]))]))
    error_message = "settings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "state" {
  description = "Execution status of the deployment. Returned by default."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.windowsUpdates.deploymentState")
    effectiveValue = optional(string)
    requestedValue = optional(string)
  })
  default = null

  validation {
    condition     = (var.state == null ? true : alltrue([(var.state["effectiveValue"] == null ? true : alltrue([(var.state["effectiveValue"] == null ? true : contains(["scheduled", "offering", "paused", "faulted", "archived"], var.state["effectiveValue"]))])), (var.state["requestedValue"] == null ? true : alltrue([(var.state["requestedValue"] == null ? true : contains(["none", "paused", "archived"], var.state["requestedValue"]))]))]))
    error_message = "state: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
