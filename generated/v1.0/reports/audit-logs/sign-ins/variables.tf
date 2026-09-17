variable "app_display_name" {
  description = "App name displayed in the Microsoft Entra admin center.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "app_id" {
  description = "Unique GUID that represents the app ID in the Microsoft Entra ID.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "applied_conditional_access_policies" {
  description = "Provides a list of conditional access policies that the corresponding sign-in activity triggers. Apps need more Conditional Access-related privileges to read the details of this property. For more information, see Permissions for viewing applied conditional access (CA) policies in sign-ins."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.appliedConditionalAccessPolicy")
    displayName             = optional(string)
    enforcedGrantControls   = optional(list(string))
    enforcedSessionControls = optional(list(string))
    id                      = optional(string)
    result                  = optional(any)
  }))
  default = null
}

variable "authentication_app_device_details" {
  description = "Microsoft Graph authenticationAppDeviceDetails property."
  type        = any
  default     = null
}

variable "client_app_used" {
  description = "Identifies the client used for the sign-in activity. Modern authentication clients include Browser, modern clients. Legacy authentication clients include Exchange ActiveSync, IMAP, MAPI, SMTP, POP, and other clients.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "conditional_access_status" {
  description = "Reports status of an activated conditional access policy. The possible values are: success, failure, notApplied, and unknownFutureValue.  Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.conditional_access_status == null ? true : contains(["success", "failure", "notApplied", "unknownFutureValue"], var.conditional_access_status)
    error_message = "conditional_access_status must be one of the documented enum values."
  }
}

variable "correlation_id" {
  description = "The request ID sent from the client when the sign-in is initiated. Used to troubleshoot sign-in activity.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Date and time (UTC) the sign-in was initiated. Example: midnight on Jan 1, 2014 is reported as 2014-01-01T00:00:00Z.  Supports $orderby, $filter (eq, le, and ge)."
  type        = string
  default     = null
}

variable "device_detail" {
  description = "Device information from where the sign-in occurred; includes device ID, operating system, and browser.  Supports $filter (eq, startsWith) on browser and operatingSytem properties."
  type        = any
  default     = null
}

variable "home_tenant_id" {
  description = "Microsoft Graph homeTenantId property."
  type        = string
  default     = null
}

variable "ip_address" {
  description = "IP address of the client used to sign in.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "is_interactive" {
  description = "Indicates whether a sign-in is interactive."
  type        = bool
  default     = null
}

variable "location" {
  description = "Provides the city, state, and country code where the sign-in originated.  Supports $filter (eq, startsWith) on city, state, and countryOrRegion properties."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.signIn"
  nullable    = false
}

variable "resource_display_name" {
  description = "Name of the resource the user signed into.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "ID of the resource that the user signed into.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "resource_tenant_id" {
  description = "Microsoft Graph resourceTenantId property."
  type        = string
  default     = null
}

variable "risk_detail" {
  description = "The reason behind a specific state of a risky user, sign-in, or a risk event. The value none means that Microsoft Entra risk detection did not flag the user or the sign-in as a risky event so far.  Supports $filter (eq). Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_detail == null ? true : contains(["none", "adminGeneratedTemporaryPassword", "userPerformedSecuredPasswordChange", "userPerformedSecuredPasswordReset", "adminConfirmedSigninSafe", "aiConfirmedSigninSafe", "userPassedMFADrivenByRiskBasedPolicy", "adminDismissedAllRiskForUser", "adminConfirmedSigninCompromised", "hidden", "adminConfirmedUserCompromised", "unknownFutureValue", "m365DAdminDismissedDetection", "adminConfirmedServicePrincipalCompromised", "adminDismissedAllRiskForServicePrincipal", "userChangedPasswordOnPremises", "adminDismissedRiskForSignIn", "adminConfirmedAccountSafe", "microsoftRevokedSessions"], var.risk_detail)
    error_message = "risk_detail must be one of the documented enum values."
  }
}

variable "risk_event_types" {
  description = "Microsoft Graph riskEventTypes property."
  type        = any
  default     = null
}

variable "risk_event_types_v2" {
  description = "The list of risk event types associated with the sign-in. Possible values: unlikelyTravel, anonymizedIPAddress, maliciousIPAddress, unfamiliarFeatures, malwareInfectedIPAddress, suspiciousIPAddress, leakedCredentials, investigationsThreatIntelligence, generic, or unknownFutureValue.  Supports $filter (eq, startsWith)."
  type        = list(string)
  default     = null
}

variable "risk_level_aggregated" {
  description = "Aggregated risk level. The possible values are: none, low, medium, high, hidden, and unknownFutureValue. The value hidden means the user or sign-in wasn't enabled for Microsoft Entra ID Protection.  Supports $filter (eq).  Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level_aggregated == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level_aggregated)
    error_message = "risk_level_aggregated must be one of the documented enum values."
  }
}

variable "risk_level_during_sign_in" {
  description = "Risk level during sign-in. The possible values are: none, low, medium, high, hidden, and unknownFutureValue. The value hidden means the user or sign-in wasn't enabled for Microsoft Entra ID Protection.  Supports $filter (eq). Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level_during_sign_in == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level_during_sign_in)
    error_message = "risk_level_during_sign_in must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "Reports status of the risky user, sign-in, or a risk event. The possible values are: none, confirmedSafe, remediated, dismissed, atRisk, confirmedCompromised, unknownFutureValue.  Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "service_principal_id" {
  description = "Microsoft Graph servicePrincipalId property."
  type        = string
  default     = null
}

variable "service_principal_name" {
  description = "Microsoft Graph servicePrincipalName property."
  type        = string
  default     = null
}

variable "status" {
  description = "Sign-in status. Includes the error code and description of the error (if a sign-in failure occurs).  Supports $filter (eq) on errorCode property."
  type        = any
  default     = null
}

variable "user_agent" {
  description = "Microsoft Graph userAgent property."
  type        = string
  default     = null
}

variable "user_display_name" {
  description = "Display name of the user that initiated the sign-in.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "user_id" {
  description = "ID of the user that initiated the sign-in.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User principal name of the user that initiated the sign-in. This value is always in lowercase. For guest users whose values in the user object typically contain #EXT# before the domain part, this property stores the value in both lowercase and the 'true' format. For example, while the user object stores AdeleVance_fabrikam.com#EXT#@contoso.com, the sign-in logs store adelevance@fabrikam.com. Supports $filter (eq, startsWith)."
  type        = string
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
