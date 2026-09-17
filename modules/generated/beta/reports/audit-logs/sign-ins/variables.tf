variable "agent" {
  description = "Represents details about the agentic sign-in. Includes the type of agent as well as parentAppID in some cases"
  type        = any
  default     = null
}

variable "app_display_name" {
  description = "The application name displayed in the Microsoft Entra admin center.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "app_id" {
  description = "The application identifier in Microsoft Entra ID.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "app_owner_tenant_id" {
  description = "The identifier of the tenant that owns the client application.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "app_token_protection_status" {
  description = "Deprecated. Use tokenProtectionStatusDetails instead. Token protection creates a cryptographically secure tie between the token and the device it's issued to. This field indicates whether the app token was bound to the device."
  type        = any
  default     = null

  validation {
    condition     = var.app_token_protection_status == null ? true : contains(["none", "bound", "unbound", "unknownFutureValue"], var.app_token_protection_status)
    error_message = "app_token_protection_status must be one of the documented enum values."
  }
}

variable "applied_conditional_access_policies" {
  description = "A list of conditional access policies that the corresponding sign-in activity triggers. Apps need more Conditional Access-related privileges to read the details of this property. For more information, see Permissions for viewing applied conditional access (CA) policies in sign-ins."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.appliedConditionalAccessPolicy")
    authenticationStrength  = optional(any)
    conditionsNotSatisfied  = optional(any)
    conditionsSatisfied     = optional(any)
    displayName             = optional(string)
    enforcedGrantControls   = optional(list(string))
    enforcedSessionControls = optional(list(string))
    excludeRulesSatisfied = optional(list(object({
      odata_type                 = optional(string, "#microsoft.graph.conditionalAccessRuleSatisfied")
      conditionalAccessCondition = optional(any)
      ruleSatisfied              = optional(any)
    })))
    id = optional(string)
    includeRulesSatisfied = optional(list(object({
      odata_type                 = optional(string, "#microsoft.graph.conditionalAccessRuleSatisfied")
      conditionalAccessCondition = optional(any)
      ruleSatisfied              = optional(any)
    })))
    result                      = optional(any)
    sessionControlsNotSatisfied = optional(list(string))
  }))
  default = null
}

variable "applied_event_listeners" {
  description = "Detailed information about the listeners, such as Azure Logic Apps and Azure Functions, which the corresponding events in the sign-in event triggered."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.appliedAuthenticationEventListener")
    eventType          = optional(any)
    executedListenerId = optional(string)
    handlerResult      = optional(any)
  }))
  default = null
}

variable "authentication_app_device_details" {
  description = "Provides details about the app and device used during a Microsoft Entra authentication step."
  type        = any
  default     = null
}

variable "authentication_app_policy_evaluation_details" {
  description = "Provides details of the Microsoft Entra policies applied to a user and client authentication app during an authentication step."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.authenticationAppPolicyDetails")
    adminConfiguration       = optional(any)
    authenticationEvaluation = optional(any)
    policyName               = optional(string)
    status                   = optional(any)
  }))
  default = null
}

variable "authentication_context_class_references" {
  description = "Contains a collection of values that represent the conditional access authentication contexts applied to the sign-in."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.authenticationContext")
    detail     = optional(any)
    id         = optional(string)
  }))
  default = null
}

variable "authentication_details" {
  description = "The result of the authentication attempt and more details on the authentication method."
  type = list(object({
    odata_type                     = optional(string, "#microsoft.graph.authenticationDetail")
    authenticationMethod           = optional(string)
    authenticationMethodDetail     = optional(string)
    authenticationStepDateTime     = optional(string)
    authenticationStepRequirement  = optional(string)
    authenticationStepResultDetail = optional(string)
    succeeded                      = optional(bool)
  }))
  default = null
}

variable "authentication_methods_used" {
  description = "The authentication methods used. Possible values: SMS, Authenticator App, App Verification code, Password, FIDO, PTA, or PHS."
  type        = list(string)
  default     = null
}

variable "authentication_processing_details" {
  description = "More authentication processing details, such as the agent name for PTA and PHS, or a server or farm name for federated authentication."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValue")
    key        = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "authentication_protocol" {
  description = "Lists the protocol type or grant type used in the authentication. The possible values are: none, oAuth2, ropc, wsFederation, saml20, deviceCode, unknownFutureValue, authenticationTransfer, nativeAuth, implicitAccessTokenAndGetResponseMode, implicitIdTokenAndGetResponseMode, implicitAccessTokenAndPostResponseMode, implicitIdTokenAndPostResponseMode, authorizationCodeWithoutPkce, authorizationCodeWithPkce, clientCredentials, refreshTokenGrant, encryptedAuthorizeResponse, directUserGrant, kerberos, prtGrant, seamlessSso, prtBrokerBased, prtNonBrokerBased, onBehalfOf, samlOnBehalfOf. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: authenticationTransfer , nativeAuth , implicitAccessTokenAndGetResponseMode , implicitIdTokenAndGetResponseMode , implicitAccessTokenAndPostResponseMode , implicitIdTokenAndPostResponseMode , authorizationCodeWithoutPkce , authorizationCodeWithPkce , clientCredentials , refreshTokenGrant , encryptedAuthorizeResponse , directUserGrant , kerberos , prtGrant , seamlessSso , prtBrokerBased , prtNonBrokerBased , onBehalfOf , samlOnBehalfOf."
  type        = any
  default     = null

  validation {
    condition     = var.authentication_protocol == null ? true : contains(["none", "oAuth2", "ropc", "wsFederation", "saml20", "deviceCode", "unknownFutureValue", "authenticationTransfer", "nativeAuth", "implicitAccessTokenAndGetResponseMode", "implicitIdTokenAndGetResponseMode", "implicitAccessTokenAndPostResponseMode", "implicitIdTokenAndPostResponseMode", "authorizationCodeWithoutPkce", "authorizationCodeWithPkce", "clientCredentials", "refreshTokenGrant", "encryptedAuthorizeResponse", "directUserGrant", "kerberos", "prtGrant", "seamlessSso", "prtBrokerBased", "prtNonBrokerBased", "onBehalfOf", "samlOnBehalfOf", "officeS2S", "wsTrust"], var.authentication_protocol)
    error_message = "authentication_protocol must be one of the documented enum values."
  }
}

variable "authentication_requirement" {
  description = "The authentication stage reached during sign-in. It doesn't account for previously satisfied claims. If primary authentication fails, the sign-in attempt is not evaluated by Conditional Access, so the resulting value is singleFactorAuthentication.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "authentication_requirement_policies" {
  description = "Sources of authentication requirement, such as conditional access, per-user MFA, identity protection, and security defaults."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.authenticationRequirementPolicy")
    detail              = optional(string)
    requirementProvider = optional(any)
  }))
  default = null
}

variable "autonomous_system_number" {
  description = "The Autonomous System Number (ASN) of the network used by the actor."
  type        = number
  default     = null
}

variable "azure_resource_id" {
  description = "Contains a fully qualified Azure Resource Manager ID of an Azure resource accessed during the sign-in."
  type        = string
  default     = null
}

variable "client_app_used" {
  description = "The legacy client used for sign-in activity. For example: Browser, Exchange ActiveSync, Modern clients, IMAP, MAPI, SMTP, or POP.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "client_credential_type" {
  description = "Describes the credential type that a user client or service principal provided to Microsoft Entra ID to authenticate itself. You can review this property to track and eliminate less secure credential types or to watch for clients and service principals using anomalous credential types. The possible values are: none, clientSecret, clientAssertion, federatedIdentityCredential, managedIdentity, certificate, unknownFutureValue."
  type        = any
  default     = null
  sensitive   = true

  validation {
    condition     = var.client_credential_type == null ? true : contains(["none", "clientSecret", "clientAssertion", "federatedIdentityCredential", "managedIdentity", "certificate", "unknownFutureValue"], var.client_credential_type)
    error_message = "client_credential_type must be one of the documented enum values."
  }
}

variable "client_session_id" {
  description = "Microsoft Graph clientSessionId property."
  type        = string
  default     = null
}

variable "conditional_access_audiences" {
  description = "A list that indicates the audience that Conditional Access evaluated during a sign-in event.  Supports $filter (eq)."
  type        = list(string)
  default     = null
}

variable "conditional_access_status" {
  description = "The status of the conditional access policy triggered. Possible values: success, failure, notApplied, or unknownFutureValue.  Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.conditional_access_status == null ? true : contains(["success", "failure", "notApplied", "unknownFutureValue"], var.conditional_access_status)
    error_message = "conditional_access_status must be one of the documented enum values."
  }
}

variable "correlation_id" {
  description = "The identifier the client sends when sign-in is initiated. This property is used for troubleshooting the corresponding sign-in activity when calling for support.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time the sign-in was initiated. The Timestamp type is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.  Supports $orderby, $filter (eq, le, and ge)."
  type        = string
  default     = null
}

variable "cross_tenant_access_type" {
  description = "Describes the type of cross-tenant access used by the actor to access the resource. The possible values are: none, b2bCollaboration, b2bDirectConnect, microsoftSupport, serviceProvider, unknownFutureValue, passthrough. Use the Prefer: include-unknown-enum-members request header to get the following value or values in this evolvable enum: passthrough. If the sign in didn't cross tenant boundaries, the value is none."
  type        = any
  default     = null

  validation {
    condition     = var.cross_tenant_access_type == null ? true : contains(["none", "b2bCollaboration", "b2bDirectConnect", "microsoftSupport", "serviceProvider", "unknownFutureValue", "passthrough"], var.cross_tenant_access_type)
    error_message = "cross_tenant_access_type must be one of the documented enum values."
  }
}

variable "device_detail" {
  description = "The device information from where the sign-in occurred. Includes information such as deviceId, OS, and browser.  Supports $filter (eq, startsWith) on browser and operatingSystem properties."
  type        = any
  default     = null
}

variable "federated_credential_id" {
  description = "Contains the identifier of an application's federated identity credential, if a federated identity credential was used to sign in."
  type        = string
  default     = null
  sensitive   = true
}

variable "flagged_for_review" {
  description = "During a failed sign-in, a user can select a button in the Azure portal to mark the failed event for tenant admins. If a user selects the button to flag the failed sign-in, this value is true."
  type        = bool
  default     = null
}

variable "global_secure_access_ip_address" {
  description = "The Global Secure Access IP address that the sign-in was initiated from."
  type        = string
  default     = null
}

variable "home_tenant_id" {
  description = "The tenant identifier of the user initiating the sign-in. Not applicable in Managed Identity or service principal sign ins."
  type        = string
  default     = null
}

variable "home_tenant_name" {
  description = "For user sign ins, the identifier of the tenant that the user is a member of. Only populated in cases where the home tenant provides affirmative consent to Microsoft Entra ID to show the tenant content."
  type        = string
  default     = null
}

variable "incoming_token_type" {
  description = "Indicates the token types that were presented to Microsoft Entra ID to authenticate the actor in the sign in. The possible values are: none, primaryRefreshToken, saml11, saml20, unknownFutureValue, remoteDesktopToken, refreshToken.  NOTE Microsoft Entra ID might have also used token types not listed in this enum type to authenticate the actor. Don't infer the lack of a token if it isn't one of the types listed. Use the Prefer: include-unknown-enum-members request header to get the following value or values in this evolvable enum: remoteDesktopToken, refreshToken."
  type        = any
  default     = null

  validation {
    condition     = var.incoming_token_type == null ? true : contains(["none", "primaryRefreshToken", "saml11", "saml20", "unknownFutureValue", "remoteDesktopToken", "refreshToken"], var.incoming_token_type)
    error_message = "incoming_token_type must be one of the documented enum values."
  }
}

variable "ip_address" {
  description = "The IP address of the client from where the sign-in occurred.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "ip_address_from_resource_provider" {
  description = "The IP address a user used to reach a resource provider, used to determine Conditional Access compliance for some policies. For example, when a user interacts with Exchange Online, the IP address that Microsoft Exchange receives from the user can be recorded here. This value is often null."
  type        = string
  default     = null
}

variable "is_interactive" {
  description = "Indicates whether a user sign in is interactive. In interactive sign in, the user provides an authentication factor to Microsoft Entra ID. These factors include passwords, responses to MFA challenges, biometric factors, or QR codes that a user provides to Microsoft Entra ID or an associated app. In non-interactive sign in, the user doesn't provide an authentication factor. Instead, the client app uses a token or code to authenticate or access a resource on behalf of a user. Non-interactive sign ins are commonly used for a client to sign in on a user's behalf in a process transparent to the user."
  type        = bool
  default     = null
}

variable "is_tenant_restricted" {
  description = "Shows whether the sign in event was subject to a Microsoft Entra tenant restriction policy."
  type        = bool
  default     = null
}

variable "is_through_global_secure_access" {
  description = "Indicates whether a user came through Global Secure Access service."
  type        = bool
  default     = null
}

variable "location" {
  description = "The city, state, and two letter country code from where the sign-in occurred.  Supports $filter (eq, startsWith) on city, state, and countryOrRegion properties."
  type        = any
  default     = null
}

variable "managed_service_identity" {
  description = "Contains information about the managed identity used for the sign in, including its type, associated Azure Resource Manager (ARM) resource ID, and federated token information."
  type        = any
  default     = null
}

variable "mfa_detail" {
  description = "This property is deprecated."
  type        = any
  default     = null
}

variable "network_location_details" {
  description = "The network location details including the type of network used and its names."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.networkLocationDetail")
    networkNames = optional(list(string))
    networkType  = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.signIn"
  nullable    = false
}

variable "original_request_id" {
  description = "The request identifier of the first request in the authentication sequence.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "original_transfer_method" {
  description = "Transfer method used to initiate a session throughout all subsequent request. The possible values are: none, deviceCodeFlow, authenticationTransfer, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.original_transfer_method == null ? true : contains(["none", "deviceCodeFlow", "authenticationTransfer", "unknownFutureValue"], var.original_transfer_method)
    error_message = "original_transfer_method must be one of the documented enum values."
  }
}

variable "private_link_details" {
  description = "Contains information about the Microsoft Entra Private Link policy that is associated with the sign in event."
  type        = any
  default     = null
}

variable "processing_time_in_milliseconds" {
  description = "The request processing time in milliseconds in AD STS."
  type        = number
  default     = null
}

variable "resource_display_name" {
  description = "The name of the resource that the user signed in to.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "The identifier of the resource that the user signed in to.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "resource_owner_tenant_id" {
  description = "The identifier of the owner of the resource.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "resource_service_principal_id" {
  description = "The identifier of the service principal representing the target resource in the sign-in event."
  type        = string
  default     = null
}

variable "resource_tenant_id" {
  description = "The tenant identifier of the resource referenced in the sign in."
  type        = string
  default     = null
}

variable "risk_detail" {
  description = "The reason behind a specific state of a risky user, sign-in, or a risk event. The value none means that Microsoft Entra risk detection hasn't flagged the user or the sign-in as a risky event so far.  Supports $filter (eq). Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_detail == null ? true : contains(["none", "adminGeneratedTemporaryPassword", "userPerformedSecuredPasswordChange", "userPerformedSecuredPasswordReset", "adminConfirmedSigninSafe", "aiConfirmedSigninSafe", "userPassedMFADrivenByRiskBasedPolicy", "adminDismissedAllRiskForUser", "adminConfirmedSigninCompromised", "hidden", "adminConfirmedUserCompromised", "unknownFutureValue", "adminConfirmedServicePrincipalCompromised", "adminDismissedAllRiskForServicePrincipal", "m365DAdminDismissedDetection", "userChangedPasswordOnPremises", "adminDismissedRiskForSignIn", "adminConfirmedAccountSafe", "adminConfirmedAgentSafe", "adminConfirmedAgentCompromised", "adminDismissedRiskForAgent", "microsoftRevokedSessions"], var.risk_detail)
    error_message = "risk_detail must be one of the documented enum values."
  }
}

variable "risk_event_types_v2" {
  description = "The list of risk event types associated with the sign-in. Possible values: unlikelyTravel, anonymizedIPAddress, maliciousIPAddress, unfamiliarFeatures, malwareInfectedIPAddress, suspiciousIPAddress, leakedCredentials, investigationsThreatIntelligence,  generic, or unknownFutureValue.  Supports $filter (eq, startsWith)."
  type        = list(string)
  default     = null
}

variable "risk_level_aggregated" {
  description = "The aggregated risk level. Possible values: none, low, medium, high, hidden, or unknownFutureValue. The value hidden means the user or sign-in wasn't enabled for Microsoft Entra ID Protection.  Supports $filter (eq). Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level_aggregated == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level_aggregated)
    error_message = "risk_level_aggregated must be one of the documented enum values."
  }
}

variable "risk_level_during_sign_in" {
  description = "The risk level during sign-in. Possible values: none, low, medium, high, hidden, or unknownFutureValue. The value hidden means the user or sign-in wasn't enabled for Microsoft Entra ID Protection.  Supports $filter (eq). Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level_during_sign_in == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level_during_sign_in)
    error_message = "risk_level_during_sign_in must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "The risk state of a risky user, sign-in, or a risk event. Possible values: none, confirmedSafe, remediated, dismissed, atRisk, confirmedCompromised, or unknownFutureValue.  Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "root_actor_id" {
  description = "Microsoft Graph rootActorId property."
  type        = string
  default     = null
}

variable "service_principal_credential_key_id" {
  description = "The unique identifier of the key credential used by the service principal to authenticate."
  type        = string
  default     = null
  sensitive   = true
}

variable "service_principal_credential_thumbprint" {
  description = "The certificate thumbprint of the certificate used by the service principal to authenticate."
  type        = string
  default     = null
  sensitive   = true
}

variable "service_principal_id" {
  description = "The application identifier used for sign-in. This field is populated when you're signing in using an application.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "service_principal_name" {
  description = "The application name used for sign-in. This field is populated when you're signing in using an application.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "session_id" {
  description = "Identifier of the session that was generated during the sign-in."
  type        = string
  default     = null
}

variable "session_lifetime_policies" {
  description = "Any conditional access session management policies that were applied during the sign-in event."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.sessionLifetimePolicy")
    detail                = optional(string)
    expirationRequirement = optional(any)
  }))
  default = null
}

variable "sign_in_event_types" {
  description = "Indicates the category of sign in that the event represents. For user sign ins, the category can be interactiveUser or nonInteractiveUser and corresponds to the value for the isInteractive property on the signin resource. For managed identity sign ins, the category is managedIdentity. For service principal sign-ins, the category is servicePrincipal. The possible values are: interactiveUser, nonInteractiveUser, servicePrincipal, managedIdentity, unknownFutureValue.  Supports $filter (eq, ne). NOTE: Only interactive sign-ins are returned unless you set an explicit filter. For example, the filter for getting non-interactive sign-ins is https://graph.microsoft.com/beta/auditLogs/signIns?&$filter=signInEventTypes/any(t: t eq 'nonInteractiveUser'). You can also get both interactive and non-interactive sign-ins using the filter signInEventTypes/any(t: t eq 'interactiveUser' or t eq 'noninteractiveUser'). However, the filter for getting both user and service principal sign-in even types is not supported."
  type        = list(string)
  default     = null
}

variable "sign_in_identifier" {
  description = "The identification that the user provided to sign in. It can be the userPrincipalName, but is also populated when a user signs in using other identifiers."
  type        = string
  default     = null
}

variable "sign_in_identifier_type" {
  description = "The type of sign in identifier. The possible values are: userPrincipalName, phoneNumber, proxyAddress, qrCode, onPremisesUserPrincipalName, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.sign_in_identifier_type == null ? true : contains(["userPrincipalName", "phoneNumber", "proxyAddress", "qrCode", "onPremisesUserPrincipalName", "unknownFutureValue"], var.sign_in_identifier_type)
    error_message = "sign_in_identifier_type must be one of the documented enum values."
  }
}

variable "sign_in_token_protection_status" {
  description = "Deprecated. Use tokenProtectionStatusDetails instead. Token protection creates a cryptographically secure tie between the token and the device it's issued to. This field indicates whether the sign-in token was bound to the device. The possible values are: none, bound, unbound, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.sign_in_token_protection_status == null ? true : contains(["none", "bound", "unbound", "unknownFutureValue"], var.sign_in_token_protection_status)
    error_message = "sign_in_token_protection_status must be one of the documented enum values."
  }
}

variable "status" {
  description = "The sign-in status. Includes the error code and description of the error (for a sign-in failure).  Supports $filter (eq) on errorCode property."
  type        = any
  default     = null
}

variable "token_issuer_name" {
  description = "The name of the identity provider. For example, sts.microsoft.com.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "token_issuer_type" {
  description = "The type of identity provider. The possible values are: AzureAD, ADFederationServices, UnknownFutureValue, AzureADBackupAuth, ADFederationServicesMFAAdapter, NPSExtension. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: AzureADBackupAuth , ADFederationServicesMFAAdapter , NPSExtension."
  type        = any
  default     = null

  validation {
    condition     = var.token_issuer_type == null ? true : contains(["AzureAD", "ADFederationServices", "UnknownFutureValue", "AzureADBackupAuth", "ADFederationServicesMFAAdapter", "NPSExtension"], var.token_issuer_type)
    error_message = "token_issuer_type must be one of the documented enum values."
  }
}

variable "token_protection_status_details" {
  description = "The status of the token protection for a request in the sign-in logs. For more information, see Conditional Access: Token Protection."
  type        = any
  default     = null
}

variable "unique_token_identifier" {
  description = "A unique base64-encoded request identifier used to track tokens issued by Microsoft Entra ID as they're redeemed at resource providers."
  type        = string
  default     = null
}

variable "user_agent" {
  description = "The user agent information related to sign-in.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "user_display_name" {
  description = "The display name of the user.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "user_id" {
  description = "The identifier of the user.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User principal name of the user that initiated the sign-in. This value is always in lowercase. For guest users whose values in the user object typically contain #EXT# before the domain part, this property stores the value in both lowercase and the 'true' format. For example, while the user object stores AdeleVance_fabrikam.com#EXT#@contoso.com, the sign-in logs store adelevance@fabrikam.com. Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "user_type" {
  description = "Identifies whether the user is a member or guest in the tenant. The possible values are: member, guest, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.user_type == null ? true : contains(["member", "guest", "unknownFutureValue"], var.user_type)
    error_message = "user_type must be one of the documented enum values."
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
