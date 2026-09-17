variable "on_premises_publishing_profile_id" {
  description = "The unique identifier of onPremisesPublishingProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.on_premises_publishing_profile_id)) > 0
    error_message = "on_premises_publishing_profile_id must not be empty."
  }
}

variable "applications" {
  description = "Microsoft Graph applications property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.application")
    api        = optional(any)
    appManagementPolicies = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.appManagementPolicy")
      appliesTo       = optional(any)
      deletedDateTime = optional(string)
      description     = optional(string)
      displayName     = optional(string)
      isEnabled       = optional(bool)
      restrictions    = optional(any)
    })))
    appRoles = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.appRole")
      allowedMemberTypes = optional(list(string))
      description        = optional(string)
      displayName        = optional(string)
      id                 = optional(string)
      isEnabled          = optional(bool)
      value              = optional(string)
    })))
    authenticationBehaviors   = optional(any)
    certification             = optional(any)
    connectorGroup            = optional(any)
    defaultRedirectUri        = optional(string)
    deletedDateTime           = optional(string)
    description               = optional(string)
    disabledByMicrosoftStatus = optional(string)
    displayName               = optional(string)
    federatedIdentityCredentials = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.federatedIdentityCredential")
      audiences                = optional(list(string))
      claimsMatchingExpression = optional(any)
      description              = optional(string)
      issuer                   = optional(string)
      name                     = optional(string)
      subject                  = optional(string)
    })))
    groupMembershipClaims = optional(string)
    homeRealmDiscoveryPolicies = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")
      appliesTo             = optional(any)
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    identifierUris            = optional(list(string))
    info                      = optional(any)
    isDeviceOnlyAuthSupported = optional(bool)
    isDisabled                = optional(bool)
    isFallbackPublicClient    = optional(bool)
    keyCredentials = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.keyCredential")
      customKeyIdentifier = optional(string)
      displayName         = optional(string)
      endDateTime         = optional(string)
      key                 = optional(string)
      keyId               = optional(string)
      startDateTime       = optional(string)
      type                = optional(string)
      usage               = optional(string)
    })))
    logo                            = optional(string)
    nativeAuthenticationApisEnabled = optional(any)
    notes                           = optional(string)
    onPremisesPublishing            = optional(any)
    optionalClaims                  = optional(any)
    parentalControlSettings         = optional(any)
    passwordCredentials = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.passwordCredential")
      customKeyIdentifier = optional(string)
      displayName         = optional(string)
      endDateTime         = optional(string)
      keyId               = optional(string)
      startDateTime       = optional(string)
    })))
    publicClient                 = optional(any)
    requestSignatureVerification = optional(any)
    requiredResourceAccess = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.requiredResourceAccess")
      resourceAccess = optional(any)
      resourceAppId  = optional(string)
    })))
    samlMetadataUrl                   = optional(string)
    serviceManagementReference        = optional(string)
    servicePrincipalLockConfiguration = optional(any)
    signInAudience                    = optional(string)
    signInAudienceRestrictions = optional(object({
      odata_type = optional(string, "#microsoft.graph.signInAudienceRestrictionsBase")
      kind       = optional(string)
    }))
    spa                  = optional(any)
    synchronization      = optional(any)
    tags                 = optional(list(string))
    tokenEncryptionKeyId = optional(string)
    tokenIssuancePolicies = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.tokenIssuancePolicy")
      appliesTo             = optional(any)
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    tokenLifetimePolicies = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.tokenLifetimePolicy")
      appliesTo             = optional(any)
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    verifiedPublisher = optional(any)
    web               = optional(any)
    windows           = optional(any)
  }))
  default   = null
  sensitive = true
}

variable "connector_group_type" {
  description = "Microsoft Graph connectorGroupType property."
  type        = string
  default     = null

  validation {
    condition     = var.connector_group_type == null ? true : contains(["applicationProxy"], var.connector_group_type)
    error_message = "connector_group_type must be one of the documented enum values."
  }
}

variable "members" {
  description = "Microsoft Graph members property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.connector")
    machineName = optional(string)
    status      = optional(string)
  }))
  default = null
}

variable "name" {
  description = "The name associated with the connectorGroup."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.connectorGroup"
  nullable    = false
}

variable "region" {
  description = "The region the connectorGroup is assigned to and will optimize traffic for. This region can only be set if no connectors or applications are assigned to the connectorGroup. The possible values are: nam (for North America), eur (for Europe), aus (for Australia), asia (for Asia), ind (for India), and unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.region == null ? true : contains(["nam", "eur", "aus", "asia", "ind", "unknownFutureValue"], var.region)
    error_message = "region must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isDefault"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
