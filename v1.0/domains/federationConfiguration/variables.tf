variable "domain-id" {
  description = "The unique identifier of domain"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.domain-id)) > 0
    error_message = "domain-id must not be empty."
  }
}

variable "activeSignInUri" {
  description = "URL of the endpoint used by active clients when authenticating with federated domains set up for single sign-on in Microsoft Entra ID. Corresponds to the ActiveLogOnUri property of the Set-EntraDomainFederationSettings PowerShell cmdlet."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the identity provider."
  type        = string
  default     = null
}

variable "federatedIdpMfaBehavior" {
  description = "Determines whether Microsoft Entra ID accepts the MFA performed by the federated IdP when a federated user accesses an application that is governed by a conditional access policy that requires MFA. The possible values are: acceptIfMfaDoneByFederatedIdp, enforceMfaByFederatedIdp, rejectMfaByFederatedIdp, unknownFutureValue. For more information, see federatedIdpMfaBehavior values."
  type        = string
  default     = null

  validation {
    condition     = var.federatedIdpMfaBehavior == null ? true : contains(["acceptIfMfaDoneByFederatedIdp", "enforceMfaByFederatedIdp", "rejectMfaByFederatedIdp"], var.federatedIdpMfaBehavior)
    error_message = "federatedIdpMfaBehavior must be one of the documented enum values."
  }
}

variable "isSignedAuthenticationRequestRequired" {
  description = "If true, when SAML authentication requests are sent to the federated SAML IdP, Microsoft Entra ID will sign those requests using the OrgID signing key. If false (default), the SAML authentication requests sent to the federated IdP aren't signed."
  type        = bool
  default     = null
}

variable "issuerUri" {
  description = "Issuer URI of the federation server."
  type        = string
  default     = null
}

variable "metadataExchangeUri" {
  description = "URI of the metadata exchange endpoint used for authentication from rich client applications."
  type        = string
  default     = null
}

variable "nextSigningCertificate" {
  description = "Fallback token signing certificate that can also be used to sign tokens, for example when the primary signing certificate expires. Formatted as Base64 encoded strings of the public portion of the federated IdP's token signing certificate. Needs to be compatible with the X509Certificate2 class. Much like the signingCertificate, the nextSigningCertificate property is used if a rollover is required outside of the auto-rollover update, a new federation service is being set up, or if the new token signing certificate isn't present in the federation properties after the federation service certificate has been updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.internalDomainFederation"
  nullable    = false
}

variable "passiveSignInUri" {
  description = "URI that web-based clients are directed to when signing in to Microsoft Entra services."
  type        = string
  default     = null
}

variable "passwordResetUri" {
  description = "Microsoft Graph passwordResetUri property."
  type        = string
  default     = null
  sensitive   = true
}

variable "preferredAuthenticationProtocol" {
  description = "Preferred authentication protocol. The possible values are: wsFed, saml, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.preferredAuthenticationProtocol == null ? true : contains(["wsFed", "saml"], var.preferredAuthenticationProtocol)
    error_message = "preferredAuthenticationProtocol must be one of the documented enum values."
  }
}

variable "promptLoginBehavior" {
  description = "Sets the preferred behavior for the sign-in prompt. The possible values are: translateToFreshPasswordAuthentication, nativeSupport, disabled, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.promptLoginBehavior == null ? true : contains(["translateToFreshPasswordAuthentication", "nativeSupport", "disabled"], var.promptLoginBehavior)
    error_message = "promptLoginBehavior must be one of the documented enum values."
  }
}

variable "signOutUri" {
  description = "URI that clients are redirected to when they sign out of Microsoft Entra services. Corresponds to the LogOffUri property of the Set-EntraDomainFederationSettings PowerShell cmdlet."
  type        = string
  default     = null
}

variable "signingCertificate" {
  description = "Current certificate used to sign tokens passed to the Microsoft identity platform. The certificate is formatted as a Base64 encoded string of the public portion of the federated IdP's token signing certificate and must be compatible with the X509Certificate2 class.   This property is used in the following scenarios:  if a rollover is required outside of the autorollover update a new federation service is being set up  if the new token signing certificate isn't present in the federation properties after the federation service certificate has been updated.   Microsoft Entra ID updates certificates via an autorollover process in which it attempts to retrieve a new certificate from the federation service metadata, 30 days before expiry of the current certificate. If a new certificate isn't available, Microsoft Entra ID monitors the metadata daily and will update the federation settings for the domain when a new certificate is available."
  type        = string
  default     = null
}

variable "signingCertificateUpdateStatus" {
  description = "Provides status and timestamp of the last update of the signing certificate."
  type = object({
    odata_type = optional(string, "#microsoft.graph.signingCertificateUpdateStatus")
  })
  default = null
}

variable "systemBrowserEnabledOn" {
  description = "Microsoft Graph systemBrowserEnabledOn property."
  type        = string
  default     = null

  validation {
    condition     = var.systemBrowserEnabledOn == null ? true : try(alltrue([for value in split(",", var.systemBrowserEnabledOn) : contains(["none", "ios", "android", "mac", "linux"], lower(trimspace(value)))]), false)
    error_message = "systemBrowserEnabledOn must be one or more of the documented enum values, separated by commas."
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
