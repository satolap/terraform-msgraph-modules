variable "connectivity_configuration" {
  description = "Specifies the connectivity details of all device links associated with a remote network."
  type        = any
  default     = null
}

variable "device_links" {
  description = "Each unique CPE device associated with a remote network is specified. Supports $expand."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.networkaccess.deviceLink")
    bandwidthCapacityInMbps = optional(any)
    bgpConfiguration = optional(object({
      odata_type     = optional(string, "#microsoft.graph.networkaccess.bgpConfiguration")
      asn            = optional(number)
      ipAddress      = optional(string)
      localIpAddress = optional(string)
      peerIpAddress  = optional(string)
    }))
    deviceVendor            = optional(string)
    ipAddress               = optional(string)
    lastModifiedDateTime    = optional(string)
    name                    = optional(string)
    redundancyConfiguration = optional(any)
    tunnelConfiguration = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.networkaccess.tunnelConfiguration")
      preSharedKey               = optional(string)
      zoneRedundancyPreSharedKey = optional(string)
    }))
  }))
  default = null
}

variable "forwarding_profiles" {
  description = "Each forwarding profile associated with a remote network is specified. Supports $expand and $select."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.forwardingProfile")
    associations = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.networkaccess.association")
    })))
    description          = optional(string)
    isCustomProfile      = optional(bool)
    lastModifiedDateTime = optional(string)
    name                 = optional(string)
    policies = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.networkaccess.policyLink")
      policy = optional(object({
        odata_type  = optional(string, "#microsoft.graph.networkaccess.policy")
        description = optional(string)
        name        = optional(string)
        policyRules = optional(any)
        version     = optional(string)
      }))
      state   = optional(string)
      version = optional(string)
    })))
    priority = optional(number)
    servicePrincipal = optional(object({
      odata_type     = optional(string, "#microsoft.graph.servicePrincipal")
      accountEnabled = optional(bool)
      addIns = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.addIn")
        id         = optional(string)
        properties = optional(any)
        type       = optional(string)
      })))
      alternativeNames = optional(list(string))
      appDescription   = optional(string)
      appDisplayName   = optional(string)
      appId            = optional(string)
      appManagementPolicies = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.appManagementPolicy")
        appliesTo       = optional(any)
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
        allowedMemberTypes = optional(any)
        description        = optional(string)
        displayName        = optional(string)
        id                 = optional(string)
        isEnabled          = optional(bool)
        value              = optional(string)
      })))
      claimsMappingPolicies = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.claimsMappingPolicy")
        appliesTo             = optional(any)
        definition            = optional(any)
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
        audiences                = optional(any)
        claimsMatchingExpression = optional(any)
        description              = optional(string)
        issuer                   = optional(string)
        name                     = optional(string)
        subject                  = optional(string)
      })))
      homeRealmDiscoveryPolicies = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")
        appliesTo             = optional(any)
        definition            = optional(any)
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
        odata_type      = optional(string, "#microsoft.graph.permissionGrantPreApprovalPolicy")
        conditions      = optional(any)
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
        odata_type            = optional(string, "#microsoft.graph.tokenIssuancePolicy")
        appliesTo             = optional(any)
        definition            = optional(any)
        deletedDateTime       = optional(string)
        description           = optional(string)
        displayName           = optional(string)
        isOrganizationDefault = optional(bool)
      })))
      tokenLifetimePolicies = optional(list(object({
        odata_type            = optional(string, "#microsoft.graph.tokenLifetimePolicy")
        appliesTo             = optional(any)
        definition            = optional(any)
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
    }))
    state                 = optional(string)
    trafficForwardingType = optional(string)
    version               = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "graph_version" {
  description = "Remote network version."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "last modified time."
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
  default     = "#microsoft.graph.networkaccess.remoteNetwork"
  nullable    = false
}

variable "region" {
  description = "Microsoft Graph region property."
  type        = string
  default     = null

  validation {
    condition     = var.region == null ? true : contains(["eastUS", "eastUS2", "westUS", "westUS2", "westUS3", "centralUS", "northCentralUS", "southCentralUS", "northEurope", "westEurope", "franceCentral", "germanyWestCentral", "switzerlandNorth", "ukSouth", "canadaEast", "canadaCentral", "southAfricaWest", "southAfricaNorth", "uaeNorth", "australiaEast", "westCentralUS", "centralIndia", "southEastAsia", "swedenCentral", "southIndia", "australiaSouthEast", "koreaCentral", "polandCentral", "brazilSouth", "japanEast", "japanWest", "koreaSouth", "italyNorth", "franceSouth", "israelCentral", "unknownFutureValue", "taiwanNorth", "mexicoCentral", "spainCentral", "jioIndiaCentral", "brazilSouthEast"], var.region)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
