variable "applies_to" {
  description = "Collection of applications and service principals to which the policy is applied."
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
    }))
    keyCredentials = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")
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
