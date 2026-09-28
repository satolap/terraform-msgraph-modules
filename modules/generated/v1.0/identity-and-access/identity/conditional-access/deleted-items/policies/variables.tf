variable "conditions" {
  description = "Microsoft Graph conditions property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.conditionalAccessConditionSet")
    applications = optional(object({
      odata_type = optional(string, "#microsoft.graph.conditionalAccessApplications")
      applicationFilter = optional(object({
        odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")
        mode       = optional(string)
        rule       = optional(string)
      }))
      excludeApplications                         = optional(list(string))
      includeApplications                         = optional(list(string))
      includeAuthenticationContextClassReferences = optional(list(string))
      includeUserActions                          = optional(list(string))
    }))
    authenticationFlows = optional(object({
      odata_type      = optional(string, "#microsoft.graph.conditionalAccessAuthenticationFlows")
      transferMethods = optional(string)
    }))
    clientAppTypes = optional(list(string))
    clientApplications = optional(object({
      odata_type               = optional(string, "#microsoft.graph.conditionalAccessClientApplications")
      excludeServicePrincipals = optional(list(string))
      includeServicePrincipals = optional(list(string))
      servicePrincipalFilter = optional(object({
        odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")
        mode       = optional(string)
        rule       = optional(string)
      }))
    }))
    devices = optional(object({
      odata_type = optional(string, "#microsoft.graph.conditionalAccessDevices")
      deviceFilter = optional(object({
        odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")
        mode       = optional(string)
        rule       = optional(string)
      }))
    }))
    insiderRiskLevels = optional(string)
    locations = optional(object({
      odata_type       = optional(string, "#microsoft.graph.conditionalAccessLocations")
      excludeLocations = optional(list(string))
      includeLocations = optional(list(string))
    }))
    platforms = optional(object({
      odata_type       = optional(string, "#microsoft.graph.conditionalAccessPlatforms")
      excludePlatforms = optional(list(string))
      includePlatforms = optional(list(string))
    }))
    servicePrincipalRiskLevels = optional(list(string))
    signInRiskLevels           = optional(list(string))
    userRiskLevels             = optional(list(string))
    users = optional(object({
      odata_type    = optional(string, "#microsoft.graph.conditionalAccessUsers")
      excludeGroups = optional(list(string))
      excludeGuestsOrExternalUsers = optional(object({
        odata_type               = optional(string, "#microsoft.graph.conditionalAccessGuestsOrExternalUsers")
        externalTenants          = optional(any)
        guestOrExternalUserTypes = optional(string)
      }))
      excludeRoles  = optional(list(string))
      excludeUsers  = optional(list(string))
      includeGroups = optional(list(string))
      includeGuestsOrExternalUsers = optional(object({
        odata_type               = optional(string, "#microsoft.graph.conditionalAccessGuestsOrExternalUsers")
        externalTenants          = optional(any)
        guestOrExternalUserTypes = optional(string)
      }))
      includeRoles = optional(list(string))
      includeUsers = optional(list(string))
    }))
  })
  default = null
}

variable "deleted_date_time" {
  description = "Microsoft Graph deletedDateTime property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Specifies a display name for the conditionalAccessPolicy object."
  type        = string
  default     = null
}

variable "grant_controls" {
  description = "Specifies the grant controls that must be fulfilled to pass the policy."
  type = object({
    odata_type                  = optional(string, "#microsoft.graph.conditionalAccessGrantControls")
    authenticationStrength      = optional(any)
    builtInControls             = optional(list(string))
    customAuthenticationFactors = optional(list(string))
    operator                    = optional(string)
    termsOfUse                  = optional(list(string))
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.conditionalAccessPolicy"
  nullable    = false
}

variable "session_controls" {
  description = "Specifies the session controls that are enforced after sign-in."
  type = object({
    odata_type = optional(string, "#microsoft.graph.conditionalAccessSessionControls")
    applicationEnforcedRestrictions = optional(object({
      odata_type = optional(string, "#microsoft.graph.applicationEnforcedRestrictionsSessionControl")
      isEnabled  = optional(bool)
    }))
    cloudAppSecurity = optional(object({
      odata_type           = optional(string, "#microsoft.graph.cloudAppSecuritySessionControl")
      cloudAppSecurityType = optional(string)
      isEnabled            = optional(bool)
    }))
    disableResilienceDefaults = optional(bool)
    persistentBrowser = optional(object({
      odata_type = optional(string, "#microsoft.graph.persistentBrowserSessionControl")
      isEnabled  = optional(bool)
      mode       = optional(string)
    }))
    secureSignInSession = optional(object({
      odata_type = optional(string, "#microsoft.graph.secureSignInSessionControl")
      isEnabled  = optional(bool)
    }))
    signInFrequency = optional(object({
      odata_type         = optional(string, "#microsoft.graph.signInFrequencySessionControl")
      authenticationType = optional(string)
      frequencyInterval  = optional(string)
      isEnabled          = optional(bool)
      type               = optional(string)
      value              = optional(number)
    }))
  })
  default = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "template_id" {
  description = "Specifies the unique identifier of a Conditional Access template. Inherited from entity."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
