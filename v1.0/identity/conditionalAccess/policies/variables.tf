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

  validation {
    condition     = (var.conditions == null ? true : alltrue([(var.conditions["applications"] == null ? true : alltrue([(var.conditions["applications"]["applicationFilter"] == null ? true : alltrue([(var.conditions["applications"]["applicationFilter"]["mode"] == null ? true : alltrue([(var.conditions["applications"]["applicationFilter"]["mode"] == null ? true : contains(["include", "exclude"], var.conditions["applications"]["applicationFilter"]["mode"]))]))]))])), (var.conditions["authenticationFlows"] == null ? true : alltrue([(var.conditions["authenticationFlows"]["transferMethods"] == null ? true : alltrue([(var.conditions["authenticationFlows"]["transferMethods"] == null ? true : try(alltrue([for value in split(",", var.conditions["authenticationFlows"]["transferMethods"]) : contains(["none", "devicecodeflow", "authenticationtransfer"], lower(trimspace(value)))]), false))]))])), (var.conditions["clientAppTypes"] == null ? true : alltrue([alltrue([for input1 in var.conditions["clientAppTypes"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["all", "browser", "mobileAppsAndDesktopClients", "exchangeActiveSync", "easSupported", "other"], input1))]))])])), (var.conditions["clientApplications"] == null ? true : alltrue([(var.conditions["clientApplications"]["servicePrincipalFilter"] == null ? true : alltrue([(var.conditions["clientApplications"]["servicePrincipalFilter"]["mode"] == null ? true : alltrue([(var.conditions["clientApplications"]["servicePrincipalFilter"]["mode"] == null ? true : contains(["include", "exclude"], var.conditions["clientApplications"]["servicePrincipalFilter"]["mode"]))]))]))])), (var.conditions["devices"] == null ? true : alltrue([(var.conditions["devices"]["deviceFilter"] == null ? true : alltrue([(var.conditions["devices"]["deviceFilter"]["mode"] == null ? true : alltrue([(var.conditions["devices"]["deviceFilter"]["mode"] == null ? true : contains(["include", "exclude"], var.conditions["devices"]["deviceFilter"]["mode"]))]))]))])), (var.conditions["insiderRiskLevels"] == null ? true : alltrue([(var.conditions["insiderRiskLevels"] == null ? true : try(alltrue([for value in split(",", var.conditions["insiderRiskLevels"]) : contains(["minor", "moderate", "elevated"], lower(trimspace(value)))]), false))])), (var.conditions["platforms"] == null ? true : alltrue([(var.conditions["platforms"]["excludePlatforms"] == null ? true : alltrue([alltrue([for input2 in var.conditions["platforms"]["excludePlatforms"] : (input2 == null ? true : alltrue([(input2 == null ? true : contains(["android", "iOS", "windows", "windowsPhone", "macOS", "all"], input2))]))])])), (var.conditions["platforms"]["includePlatforms"] == null ? true : alltrue([alltrue([for input2 in var.conditions["platforms"]["includePlatforms"] : (input2 == null ? true : alltrue([(input2 == null ? true : contains(["android", "iOS", "windows", "windowsPhone", "macOS", "all"], input2))]))])]))])), (var.conditions["servicePrincipalRiskLevels"] == null ? true : alltrue([alltrue([for input1 in var.conditions["servicePrincipalRiskLevels"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["low", "medium", "high", "hidden", "none"], input1))]))])])), (var.conditions["signInRiskLevels"] == null ? true : alltrue([alltrue([for input1 in var.conditions["signInRiskLevels"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["low", "medium", "high", "hidden", "none"], input1))]))])])), (var.conditions["userRiskLevels"] == null ? true : alltrue([alltrue([for input1 in var.conditions["userRiskLevels"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["low", "medium", "high", "hidden", "none"], input1))]))])])), (var.conditions["users"] == null ? true : alltrue([(var.conditions["users"]["excludeGuestsOrExternalUsers"] == null ? true : alltrue([(var.conditions["users"]["excludeGuestsOrExternalUsers"]["guestOrExternalUserTypes"] == null ? true : alltrue([(var.conditions["users"]["excludeGuestsOrExternalUsers"]["guestOrExternalUserTypes"] == null ? true : try(alltrue([for value in split(",", var.conditions["users"]["excludeGuestsOrExternalUsers"]["guestOrExternalUserTypes"]) : contains(["none", "internalguest", "b2bcollaborationguest", "b2bcollaborationmember", "b2bdirectconnectuser", "otherexternaluser", "serviceprovider"], lower(trimspace(value)))]), false))]))])), (var.conditions["users"]["includeGuestsOrExternalUsers"] == null ? true : alltrue([(var.conditions["users"]["includeGuestsOrExternalUsers"]["guestOrExternalUserTypes"] == null ? true : alltrue([(var.conditions["users"]["includeGuestsOrExternalUsers"]["guestOrExternalUserTypes"] == null ? true : try(alltrue([for value in split(",", var.conditions["users"]["includeGuestsOrExternalUsers"]["guestOrExternalUserTypes"]) : contains(["none", "internalguest", "b2bcollaborationguest", "b2bcollaborationmember", "b2bdirectconnectuser", "otherexternaluser", "serviceprovider"], lower(trimspace(value)))]), false))]))]))]))]))
    error_message = "conditions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "deletedDateTime" {
  description = "Microsoft Graph deletedDateTime property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Specifies a display name for the conditionalAccessPolicy object."
  type        = string
  default     = null
}

variable "grantControls" {
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

  validation {
    condition     = (var.grantControls == null ? true : alltrue([(var.grantControls["builtInControls"] == null ? true : alltrue([alltrue([for input1 in var.grantControls["builtInControls"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["block", "mfa", "compliantDevice", "domainJoinedDevice", "approvedApplication", "compliantApplication", "passwordChange"], input1))]))])]))]))
    error_message = "grantControls: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.conditionalAccessPolicy"
  nullable    = false
}

variable "sessionControls" {
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

  validation {
    condition     = (var.sessionControls == null ? true : alltrue([(var.sessionControls["cloudAppSecurity"] == null ? true : alltrue([(var.sessionControls["cloudAppSecurity"]["cloudAppSecurityType"] == null ? true : alltrue([(var.sessionControls["cloudAppSecurity"]["cloudAppSecurityType"] == null ? true : contains(["mcasConfigured", "monitorOnly", "blockDownloads"], var.sessionControls["cloudAppSecurity"]["cloudAppSecurityType"]))]))])), (var.sessionControls["persistentBrowser"] == null ? true : alltrue([(var.sessionControls["persistentBrowser"]["mode"] == null ? true : alltrue([(var.sessionControls["persistentBrowser"]["mode"] == null ? true : contains(["always", "never"], var.sessionControls["persistentBrowser"]["mode"]))]))])), (var.sessionControls["signInFrequency"] == null ? true : alltrue([(var.sessionControls["signInFrequency"]["authenticationType"] == null ? true : alltrue([(var.sessionControls["signInFrequency"]["authenticationType"] == null ? true : contains(["primaryAndSecondaryAuthentication", "secondaryAuthentication"], var.sessionControls["signInFrequency"]["authenticationType"]))])), (var.sessionControls["signInFrequency"]["frequencyInterval"] == null ? true : alltrue([(var.sessionControls["signInFrequency"]["frequencyInterval"] == null ? true : contains(["timeBased", "everyTime"], var.sessionControls["signInFrequency"]["frequencyInterval"]))])), (var.sessionControls["signInFrequency"]["type"] == null ? true : alltrue([(var.sessionControls["signInFrequency"]["type"] == null ? true : contains(["days", "hours"], var.sessionControls["signInFrequency"]["type"]))]))]))]))
    error_message = "sessionControls: nested required attributes must be non-null and enum values must be supported input members."
  }
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

variable "templateId" {
  description = "Specifies the unique identifier of a Conditional Access template. Inherited from entity."
  type        = string
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
