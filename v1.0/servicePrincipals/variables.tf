variable "appId" {
  description = "The unique identifier for the associated application (its appId property). Alternate key. Supports $filter (eq, ne, not, in, startsWith)."
  type        = string
  nullable    = false
}

variable "accountEnabled" {
  description = "true if the service principal account is enabled; otherwise, false. If set to false, then no users are able to sign in to this app, even if they're assigned to it. Supports $filter (eq, ne, not, in)."
  type        = bool
  default     = null
}

variable "addIns" {
  description = "Defines custom behavior that a consuming service can use to call an app in specific contexts. For example, applications that can render file streams may set the addIns property for its 'FileHandler' functionality. This lets services like Microsoft 365 call the application in the context of a document the user is working on."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.addIn")
    id         = optional(string)
    properties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValue")
      key        = optional(string)
      value      = optional(string)
    })))
    type = optional(string)
  }))
  default = null
}

variable "alternativeNames" {
  description = "Used to retrieve service principals by subscription, identify resource group and full resource IDs for managed identities. Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "appDescription" {
  description = "The description exposed by the associated application."
  type        = string
  default     = null
}

variable "appDisplayName" {
  description = "The display name exposed by the associated application. Maximum length is 256 characters."
  type        = string
  default     = null
}

variable "appManagementPolicies" {
  description = "The appManagementPolicy applied to this application."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.appManagementPolicy")
    appliesTo       = optional(any)
    deletedDateTime = optional(string)
    description     = optional(string)
    displayName     = optional(string)
    isEnabled       = optional(bool)
    restrictions = optional(object({
      odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")
      applicationRestrictions = optional(object({
        odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")
        identifierUris = optional(object({
          odata_type                               = optional(string, "#microsoft.graph.identifierUriConfiguration")
          nonDefaultUriAddition                    = optional(any)
          uriAdditionWithoutUniqueTenantIdentifier = optional(any)
        }))
      }))
      keyCredentials = optional(list(object({
        odata_type                          = optional(string, "#microsoft.graph.keyCredentialConfiguration")
        excludeActors                       = optional(any)
        maxLifetime                         = optional(string)
        restrictForAppsCreatedAfterDateTime = optional(string)
        restrictionType                     = optional(string)
        state                               = optional(string)
      })))
      passwordCredentials = optional(list(object({
        odata_type                          = optional(string, "#microsoft.graph.passwordCredentialConfiguration")
        excludeActors                       = optional(any)
        maxLifetime                         = optional(string)
        restrictForAppsCreatedAfterDateTime = optional(string)
        restrictionType                     = optional(string)
        state                               = optional(string)
      })))
    }))
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.appManagementPolicies == null ? true : alltrue([alltrue([for input0 in var.appManagementPolicies : (input0 == null ? true : alltrue([(input0["restrictions"] == null ? true : alltrue([(input0["restrictions"]["keyCredentials"] == null ? true : alltrue([alltrue([for input3 in input0["restrictions"]["keyCredentials"] : (input3 == null ? true : alltrue([(input3["restrictionType"] == null ? true : alltrue([(input3["restrictionType"] == null ? true : contains(["asymmetricKeyLifetime"], input3["restrictionType"]))])), (input3["state"] == null ? true : alltrue([(input3["state"] == null ? true : contains(["enabled", "disabled"], input3["state"]))]))]))])])), (input0["restrictions"]["passwordCredentials"] == null ? true : alltrue([alltrue([for input3 in input0["restrictions"]["passwordCredentials"] : (input3 == null ? true : alltrue([(input3["restrictionType"] == null ? true : alltrue([(input3["restrictionType"] == null ? true : contains(["passwordAddition", "passwordLifetime", "symmetricKeyAddition", "symmetricKeyLifetime", "customPasswordAddition"], input3["restrictionType"]))])), (input3["state"] == null ? true : alltrue([(input3["state"] == null ? true : contains(["enabled", "disabled"], input3["state"]))]))]))])]))]))]))])]))
    error_message = "appManagementPolicies: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "appOwnerOrganizationId" {
  description = "Contains the tenant ID where the application is registered. This is applicable only to service principals backed by applications. Supports $filter (eq, ne, NOT, ge, le)."
  type        = string
  default     = null
}

variable "appRoleAssignedTo" {
  description = "App role assignments for this app or service, granted to users, groups, and other service principals. Supports $expand."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
    appRoleId           = optional(string)
    deletedDateTime     = optional(string)
    principalId         = optional(string)
    resourceDisplayName = optional(string)
    resourceId          = optional(string)
  }))
  default = null
}

variable "appRoleAssignmentRequired" {
  description = "Specifies whether users or other service principals need to be granted an app role assignment for this service principal before users can sign in or apps can get tokens. The default value is false. Not nullable. Supports $filter (eq, ne, NOT)."
  type        = bool
  default     = null
}

variable "appRoleAssignments" {
  description = "App role assignment for another app or service, granted to this service principal. Supports $expand."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
    appRoleId           = optional(string)
    deletedDateTime     = optional(string)
    principalId         = optional(string)
    resourceDisplayName = optional(string)
    resourceId          = optional(string)
  }))
  default = null
}

variable "appRoles" {
  description = "The roles exposed by the application that's linked to this service principal. For more information, see the appRoles property definition on the application entity. Not nullable. App roles and exposed delegated permission scopes (oauth2PermissionScopes) share a default limit of 700 permission definitions per service principal, including definitions inherited from the application and definitions added directly to the service principal. Enabled and disabled definitions both count. This limit counts definitions, not app role assignments. For counting rules, behavior for existing objects above the limit, and design guidance, see App role limits."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.appRole")
    allowedMemberTypes = optional(list(string))
    description        = optional(string)
    displayName        = optional(string)
    id                 = optional(string)
    isEnabled          = optional(bool)
    value              = optional(string)
  }))
  default = null
}

variable "claimsMappingPolicies" {
  description = "The claimsMappingPolicies assigned to this service principal. Supports $expand."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.claimsMappingPolicy")
    appliesTo             = optional(any)
    definition            = optional(list(string))
    deletedDateTime       = optional(string)
    description           = optional(string)
    displayName           = optional(string)
    isOrganizationDefault = optional(bool)
  }))
  default = null
}

variable "customSecurityAttributes" {
  description = "An open complex type that holds the value of a custom security attribute that is assigned to a directory object. Nullable. Requires $select to retrieve. Supports $filter (eq, ne, not, startsWith). Filter value is case sensitive. To read this property, the calling app must be assigned the CustomSecAttributeAssignment.Read.All permission. To write this property, the calling app must be assigned the CustomSecAttributeAssignment.ReadWrite.All permissions. To read or write this property in delegated scenarios, the admin must be assigned the Attribute Assignment Administrator role."
  type        = any
  default     = null
}

variable "delegatedPermissionClassifications" {
  description = "Microsoft Graph delegatedPermissionClassifications property."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.delegatedPermissionClassification")
    classification = optional(string)
    permissionId   = optional(string)
    permissionName = optional(string)
  }))
  default = null

  validation {
    condition     = (var.delegatedPermissionClassifications == null ? true : alltrue([alltrue([for input0 in var.delegatedPermissionClassifications : (input0 == null ? true : alltrue([(input0["classification"] == null ? true : alltrue([(input0["classification"] == null ? true : contains(["low", "medium", "high"], input0["classification"]))]))]))])]))
    error_message = "delegatedPermissionClassifications: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "deletedDateTime" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Free text field to provide an internal end-user facing description of the service principal. End-user portals such MyApps displays the application description in this field. The maximum allowed size is 1,024 characters. Supports $filter (eq, ne, not, ge, le, startsWith) and $search."
  type        = string
  default     = null
}

variable "disabledByMicrosoftStatus" {
  description = "Specifies whether Microsoft has disabled the registered application. The possible values are: null (default value), NotDisabled, and DisabledDueToViolationOfServicesAgreement (reasons include suspicious, abusive, or malicious activity, or a violation of the Microsoft Services Agreement).  Supports $filter (eq, ne, not)."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name for the service principal. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  default     = null
}

variable "endpoints" {
  description = "Microsoft Graph endpoints property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.endpoint")
    capability         = optional(string)
    deletedDateTime    = optional(string)
    providerId         = optional(string)
    providerName       = optional(string)
    providerResourceId = optional(string)
    uri                = optional(string)
  }))
  default = null
}

variable "federatedIdentityCredentials" {
  description = "Federated identities for a specific type of service principal - managed identity. Supports $expand and $filter (/$count eq 0, /$count ne 0)."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.federatedIdentityCredential")
    audiences   = optional(list(string))
    description = optional(string)
    issuer      = optional(string)
    name        = optional(string)
    subject     = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "homeRealmDiscoveryPolicies" {
  description = "The homeRealmDiscoveryPolicies assigned to this service principal. Supports $expand."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")
    appliesTo             = optional(any)
    definition            = optional(list(string))
    deletedDateTime       = optional(string)
    description           = optional(string)
    displayName           = optional(string)
    isOrganizationDefault = optional(bool)
  }))
  default = null
}

variable "homepage" {
  description = "Home page or landing page of the application."
  type        = string
  default     = null
}

variable "info" {
  description = "Basic profile information of the acquired application such as app's marketing, support, terms of service and privacy statement URLs. The terms of service and privacy statement are surfaced to users through the user consent experience. For more info, see How to: Add Terms of service and privacy statement for registered Microsoft Entra apps. Supports $filter (eq, ne, not, ge, le, and eq on null values)."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.informationalUrl")
    marketingUrl        = optional(string)
    privacyStatementUrl = optional(string)
    supportUrl          = optional(string)
    termsOfServiceUrl   = optional(string)
  })
  default = null
}

variable "isDisabled" {
  description = "Microsoft Graph isDisabled property."
  type        = bool
  default     = null
}

variable "keyCredentials" {
  description = "The collection of key credentials associated with the service principal. Not nullable. Supports $filter (eq, not, ge, le)."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.keyCredential")
    customKeyIdentifier = optional(string)
    displayName         = optional(string)
    endDateTime         = optional(string)
    key                 = optional(string)
    keyId               = optional(string)
    startDateTime       = optional(string)
    type                = optional(string)
    usage               = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "loginUrl" {
  description = "Specifies the URL where the service provider redirects the user to Microsoft Entra ID to authenticate. Microsoft Entra ID uses the URL to launch the application from Microsoft 365 or the Microsoft Entra My Apps. When blank, Microsoft Entra ID performs IdP-initiated sign-on for applications configured with SAML-based single sign-on. The user launches the application from Microsoft 365, the Microsoft Entra My Apps, or the Microsoft Entra SSO URL."
  type        = string
  default     = null
}

variable "logoutUrl" {
  description = "Specifies the URL that the Microsoft's authorization service uses to sign out a user using OpenID Connect front-channel, back-channel, or SAML sign out protocols."
  type        = string
  default     = null
}

variable "notes" {
  description = "Free text field to capture information about the service principal, typically used for operational purposes. Maximum allowed size is 1,024 characters."
  type        = string
  default     = null
}

variable "notificationEmailAddresses" {
  description = "Specifies the list of email addresses where Microsoft Entra ID sends a notification when the active certificate is near the expiration date. This is only for the certificates used to sign the SAML token issued for Microsoft Entra Gallery applications."
  type        = list(string)
  default     = null
}

variable "oauth2PermissionScopes" {
  description = "The delegated permissions exposed by the application. For more information, see the oauth2PermissionScopes property on the application entity's api property. Not nullable. These scopes and appRoles share a default limit of 700 permission definitions per service principal. Enabled and disabled definitions both count. For counting rules, behavior for existing objects above the limit, and design guidance, see App role limits."
  type = list(object({
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
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.servicePrincipal"
  nullable    = false
}

variable "owners" {
  description = "Directory objects that are owners of this servicePrincipal. The owners are a set of nonadmin users or servicePrincipals who are allowed to modify this object. Supports $expand, $filter (/$count eq 0, /$count ne 0, /$count eq 1, /$count ne 1), and $select nested in $expand."
  type        = any
  default     = null
}

variable "passwordCredentials" {
  description = "The collection of password credentials associated with the application. Not nullable."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.passwordCredential")
    customKeyIdentifier = optional(string)
    displayName         = optional(string)
    endDateTime         = optional(string)
    keyId               = optional(string)
    startDateTime       = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "preferredSingleSignOnMode" {
  description = "Specifies the single sign-on mode configured for this application. Microsoft Entra ID uses the preferred single sign-on mode to launch the application from Microsoft 365 or the My Apps portal. The supported values are password, saml, notSupported, and oidc. Note: This field might be null for older SAML apps and for OIDC applications where it isn't set automatically."
  type        = string
  default     = null
}

variable "preferredTokenSigningKeyThumbprint" {
  description = "This property can be used on SAML applications (apps that have preferredSingleSignOnMode set to saml) to control which certificate is used to sign the SAML responses. For applications that aren't SAML, don't write or otherwise rely on this property."
  type        = string
  default     = null
}

variable "remoteDesktopSecurityConfiguration" {
  description = "The remoteDesktopSecurityConfiguration object applied to this service principal. Supports $filter (eq) for isRemoteDesktopProtocolEnabled property."
  type        = any
  default     = null
}

variable "replyUrls" {
  description = "The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application. Not nullable."
  type        = list(string)
  default     = null
}

variable "samlSingleSignOnSettings" {
  description = "The collection for settings related to saml single sign-on."
  type = object({
    odata_type = optional(string, "#microsoft.graph.samlSingleSignOnSettings")
    relayState = optional(string)
  })
  default = null
}

variable "servicePrincipalNames" {
  description = "Contains the list of identifiersUris, copied over from the associated application. Additional values can be added to hybrid applications. These values can be used to identify the permissions exposed by this app within Microsoft Entra ID. For example,Client apps can specify a resource URI that is based on the values of this property to acquire an access token, which is the URI returned in the 'aud' claim.The any operator is required for filter expressions on multi-valued properties. Not nullable.  Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "servicePrincipalType" {
  description = "Identifies whether the service principal represents an application, a managed identity, or a legacy application. This property is set by Microsoft Entra ID internally. The servicePrincipalType property can be set to three different values: Application - A service principal that represents an application or service. The appId property identifies the associated app registration, and matches the appId of an application, possibly from a different tenant. If the associated app registration is missing, tokens aren't issued for the service principal.ManagedIdentity - A service principal that represents a managed identity. Service principals representing managed identities can be granted access and permissions, but can't be updated or modified directly.Legacy - A service principal that represents an app created before app registrations, or through legacy experiences. A legacy service principal can have credentials, service principal names, reply URLs, and other properties that are editable by an authorized user, but doesn't have an associated app registration. The appId value doesn't associate the service principal with an app registration. The service principal can only be used in the tenant where it was created.ServiceIdentity - A service principal that represents an agent identity.SocialIdp - For internal use."
  type        = string
  default     = null
}

variable "synchronization" {
  description = "Represents the capability for Microsoft Entra identity synchronization through the Microsoft Graph API."
  type        = any
  default     = null
}

variable "tags" {
  description = "Custom strings that can be used to categorize and identify the service principal. Not nullable. The value is the union of strings set here and on the associated application entity's tags property.Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "tokenEncryptionKeyId" {
  description = "Specifies the keyId of a public key from the keyCredentials collection. When configured, Microsoft Entra ID issues tokens for this application encrypted using the key specified by this property. The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user."
  type        = string
  default     = null
}

variable "tokenIssuancePolicies" {
  description = "The tokenIssuancePolicies assigned to this service principal."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.tokenIssuancePolicy")
    appliesTo             = optional(any)
    definition            = optional(list(string))
    deletedDateTime       = optional(string)
    description           = optional(string)
    displayName           = optional(string)
    isOrganizationDefault = optional(bool)
  }))
  default = null
}

variable "tokenLifetimePolicies" {
  description = "The tokenLifetimePolicies assigned to this service principal."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.tokenLifetimePolicy")
    appliesTo             = optional(any)
    definition            = optional(list(string))
    deletedDateTime       = optional(string)
    description           = optional(string)
    displayName           = optional(string)
    isOrganizationDefault = optional(bool)
  }))
  default = null
}

variable "transitiveMemberOf" {
  description = "Microsoft Graph transitiveMemberOf property."
  type        = any
  default     = null
}

variable "verifiedPublisher" {
  description = "Specifies the verified publisher of the application that's linked to this service principal."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.verifiedPublisher")
    addedDateTime       = optional(string)
    displayName         = optional(string)
    verifiedPublisherId = optional(string)
  })
  default = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["applicationTemplateId", "createdByAppId", "createdObjects", "id", "memberOf", "oauth2PermissionGrants", "ownedObjects", "resourceSpecificApplicationPermissions", "signInAudience"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
