variable "authenticationType" {
  description = "Indicates the configured authentication type for the domain. The value is either Managed or Federated. Managed indicates a cloud managed domain where Microsoft Entra ID performs user authentication. Federated indicates authentication is federated with an identity provider such as the tenant's on-premises Active Directory via Active Directory Federation Services. Not nullable.  To update this property in delegated scenarios, the calling app must be assigned the Domain-InternalFederation.ReadWrite.All permission."
  type        = string
  default     = null
}

variable "availabilityStatus" {
  description = "This property is always null except when the verify action is used. When the verify action is used, a domain entity is returned in the response. The availabilityStatus property of the domain entity in the response is either AvailableImmediately or EmailVerifiedDomainTakeoverScheduled."
  type        = string
  default     = null
}

variable "federationConfiguration" {
  description = "Domain settings configured by customer when federated with Microsoft Entra ID. Does not support $expand."
  type = list(object({
    odata_type                             = optional(string, "#microsoft.graph.internalDomainFederation")
    activeSignInUri                        = optional(string)
    defaultInteractiveAuthenticationMethod = optional(string)
    displayName                            = optional(string)
    federatedIdpMfaBehavior                = optional(string)
    isSignedAuthenticationRequestRequired  = optional(bool)
    issuerUri                              = optional(string)
    metadataExchangeUri                    = optional(string)
    nextSigningCertificate                 = optional(string)
    openIdConnectDiscoveryEndpoint         = optional(string)
    passiveSignInUri                       = optional(string)
    passwordChangeUri                      = optional(string)
    passwordResetUri                       = optional(string)
    preferredAuthenticationProtocol        = optional(string)
    promptLoginBehavior                    = optional(string)
    signOutUri                             = optional(string)
    signingCertificate                     = optional(string)
    signingCertificateUpdateStatus = optional(object({
      odata_type = optional(string, "#microsoft.graph.signingCertificateUpdateStatus")
    }))
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.federationConfiguration == null ? true : alltrue([alltrue([for input0 in var.federationConfiguration : (input0 == null ? true : alltrue([(input0["federatedIdpMfaBehavior"] == null ? true : alltrue([(input0["federatedIdpMfaBehavior"] == null ? true : contains(["acceptIfMfaDoneByFederatedIdp", "enforceMfaByFederatedIdp", "rejectMfaByFederatedIdp"], input0["federatedIdpMfaBehavior"]))])), (input0["preferredAuthenticationProtocol"] == null ? true : alltrue([(input0["preferredAuthenticationProtocol"] == null ? true : contains(["wsFed", "saml"], input0["preferredAuthenticationProtocol"]))])), (input0["promptLoginBehavior"] == null ? true : alltrue([(input0["promptLoginBehavior"] == null ? true : contains(["translateToFreshPasswordAuthentication", "nativeSupport", "disabled"], input0["promptLoginBehavior"]))]))]))])]))
    error_message = "federationConfiguration: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "isAdminManaged" {
  description = "The value of the property is false if the DNS record management of the domain is delegated to Microsoft 365. Otherwise, the value is true. Not nullable."
  type        = bool
  default     = null
}

variable "isDefault" {
  description = "true for the default domain that is used for user creation. There's only one default domain per company. Not nullable."
  type        = bool
  default     = null
}

variable "isInitial" {
  description = "true for the initial domain created by Microsoft Online Services. For example, contoso.onmicrosoft.com. There's only one initial domain per company. Not nullable."
  type        = bool
  default     = null
}

variable "isRoot" {
  description = "true if the domain is a verified root domain. Otherwise, false if the domain is a subdomain or unverified. Not nullable."
  type        = bool
  default     = null
}

variable "isVerified" {
  description = "true for verified domains. Not nullable."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.domain"
  nullable    = false
}

variable "passwordNotificationWindowInDays" {
  description = "Specifies the number of days before a user receives a password expiry notification. 14 days by default."
  type        = number
  default     = null
  sensitive   = true
}

variable "passwordValidityPeriodInDays" {
  description = "Specifies the length of time that a password is valid before it must be changed. 90 days by default."
  type        = number
  default     = null
  sensitive   = true
}

variable "sharedEmailDomainInvitations" {
  description = "Microsoft Graph sharedEmailDomainInvitations property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.sharedEmailDomainInvitation")
    expiryTime       = optional(string)
    invitationDomain = optional(string)
    invitationStatus = optional(string)
  }))
  default = null
}

variable "state" {
  description = "Status of asynchronous operations scheduled for the domain."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.domainState")
    lastActionDateTime = optional(string)
    operation          = optional(string)
    status             = optional(string)
  })
  default = null
}

variable "supportedServices" {
  description = "The capabilities assigned to the domain. Can include 0, 1, or more of following values: Email, Sharepoint, EmailInternalRelayOnly, OfficeCommunicationsOnline,SharePointDefaultDomain, FullRedelegation, SharePointPublic, OrgIdAuthentication, Yammer, Intune, CustomUrlDomain. The values that you can add or remove using the API include: Email, OfficeCommunicationsOnline, Yammer, and CustomUrlDomain. Not nullable.  For more information about CustomUrlDomain, see Custom URL domains in external tenants."
  type        = list(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["domainNameReferences", "id", "rootDomain", "serviceConfigurationRecords", "verificationDnsRecords"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
