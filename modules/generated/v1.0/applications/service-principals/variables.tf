variable "app_id" {
  description = "The unique identifier for the associated application (its appId property). Alternate key. Supports $filter (eq, ne, not, in, startsWith)."
  type        = string
  nullable    = false
}

variable "account_enabled" {
  description = "true if the service principal account is enabled; otherwise, false. If set to false, then no users are able to sign in to this app, even if they're assigned to it. Supports $filter (eq, ne, not, in)."
  type        = bool
  default     = null
}

variable "add_ins" {
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

variable "alternative_names" {
  description = "Used to retrieve service principals by subscription, identify resource group and full resource IDs for managed identities. Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "app_description" {
  description = "The description exposed by the associated application."
  type        = string
  default     = null
}

variable "app_display_name" {
  description = "The display name exposed by the associated application. Maximum length is 256 characters."
  type        = string
  default     = null
}

variable "app_management_policies" {
  description = "The appManagementPolicy applied to this application."
  type = list(object({
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
  }))
  default = null
}

variable "app_owner_organization_id" {
  description = "Contains the tenant ID where the application is registered. This is applicable only to service principals backed by applications. Supports $filter (eq, ne, NOT, ge, le)."
  type        = string
  default     = null
}

variable "app_role_assigned_to" {
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

variable "app_role_assignment_required" {
  description = "Specifies whether users or other service principals need to be granted an app role assignment for this service principal before users can sign in or apps can get tokens. The default value is false. Not nullable. Supports $filter (eq, ne, NOT)."
  type        = bool
  default     = null
}

variable "app_role_assignments" {
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

variable "app_roles" {
  description = "The roles exposed by the application that's linked to this service principal. For more information, see the appRoles property definition on the application entity. Not nullable."
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

variable "claims_mapping_policies" {
  description = "The claimsMappingPolicies assigned to this service principal. Supports $expand."
  type = list(object({
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
  }))
  default = null
}

variable "custom_security_attributes" {
  description = "An open complex type that holds the value of a custom security attribute that is assigned to a directory object. Nullable. Requires $select to retrieve. Supports $filter (eq, ne, not, startsWith). Filter value is case sensitive. To read this property, the calling app must be assigned the CustomSecAttributeAssignment.Read.All permission. To write this property, the calling app must be assigned the CustomSecAttributeAssignment.ReadWrite.All permissions. To read or write this property in delegated scenarios, the admin must be assigned the Attribute Assignment Administrator role."
  type        = any
  default     = null
}

variable "delegated_permission_classifications" {
  description = "Microsoft Graph delegatedPermissionClassifications property."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.delegatedPermissionClassification")
    classification = optional(any)
    permissionId   = optional(string)
    permissionName = optional(string)
  }))
  default = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Free text field to provide an internal end-user facing description of the service principal. End-user portals such MyApps displays the application description in this field. The maximum allowed size is 1,024 characters. Supports $filter (eq, ne, not, ge, le, startsWith) and $search."
  type        = string
  default     = null
}

variable "disabled_by_microsoft_status" {
  description = "Specifies whether Microsoft has disabled the registered application. The possible values are: null (default value), NotDisabled, and DisabledDueToViolationOfServicesAgreement (reasons include suspicious, abusive, or malicious activity, or a violation of the Microsoft Services Agreement).  Supports $filter (eq, ne, not)."
  type        = string
  default     = null
}

variable "display_name" {
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

variable "federated_identity_credentials" {
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

variable "home_realm_discovery_policies" {
  description = "The homeRealmDiscoveryPolicies assigned to this service principal. Supports $expand."
  type = list(object({
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
  type        = any
  default     = null
}

variable "is_disabled" {
  description = "Microsoft Graph isDisabled property."
  type        = bool
  default     = null
}

variable "key_credentials" {
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

variable "login_url" {
  description = "Specifies the URL where the service provider redirects the user to Microsoft Entra ID to authenticate. Microsoft Entra ID uses the URL to launch the application from Microsoft 365 or the Microsoft Entra My Apps. When blank, Microsoft Entra ID performs IdP-initiated sign-on for applications configured with SAML-based single sign-on. The user launches the application from Microsoft 365, the Microsoft Entra My Apps, or the Microsoft Entra SSO URL."
  type        = string
  default     = null
}

variable "logout_url" {
  description = "Specifies the URL that the Microsoft's authorization service uses to sign out a user using OpenID Connect front-channel, back-channel, or SAML sign out protocols."
  type        = string
  default     = null
}

variable "notes" {
  description = "Free text field to capture information about the service principal, typically used for operational purposes. Maximum allowed size is 1,024 characters."
  type        = string
  default     = null
}

variable "notification_email_addresses" {
  description = "Specifies the list of email addresses where Microsoft Entra ID sends a notification when the active certificate is near the expiration date. This is only for the certificates used to sign the SAML token issued for Microsoft Entra Gallery applications."
  type        = list(string)
  default     = null
}

variable "oauth2_permission_scopes" {
  description = "The delegated permissions exposed by the application. For more information, see the oauth2PermissionScopes property on the application entity's api property. Not nullable."
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
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "password_credentials" {
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

variable "preferred_single_sign_on_mode" {
  description = "Specifies the single sign-on mode configured for this application. Microsoft Entra ID uses the preferred single sign-on mode to launch the application from Microsoft 365 or the My Apps portal. The supported values are password, saml, notSupported, and oidc. Note: This field might be null for older SAML apps and for OIDC applications where it isn't set automatically."
  type        = string
  default     = null
}

variable "preferred_token_signing_key_thumbprint" {
  description = "This property can be used on SAML applications (apps that have preferredSingleSignOnMode set to saml) to control which certificate is used to sign the SAML responses. For applications that aren't SAML, don't write or otherwise rely on this property."
  type        = string
  default     = null
}

variable "remote_desktop_security_configuration" {
  description = "The remoteDesktopSecurityConfiguration object applied to this service principal. Supports $filter (eq) for isRemoteDesktopProtocolEnabled property."
  type        = any
  default     = null
}

variable "reply_urls" {
  description = "The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application. Not nullable."
  type        = list(string)
  default     = null
}

variable "saml_single_sign_on_settings" {
  description = "The collection for settings related to saml single sign-on."
  type        = any
  default     = null
}

variable "service_principal_names" {
  description = "Contains the list of identifiersUris, copied over from the associated application. Additional values can be added to hybrid applications. These values can be used to identify the permissions exposed by this app within Microsoft Entra ID. For example,Client apps can specify a resource URI that is based on the values of this property to acquire an access token, which is the URI returned in the 'aud' claim.The any operator is required for filter expressions on multi-valued properties. Not nullable.  Supports $filter (eq, not, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "service_principal_type" {
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

variable "token_encryption_key_id" {
  description = "Specifies the keyId of a public key from the keyCredentials collection. When configured, Microsoft Entra ID issues tokens for this application encrypted using the key specified by this property. The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user."
  type        = string
  default     = null
}

variable "token_issuance_policies" {
  description = "The tokenIssuancePolicies assigned to this service principal."
  type = list(object({
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
  }))
  default = null
}

variable "token_lifetime_policies" {
  description = "The tokenLifetimePolicies assigned to this service principal."
  type = list(object({
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
  }))
  default = null
}

variable "transitive_member_of" {
  description = "Microsoft Graph transitiveMemberOf property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "verified_publisher" {
  description = "Specifies the verified publisher of the application that's linked to this service principal."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["applicationTemplateId", "createdByAppId", "createdObjects", "id", "memberOf", "oauth2PermissionGrants", "ownedObjects", "resourceSpecificApplicationPermissions", "signInAudience"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
