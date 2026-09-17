variable "remote_network_id" {
  description = "The unique identifier of remoteNetwork"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.remote_network_id)) > 0
    error_message = "remote_network_id must not be empty."
  }
}

variable "associations" {
  description = "Microsoft Graph associations property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.association")
  }))
  default = null
}

variable "description" {
  description = "Description."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Profile version."
  type        = string
  default     = null
}

variable "is_custom_profile" {
  description = "Microsoft Graph isCustomProfile property."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the profile was last modified."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the entity"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.forwardingProfile"
  nullable    = false
}

variable "policies" {
  description = "The traffic forwarding policies associated with this profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.policyLink")
    policy = optional(object({
      odata_type  = optional(string, "#microsoft.graph.networkaccess.policy")
      description = optional(string)
      name        = optional(string)
      policyRules = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.networkaccess.policyRule")
        name       = optional(string)
      })))
      version = optional(string)
    }))
    state   = optional(string)
    version = optional(string)
  }))
  default = null
}

variable "priority" {
  description = "Microsoft Graph priority property."
  type        = number
  default     = null
}

variable "service_principal" {
  description = "Microsoft Graph servicePrincipal property."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.servicePrincipal")
    accountEnabled = optional(bool)
    addIns = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.addIn")
      id         = optional(string)
      properties = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.keyValue")
        key        = optional(string)
        value      = optional(string)
      })))
      type = optional(string)
    })))
    alternativeNames = optional(list(string))
    appDescription   = optional(string)
    appDisplayName   = optional(string)
    appId            = optional(string)
    appManagementPolicies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.appManagementPolicy")
      appliesTo = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.directoryObject")
        deletedDateTime = optional(string)
      })))
      deletedDateTime = optional(string)
      description     = optional(string)
      displayName     = optional(string)
      isEnabled       = optional(bool)
      restrictions    = optional(any)
    })))
    appOwnerOrganizationId = optional(string)
    appRoleAssignedTo = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    appRoleAssignmentRequired = optional(bool)
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
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
    claimsMappingPolicies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.claimsMappingPolicy")
      appliesTo = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.directoryObject")
        deletedDateTime = optional(string)
      })))
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    claimsPolicy             = optional(any)
    customSecurityAttributes = optional(any)
    delegatedPermissionClassifications = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.delegatedPermissionClassification")
      classification = optional(any)
      permissionId   = optional(string)
      permissionName = optional(string)
    })))
    deletedDateTime           = optional(string)
    description               = optional(string)
    disabledByMicrosoftStatus = optional(string)
    displayName               = optional(string)
    endpoints = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.endpoint")
      deletedDateTime = optional(string)
    })))
    errorUrl = optional(string)
    federatedIdentityCredentials = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.federatedIdentityCredential")
      audiences                = optional(list(string))
      claimsMatchingExpression = optional(any)
      description              = optional(string)
      issuer                   = optional(string)
      name                     = optional(string)
      subject                  = optional(string)
    })))
    homeRealmDiscoveryPolicies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")
      appliesTo = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.directoryObject")
        deletedDateTime = optional(string)
      })))
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    homepage   = optional(string)
    info       = optional(any)
    isDisabled = optional(bool)
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
    licenseDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.licenseDetails")
    })))
    loginUrl                   = optional(string)
    logoutUrl                  = optional(string)
    notes                      = optional(string)
    notificationEmailAddresses = optional(list(string))
    owners = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    passwordCredentials = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.passwordCredential")
      customKeyIdentifier = optional(string)
      displayName         = optional(string)
      endDateTime         = optional(string)
      keyId               = optional(string)
      startDateTime       = optional(string)
    })))
    permissionGrantPreApprovalPolicies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.permissionGrantPreApprovalPolicy")
      conditions = optional(list(object({
        odata_type        = optional(string, "#microsoft.graph.preApprovalDetail")
        permissions       = optional(any)
        scopeType         = optional(string)
        sensitivityLabels = optional(any)
      })))
      deletedDateTime = optional(string)
    })))
    preferredSingleSignOnMode           = optional(string)
    preferredTokenSigningKeyEndDateTime = optional(string)
    preferredTokenSigningKeyThumbprint  = optional(string)
    publishedPermissionScopes = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.permissionScope")
      adminConsentDescription = optional(string)
      adminConsentDisplayName = optional(string)
      id                      = optional(string)
      isEnabled               = optional(bool)
      origin                  = optional(string)
      type                    = optional(string)
      userConsentDescription  = optional(string)
      userConsentDisplayName  = optional(string)
      value                   = optional(string)
    })))
    publisherName                      = optional(string)
    remoteDesktopSecurityConfiguration = optional(any)
    replyUrls                          = optional(list(string))
    samlMetadataUrl                    = optional(string)
    samlSingleSignOnSettings           = optional(any)
    servicePrincipalNames              = optional(list(string))
    servicePrincipalType               = optional(string)
    synchronization                    = optional(any)
    tags                               = optional(list(string))
    tokenEncryptionKeyId               = optional(string)
    tokenIssuancePolicies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")
      appliesTo = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.directoryObject")
        deletedDateTime = optional(string)
      })))
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    tokenLifetimePolicies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")
      appliesTo = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.directoryObject")
        deletedDateTime = optional(string)
      })))
      definition            = optional(list(string))
      deletedDateTime       = optional(string)
      description           = optional(string)
      displayName           = optional(string)
      isOrganizationDefault = optional(bool)
    })))
    transitiveMemberOf = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    verifiedPublisher = optional(any)
  })
  default   = null
  sensitive = true
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "traffic_forwarding_type" {
  description = "Microsoft Graph trafficForwardingType property."
  type        = string
  default     = null

  validation {
    condition     = var.traffic_forwarding_type == null ? true : contains(["m365", "internet", "private", "unknownFutureValue"], var.traffic_forwarding_type)
    error_message = "traffic_forwarding_type must be one of the documented enum values."
  }
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
