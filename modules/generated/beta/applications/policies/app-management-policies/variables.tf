variable "applies_to" {
  description = "Collection of application and service principals to which a policy is applied."
  type        = any
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for this policy. Required."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for this policy. Required."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "Denotes whether the policy is enabled."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appManagementPolicy"
  nullable    = false
}

variable "restrictions" {
  description = "Restrictions that apply to an application or service principal object."
  type = object({
    odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")
    applicationRestrictions = optional(object({
      odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")
      audiences = optional(object({
        odata_type = optional(string, "#microsoft.graph.audiencesConfiguration")
        azureAdMultipleOrgs = optional(object({
          odata_type = optional(string, "#microsoft.graph.azureAdMultipleOrgsAudienceRestriction")
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          restrictForAppsCreatedAfterDateTime = optional(string)
          state                               = optional(string)
        }))
        personalMicrosoftAccount = optional(any)
      }))
      identifierUris = optional(object({
        odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")
        nonDefaultUriAddition = optional(object({
          odata_type = optional(string, "#microsoft.graph.identifierUriRestriction")
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          excludeAppsReceivingV2Tokens        = optional(bool)
          excludeSaml                         = optional(bool)
          restrictForAppsCreatedAfterDateTime = optional(string)
          state                               = optional(string)
        }))
        uriAdditionWithoutUniqueTenantIdentifier = optional(object({
          odata_type = optional(string, "#microsoft.graph.identifierUriRestriction")
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          excludeAppsReceivingV2Tokens        = optional(bool)
          excludeSaml                         = optional(bool)
          restrictForAppsCreatedAfterDateTime = optional(string)
          state                               = optional(string)
        }))
      }))
      redirectUris = optional(object({
        odata_type = optional(string, "#microsoft.graph.redirectUriConfiguration")
        uriWithBlockedDomain = optional(object({
          odata_type     = optional(string, "#microsoft.graph.redirectUriBlockedDomainConfiguration")
          blockedDomains = optional(list(string))
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          publicClient = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")
            blockedDomains = optional(any)
          }))
          restrictForAppsCreatedAfterDateTime = optional(string)
          spa = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")
            blockedDomains = optional(any)
          }))
          state = optional(string)
          web = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")
            blockedDomains = optional(any)
          }))
        }))
        uriWithBlockedScheme = optional(object({
          odata_type     = optional(string, "#microsoft.graph.redirectUriBlockedSchemeConfiguration")
          blockedSchemes = optional(list(string))
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          exemptFormats = optional(list(string))
          publicClient = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")
            blockedSchemes = optional(any)
            exemptFormats  = optional(any)
          }))
          restrictForAppsCreatedAfterDateTime = optional(string)
          spa = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")
            blockedSchemes = optional(any)
            exemptFormats  = optional(any)
          }))
          state = optional(string)
          web = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")
            blockedSchemes = optional(any)
            exemptFormats  = optional(any)
          }))
        }))
        uriWithWildcard = optional(object({
          odata_type = optional(string, "#microsoft.graph.redirectUriWildcardConfiguration")
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          excludeFormats = optional(object({
            odata_type                        = optional(string, "#microsoft.graph.redirectUriWildcardExcludeFormats")
            excludeWildcardsInPath            = optional(bool)
            excludeWildcardsInPathWithDomains = optional(any)
          }))
          restrictForAppsCreatedAfterDateTime = optional(string)
          state                               = optional(string)
        }))
        uriWithoutAllowedDomain = optional(object({
          odata_type     = optional(string, "#microsoft.graph.redirectUriAllowedDomainConfiguration")
          allowedDomains = optional(list(string))
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          publicClient = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")
            allowedDomains = optional(any)
          }))
          restrictForAppsCreatedAfterDateTime = optional(string)
          spa = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")
            allowedDomains = optional(any)
          }))
          state = optional(string)
          web = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")
            allowedDomains = optional(any)
          }))
        }))
        uriWithoutAllowedScheme = optional(object({
          odata_type     = optional(string, "#microsoft.graph.redirectUriAllowedSchemeConfiguration")
          allowedSchemes = optional(list(string))
          excludeActors = optional(object({
            odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
            customSecurityAttributes = optional(any)
          }))
          publicClient = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")
            allowedSchemes = optional(any)
          }))
          restrictForAppsCreatedAfterDateTime = optional(string)
          spa = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")
            allowedSchemes = optional(any)
          }))
          state = optional(string)
          web = optional(object({
            odata_type     = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")
            allowedSchemes = optional(any)
          }))
        }))
      }))
    }))
    keyCredentials = optional(list(object({
      odata_type                                  = optional(string, "#microsoft.graph.keyCredentialConfiguration")
      certificateBasedApplicationConfigurationIds = optional(list(string))
      excludeActors = optional(object({
        odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
        customSecurityAttributes = optional(any)
      }))
      maxLifetime                         = optional(string)
      restrictForAppsCreatedAfterDateTime = optional(string)
      restrictionType                     = optional(string)
      state                               = optional(string)
    })))
    passwordCredentials = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")
      excludeActors = optional(object({
        odata_type               = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")
        customSecurityAttributes = optional(any)
      }))
      maxLifetime                         = optional(string)
      restrictForAppsCreatedAfterDateTime = optional(string)
      restrictionType                     = optional(string)
      state                               = optional(string)
    })))
  })
  default   = null
  sensitive = true
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
