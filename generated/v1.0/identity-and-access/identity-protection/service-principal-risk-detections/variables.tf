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
  description = "Date and time when the risky activity occurred. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "additional_info" {
  description = "Additional information associated with the risk detection. This string value is represented as a JSON object with the quotations escaped."
  type        = string
  default     = null
}

variable "app_id" {
  description = "The unique identifier for the associated application."
  type        = string
  default     = null
}

variable "correlation_id" {
  description = "Correlation ID of the sign-in activity associated with the risk detection. This property is null if the risk detection is not associated with a sign-in activity."
  type        = string
  default     = null
}

variable "detected_date_time" {
  description = "Date and time when the risk was detected. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "detection_timing_type" {
  description = "Timing of the detected risk , whether real-time or offline. The possible values are: notDefined, realtime, nearRealtime, offline, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.detection_timing_type == null ? true : contains(["notDefined", "realtime", "nearRealtime", "offline", "unknownFutureValue"], var.detection_timing_type)
    error_message = "detection_timing_type must be one of the documented enum values."
  }
}

variable "graph_source" {
  description = "Source of the risk detection. For example, identityProtection."
  type        = string
  default     = null
}

variable "ip_address" {
  description = "Provides the IP address of the client from where the risk occurred."
  type        = string
  default     = null
}

variable "key_ids" {
  description = "The unique identifier for the key credential associated with the risk detection."
  type        = list(string)
  default     = null
}

variable "last_updated_date_time" {
  description = "Date and time when the risk detection was last updated."
  type        = string
  default     = null
}

variable "location" {
  description = "Location from where the sign-in was initiated."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.servicePrincipalRiskDetection"
  nullable    = false
}

variable "request_id" {
  description = "Request identifier of the sign-in activity associated with the risk detection. This property is null if the risk detection is not associated with a sign-in activity. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "risk_detail" {
  description = "Details of the detected risk. Note: Details for this property are only available for Workload Identities Premium customers. Events in tenants without this license will be returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_detail == null ? true : contains(["none", "adminGeneratedTemporaryPassword", "userPerformedSecuredPasswordChange", "userPerformedSecuredPasswordReset", "adminConfirmedSigninSafe", "aiConfirmedSigninSafe", "userPassedMFADrivenByRiskBasedPolicy", "adminDismissedAllRiskForUser", "adminConfirmedSigninCompromised", "hidden", "adminConfirmedUserCompromised", "unknownFutureValue", "m365DAdminDismissedDetection", "adminConfirmedServicePrincipalCompromised", "adminDismissedAllRiskForServicePrincipal", "userChangedPasswordOnPremises", "adminDismissedRiskForSignIn", "adminConfirmedAccountSafe", "microsoftRevokedSessions"], var.risk_detail)
    error_message = "risk_detail must be one of the documented enum values."
  }
}

variable "risk_event_type" {
  description = "The type of risk event detected. The possible values are: investigationsThreatIntelligence, generic, adminConfirmedServicePrincipalCompromised, suspiciousSignins, leakedCredentials, anomalousServicePrincipalActivity, maliciousApplication, suspiciousApplication."
  type        = string
  default     = null
}

variable "risk_level" {
  description = "Level of the detected risk. Note: Details for this property are only available for Workload Identities Premium customers. Events in tenants without this license will be returned hidden. The possible values are: low, medium, high, hidden, none."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level)
    error_message = "risk_level must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "The state of a detected risky service principal or sign-in activity. The possible values are: none, dismissed, atRisk, confirmedCompromised."
  type        = any
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "service_principal_display_name" {
  description = "The display name for the service principal."
  type        = string
  default     = null
}

variable "service_principal_id" {
  description = "The unique identifier for the service principal. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "token_issuer_type" {
  description = "Indicates the type of token issuer for the detected sign-in risk. The possible values are: AzureAD."
  type        = any
  default     = null

  validation {
    condition     = var.token_issuer_type == null ? true : contains(["AzureAD", "ADFederationServices", "UnknownFutureValue", "AzureADBackupAuth", "ADFederationServicesMFAAdapter", "NPSExtension"], var.token_issuer_type)
    error_message = "token_issuer_type must be one of the documented enum values."
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
