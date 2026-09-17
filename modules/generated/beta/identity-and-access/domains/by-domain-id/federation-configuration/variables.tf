variable "domain_id" {
  description = "The unique identifier of domain"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.domain_id)) > 0
    error_message = "domain_id must not be empty."
  }
}

variable "active_sign_in_uri" {
  description = "URL of the endpoint used by active clients when authenticating with federated domains set up for single sign-on in Microsoft Entra ID. Corresponds to the ActiveLogOnUri property of the Set-EntraDomainFederationSettings PowerShell cmdlet."
  type        = string
  default     = null
}

variable "default_interactive_authentication_method" {
  description = "Microsoft Graph defaultInteractiveAuthenticationMethod property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the identity provider."
  type        = string
  default     = null
}

variable "federated_idp_mfa_behavior" {
  description = "Determines whether Microsoft Entra ID accepts the MFA performed by the federated IdP when a federated user accesses an application that is governed by a conditional access policy that requires MFA. The possible values are: acceptIfMfaDoneByFederatedIdp, enforceMfaByFederatedIdp, rejectMfaByFederatedIdp, unknownFutureValue. For more information, see federatedIdpMfaBehavior values."
  type        = any
  default     = null

  validation {
    condition     = var.federated_idp_mfa_behavior == null ? true : contains(["acceptIfMfaDoneByFederatedIdp", "enforceMfaByFederatedIdp", "rejectMfaByFederatedIdp", "unknownFutureValue"], var.federated_idp_mfa_behavior)
    error_message = "federated_idp_mfa_behavior must be one of the documented enum values."
  }
}

variable "is_signed_authentication_request_required" {
  description = "If true, when SAML authentication requests are sent to the federated SAML IdP, Microsoft Entra ID will sign those requests using the OrgID signing key. If false (default), the SAML authentication requests sent to the federated IdP aren't signed."
  type        = bool
  default     = null
}

variable "issuer_uri" {
  description = "Issuer URI of the federation server."
  type        = string
  default     = null
}

variable "metadata_exchange_uri" {
  description = "URI of the metadata exchange endpoint used for authentication from rich client applications."
  type        = string
  default     = null
}

variable "next_signing_certificate" {
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

variable "open_id_connect_discovery_endpoint" {
  description = "Microsoft Graph openIdConnectDiscoveryEndpoint property."
  type        = string
  default     = null
}

variable "passive_sign_in_uri" {
  description = "URI that web-based clients are directed to when signing in to Microsoft Entra services."
  type        = string
  default     = null
}

variable "password_change_uri" {
  description = "Microsoft Graph passwordChangeUri property."
  type        = string
  default     = null
  sensitive   = true
}

variable "password_reset_uri" {
  description = "URI that clients are redirected to for resetting their password."
  type        = string
  default     = null
  sensitive   = true
}

variable "preferred_authentication_protocol" {
  description = "Preferred authentication protocol. Supported values include saml or wsfed."
  type        = any
  default     = null

  validation {
    condition     = var.preferred_authentication_protocol == null ? true : contains(["wsFed", "saml", "unknownFutureValue"], var.preferred_authentication_protocol)
    error_message = "preferred_authentication_protocol must be one of the documented enum values."
  }
}

variable "prompt_login_behavior" {
  description = "Sets the preferred behavior for the sign-in prompt. The possible values are: translateToFreshPasswordAuthentication, nativeSupport, disabled, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.prompt_login_behavior == null ? true : contains(["translateToFreshPasswordAuthentication", "nativeSupport", "disabled", "unknownFutureValue"], var.prompt_login_behavior)
    error_message = "prompt_login_behavior must be one of the documented enum values."
  }
}

variable "sign_out_uri" {
  description = "URI that clients are redirected to when they sign out of Microsoft Entra services. Corresponds to the LogOffUri property of the Set-EntraDomainFederationSettings PowerShell cmdlet."
  type        = string
  default     = null
}

variable "signing_certificate" {
  description = "Current certificate used to sign tokens passed to the Microsoft identity platform. The certificate is formatted as a Base64 encoded string of the public portion of the federated IdP's token signing certificate and must be compatible with the X509Certificate2 class.   This property is used in the following scenarios:  if a rollover is required outside of the autorollover update a new federation service is being set up  if the new token signing certificate isn't present in the federation properties after the federation service certificate has been updated.   Microsoft Entra ID updates certificates via an autorollover process in which it attempts to retrieve a new certificate from the federation service metadata, 30 days before expiry of the current certificate. If a new certificate isn't available, Microsoft Entra ID monitors the metadata daily and will update the federation settings for the domain when a new certificate is available."
  type        = string
  default     = null
}

variable "signing_certificate_update_status" {
  description = "Provides status and timestamp of the last update of the signing certificate."
  type        = any
  default     = null
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
