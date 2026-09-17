variable "activity" {
  description = "Indicates the activity type the detected risk is linked to."
  type        = any
  default     = null

  validation {
    condition     = var.activity == null ? true : contains(["signin", "user", "unknownFutureValue", "servicePrincipal"], var.activity)
    error_message = "activity must be one of the documented enum values."
  }
}

variable "activity_date_time" {
  description = "Date and time that the risky activity occurred. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is look like this: 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "additional_info" {
  description = "Additional information associated with the risk detection in JSON format. For example, '[{/'Key/':/'userAgent/',/'Value/':/'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36/'}]'. Possible keys in the additionalInfo JSON string are: userAgent, alertUrl, relatedEventTimeInUtc, relatedUserAgent, deviceInformation, relatedLocation, requestId, correlationId, lastActivityTimeInUtc, malwareName, clientLocation, clientIp, riskReasons. For more information about riskReasons and possible values, see riskReasons values."
  type        = string
  default     = null
}

variable "correlation_id" {
  description = "Correlation ID of the sign-in associated with the risk detection. This property is null if the risk detection is not associated with a sign-in."
  type        = string
  default     = null
}

variable "detected_date_time" {
  description = "Date and time that the risk was detected. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 looks like this: 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "detection_timing_type" {
  description = "Timing of the detected risk (real-time/offline). The possible values are: notDefined, realtime, nearRealtime, offline, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.detection_timing_type == null ? true : contains(["notDefined", "realtime", "nearRealtime", "offline", "unknownFutureValue"], var.detection_timing_type)
    error_message = "detection_timing_type must be one of the documented enum values."
  }
}

variable "graph_source" {
  description = "Source of the risk detection. For example, activeDirectory."
  type        = string
  default     = null
}

variable "ip_address" {
  description = "Provides the IP address of the client from where the risk occurred."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "Date and time that the risk detection was last updated. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is look like this: 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "location" {
  description = "Location of the sign-in."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.riskDetection"
  nullable    = false
}

variable "request_id" {
  description = "Request ID of the sign-in associated with the risk detection. This property is null if the risk detection is not associated with a sign-in."
  type        = string
  default     = null
}

variable "risk_detail" {
  description = "Details of the detected risk."
  type        = any
  default     = null

  validation {
    condition     = var.risk_detail == null ? true : contains(["none", "adminGeneratedTemporaryPassword", "userPerformedSecuredPasswordChange", "userPerformedSecuredPasswordReset", "adminConfirmedSigninSafe", "aiConfirmedSigninSafe", "userPassedMFADrivenByRiskBasedPolicy", "adminDismissedAllRiskForUser", "adminConfirmedSigninCompromised", "hidden", "adminConfirmedUserCompromised", "unknownFutureValue", "m365DAdminDismissedDetection", "adminConfirmedServicePrincipalCompromised", "adminDismissedAllRiskForServicePrincipal", "userChangedPasswordOnPremises", "adminDismissedRiskForSignIn", "adminConfirmedAccountSafe", "microsoftRevokedSessions"], var.risk_detail)
    error_message = "risk_detail must be one of the documented enum values."
  }
}

variable "risk_event_type" {
  description = "The type of risk event detected. The possible values are adminConfirmedUserCompromised, anomalousToken, anomalousUserActivity, anonymizedIPAddress, generic, impossibleTravel, investigationsThreatIntelligence, suspiciousSendingPatterns, leakedCredentials, maliciousIPAddress,malwareInfectedIPAddress, mcasSuspiciousInboxManipulationRules, newCountry, passwordSpray,riskyIPAddress, suspiciousAPITraffic, suspiciousBrowser,suspiciousInboxForwarding, suspiciousIPAddress, tokenIssuerAnomaly, unfamiliarFeatures, unlikelyTravel. If the risk detection is a premium detection, will show generic. For more information about each value, see Risk types and detection."
  type        = string
  default     = null
}

variable "risk_level" {
  description = "Level of the detected risk. The possible values are: low, medium, high, hidden, none, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level)
    error_message = "risk_level must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "The state of a detected risky user or sign-in. The possible values are: none, confirmedSafe, remediated, dismissed, atRisk, confirmedCompromised, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "token_issuer_type" {
  description = "Indicates the type of token issuer for the detected sign-in risk. The possible values are: AzureAD, ADFederationServices, UnknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.token_issuer_type == null ? true : contains(["AzureAD", "ADFederationServices", "UnknownFutureValue", "AzureADBackupAuth", "ADFederationServicesMFAAdapter", "NPSExtension"], var.token_issuer_type)
    error_message = "token_issuer_type must be one of the documented enum values."
  }
}

variable "user_display_name" {
  description = "The user principal name (UPN) of the user."
  type        = string
  default     = null
}

variable "user_id" {
  description = "Unique ID of the user."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The user principal name (UPN) of the user."
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
