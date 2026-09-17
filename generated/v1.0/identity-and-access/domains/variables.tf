variable "authentication_type" {
  description = "Indicates the configured authentication type for the domain. The value is either Managed or Federated. Managed indicates a cloud managed domain where Microsoft Entra ID performs user authentication. Federated indicates authentication is federated with an identity provider such as the tenant's on-premises Active Directory via Active Directory Federation Services. Not nullable.  To update this property in delegated scenarios, the calling app must be assigned the Domain-InternalFederation.ReadWrite.All permission."
  type        = string
  default     = null
}

variable "availability_status" {
  description = "This property is always null except when the verify action is used. When the verify action is used, a domain entity is returned in the response. The availabilityStatus property of the domain entity in the response is either AvailableImmediately or EmailVerifiedDomainTakeoverScheduled."
  type        = string
  default     = null
}

variable "federation_configuration" {
  description = "Domain settings configured by a customer when federated with Microsoft Entra ID. Doesn't support $expand."
  type = list(object({
    odata_type                            = optional(string, "#microsoft.graph.internalDomainFederation")
    activeSignInUri                       = optional(string)
    displayName                           = optional(string)
    federatedIdpMfaBehavior               = optional(any)
    isSignedAuthenticationRequestRequired = optional(bool)
    issuerUri                             = optional(string)
    metadataExchangeUri                   = optional(string)
    nextSigningCertificate                = optional(string)
    passiveSignInUri                      = optional(string)
    passwordResetUri                      = optional(string)
    preferredAuthenticationProtocol       = optional(any)
    promptLoginBehavior                   = optional(any)
    signOutUri                            = optional(string)
    signingCertificate                    = optional(string)
    signingCertificateUpdateStatus        = optional(any)
    systemBrowserEnabledOn                = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "is_admin_managed" {
  description = "The value of the property is false if the DNS record management of the domain is delegated to Microsoft 365. Otherwise, the value is true. Not nullable"
  type        = bool
  default     = null
}

variable "is_default" {
  description = "true if this is the default domain that is used for user creation. There's only one default domain per company. Not nullable."
  type        = bool
  default     = null
}

variable "is_initial" {
  description = "true if this is the initial domain created by Microsoft Online Services (contoso.com). There's only one initial domain per company. Not nullable"
  type        = bool
  default     = null
}

variable "is_root" {
  description = "true if the domain is a verified root domain. Otherwise, false if the domain is a subdomain or unverified. Not nullable."
  type        = bool
  default     = null
}

variable "is_verified" {
  description = "true if the domain completed domain ownership verification. Not nullable."
  type        = bool
  default     = null
}

variable "manufacturer" {
  description = "Microsoft Graph manufacturer property."
  type        = string
  default     = null
}

variable "model" {
  description = "Microsoft Graph model property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.domain"
  nullable    = false
}

variable "password_notification_window_in_days" {
  description = "Specifies the number of days before a user receives notification that their password expires. If the property isn't set, a default value of 14 days is used."
  type        = number
  default     = null
  sensitive   = true
}

variable "password_validity_period_in_days" {
  description = "Specifies the length of time that a password is valid before it must be changed. If the property isn't set, a default value of 90 days is used."
  type        = number
  default     = null
  sensitive   = true
}

variable "state" {
  description = "Status of asynchronous operations scheduled for the domain."
  type        = any
  default     = null
}

variable "supported_services" {
  description = "The capabilities assigned to the domain. Can include 0, 1 or more of following values: Email, Sharepoint, EmailInternalRelayOnly, OfficeCommunicationsOnline, SharePointDefaultDomain, FullRedelegation, SharePointPublic, OrgIdAuthentication, Yammer, Intune. The values that you can add or remove using the API include: Email, OfficeCommunicationsOnline, Yammer. Not nullable."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["domainNameReferences", "id", "rootDomain", "serviceConfigurationRecords", "verificationDnsRecords"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
