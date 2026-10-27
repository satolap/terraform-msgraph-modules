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

  validation {
    condition     = (var.restrictions == null ? true : alltrue([(var.restrictions["applicationRestrictions"] == null ? true : alltrue([(var.restrictions["applicationRestrictions"]["identifierUris"] == null ? true : alltrue([(var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"] == null ? true : alltrue([(var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["state"] == null ? true : alltrue([(var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["state"] == null ? true : contains(["enabled", "disabled"], var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["state"]))]))])), (var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"] == null ? true : alltrue([(var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["state"] == null ? true : alltrue([(var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["state"] == null ? true : contains(["enabled", "disabled"], var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["state"]))]))]))]))])), (var.restrictions["keyCredentials"] == null ? true : alltrue([alltrue([for input1 in var.restrictions["keyCredentials"] : (input1 == null ? true : alltrue([(input1["restrictionType"] == null ? true : alltrue([(input1["restrictionType"] == null ? true : contains(["asymmetricKeyLifetime"], input1["restrictionType"]))])), (input1["state"] == null ? true : alltrue([(input1["state"] == null ? true : contains(["enabled", "disabled"], input1["state"]))]))]))])])), (var.restrictions["passwordCredentials"] == null ? true : alltrue([alltrue([for input1 in var.restrictions["passwordCredentials"] : (input1 == null ? true : alltrue([(input1["restrictionType"] == null ? true : alltrue([(input1["restrictionType"] == null ? true : contains(["passwordAddition", "passwordLifetime", "symmetricKeyAddition", "symmetricKeyLifetime", "customPasswordAddition"], input1["restrictionType"]))])), (input1["state"] == null ? true : alltrue([(input1["state"] == null ? true : contains(["enabled", "disabled"], input1["state"]))]))]))])]))]))
    error_message = "restrictions: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
