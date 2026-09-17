variable "display_name" {
  description = "The display name for the application. Maximum length is 256 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  nullable    = false
}

variable "add_ins" {
  description = "Defines custom behavior that a consuming service can use to call an app in specific contexts. For example, applications that can render file streams can set the addIns property for its 'FileHandler' functionality. This lets services like Microsoft 365 call the application in the context of a document the user is working on."
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

variable "api" {
  description = "Specifies settings for an application that implements a web API."
  type        = any
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

variable "app_roles" {
  description = "The collection of roles defined for the application. With app role assignments, these roles can be assigned to users, groups, or service principals associated with other applications. Not nullable."
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

variable "authentication_behaviors" {
  description = "The set of breaking change behaviors related to token issuance that are configured for the application. Authentication behaviors are unset by default (null) and must be explicitly enabled or disabled. Nullable. Returned only on $select. Requires $select to retrieve.  For more information about authentication behaviors, see Manage application authenticationBehaviors."
  type        = any
  default     = null
}

variable "certification" {
  description = "Specifies the certification status of the application."
  type        = any
  default     = null
}

variable "default_redirect_uri" {
  description = "Microsoft Graph defaultRedirectUri property."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Free text field to provide a description of the application object to end users. The maximum allowed size is 1,024 characters. Supports $filter (eq, ne, not, ge, le, startsWith) and $search."
  type        = string
  default     = null
}

variable "disabled_by_microsoft_status" {
  description = "Specifies whether Microsoft has disabled the registered application. The possible values are: null (default value), NotDisabled, and DisabledDueToViolationOfServicesAgreement (reasons include suspicious, abusive, or malicious activity, or a violation of the Microsoft Services Agreement).  Supports $filter (eq, ne, not)."
  type        = string
  default     = null
}

variable "federated_identity_credentials" {
  description = "Federated identities for applications. Supports $expand and $filter (startsWith, /$count eq 0, /$count ne 0)."
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

variable "group_membership_claims" {
  description = "Configures the groups claim issued in a user or OAuth 2.0 access token that the application expects. To set this attribute, use one of the following valid string values: None, SecurityGroup (for security groups and Microsoft Entra roles), All (this gets all of the security groups, distribution groups, and Microsoft Entra directory roles that the signed-in user is a member of)."
  type        = string
  default     = null
}

variable "home_realm_discovery_policies" {
  description = "Microsoft Graph homeRealmDiscoveryPolicies property."
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

variable "identifier_uris" {
  description = "Also known as App ID URI, this value is set when an application is used as a resource app. The identifierUris acts as the prefix for the scopes you reference in your API's code, and it must be globally unique across Microsoft Entra ID. For more information on valid identifierUris patterns and best practices, see Microsoft Entra application registration security best practices. Not nullable. Supports $filter (eq, ne, ge, le, startsWith)."
  type        = list(string)
  default     = null
}

variable "info" {
  description = "Basic profile information of the application such as  app's marketing, support, terms of service and privacy statement URLs. The terms of service and privacy statement are surfaced to users through the user consent experience. For more info, see How to: Add Terms of service and privacy statement for registered Microsoft Entra apps. Supports $filter (eq, ne, not, ge, le, and eq on null values)."
  type        = any
  default     = null
}

variable "is_device_only_auth_supported" {
  description = "Specifies whether this application supports device authentication without a user. The default is false."
  type        = bool
  default     = null
}

variable "is_disabled" {
  description = "Microsoft Graph isDisabled property."
  type        = bool
  default     = null
}

variable "is_fallback_public_client" {
  description = "Specifies the fallback application type as public client, such as an installed application running on a mobile device. The default value is false, which means the fallback application type is confidential client such as a web app. There are certain scenarios where Microsoft Entra ID can't determine the client application type. For example, the ROPC flow where it's configured without specifying a redirect URI. In those cases, Microsoft Entra ID interprets the application type based on the value of this property."
  type        = bool
  default     = null
}

variable "key_credentials" {
  description = "The collection of key credentials associated with the application. Not nullable. Supports $filter (eq, not, ge, le)."
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

variable "logo" {
  description = "The main logo for the application. Not nullable."
  type        = string
  default     = null
}

variable "manager_applications" {
  description = "A collection of application IDs for Microsoft first-party applications designated as managers. Manager applications can create service principals, agent identities, and agent users for managed agent blueprints. Limited to a maximum of 10 entries. Not nullable. Only supported on agentIdentityBlueprint objects; attempts to set this property on non-agent-blueprint applications return an error. Not returned by default; must be explicitly requested via $select."
  type        = list(string)
  default     = null
}

variable "native_authentication_apis_enabled" {
  description = "Specifies whether the Native Authentication APIs are enabled for the application. The possible values are: none and all. Default is none. For more information, see Native Authentication."
  type        = any
  default     = null

  validation {
    condition     = var.native_authentication_apis_enabled == null ? true : contains(["none", "all", "unknownFutureValue"], var.native_authentication_apis_enabled)
    error_message = "native_authentication_apis_enabled must be one of the documented enum values."
  }
}

variable "notes" {
  description = "Notes relevant for the management of the application."
  type        = string
  default     = null
}

variable "oauth2_require_post_response" {
  description = "Microsoft Graph oauth2RequirePostResponse property."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.application"
  nullable    = false
}

variable "optional_claims" {
  description = "Application developers can configure optional claims in their Microsoft Entra applications to specify the claims that are sent to their application by the Microsoft security token service. For more information, see How to: Provide optional claims to your app."
  type        = any
  default     = null
}

variable "owners" {
  description = "Directory objects that are owners of this application. The owners are a set of nonadmin users or service principals who are allowed to modify this object. Supports $expand, $filter (/$count eq 0, /$count ne 0, /$count eq 1, /$count ne 1), and $select nested in $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "parental_control_settings" {
  description = "Specifies parental control settings for an application."
  type        = any
  default     = null
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

variable "public_client" {
  description = "Specifies settings for installed clients such as desktop or mobile devices."
  type        = any
  default     = null
}

variable "request_signature_verification" {
  description = "Specifies whether this application requires Microsoft Entra ID to verify the signed authentication requests."
  type        = any
  default     = null
}

variable "required_resource_access" {
  description = "Specifies the resources that the application needs to access. This property also specifies the set of delegated permissions and application roles that it needs for each of those resources. This configuration of access to the required resources drives the consent experience. No more than 50 resource services (APIs) can be configured. Beginning mid-October 2021, the total number of required permissions must not exceed 400. For more information, see Limits on requested permissions per app. Not nullable. Supports $filter (eq, not, ge, le)."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.requiredResourceAccess")
    resourceAccess = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.resourceAccess")
      id         = optional(string)
      type       = optional(string)
    })))
    resourceAppId = optional(string)
  }))
  default = null
}

variable "saml_metadata_url" {
  description = "The URL where the service exposes SAML metadata for federation. This property is valid only for single-tenant applications. Nullable."
  type        = string
  default     = null
}

variable "service_management_reference" {
  description = "References application or service contact information from a Service or Asset Management database. Nullable."
  type        = string
  default     = null
}

variable "service_principal_lock_configuration" {
  description = "Specifies whether sensitive properties of a multitenant application should be locked for editing after the application is provisioned in a tenant. Nullable. null by default."
  type        = any
  default     = null
}

variable "sign_in_audience" {
  description = "Specifies the Microsoft accounts that are supported for the current application. The possible values are: AzureADMyOrg (default), AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, and PersonalMicrosoftAccount. See more in the table. The value of this object also limits the number of permissions an app can request. For more information, see Limits on requested permissions per app. The value for this property has implications on other app object properties. As a result, if you change this property, you might need to change other properties first. For more information, see Validation differences for signInAudience.Supports $filter (eq, ne, not)."
  type        = string
  default     = null
}

variable "spa" {
  description = "Specifies settings for a single-page application, including sign out URLs and redirect URIs for authorization codes and access tokens."
  type        = any
  default     = null
}

variable "synchronization" {
  description = "Represents the capability for Microsoft Entra identity synchronization through the Microsoft Graph API."
  type        = any
  default     = null
}

variable "tags" {
  description = "Custom strings that can be used to categorize and identify the application. Not nullable. Strings added here will also appear in the tags property of any associated service principals.Supports $filter (eq, not, ge, le, startsWith) and $search."
  type        = list(string)
  default     = null
}

variable "token_encryption_key_id" {
  description = "Specifies the keyId of a public key from the keyCredentials collection. When configured, Microsoft Entra ID encrypts all the tokens it emits by using the key this property points to. The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user."
  type        = string
  default     = null
}

variable "token_issuance_policies" {
  description = "Microsoft Graph tokenIssuancePolicies property."
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
  description = "Microsoft Graph tokenLifetimePolicies property."
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

variable "verified_publisher" {
  description = "Specifies the verified publisher of the application. For more information about how publisher verification helps support application security, trustworthiness, and compliance, see Publisher verification."
  type        = any
  default     = null
}

variable "web" {
  description = "Specifies settings for a web application."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appId", "applicationTemplateId", "createdByAppId", "createdDateTime", "createdOnBehalfOf", "extensionProperties", "id", "publisherDomain", "uniqueName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
