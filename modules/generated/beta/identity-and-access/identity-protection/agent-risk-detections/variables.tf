variable "activity_date_time" {
  description = "Date and time that the risky activity occurred. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.  Supports $filter (eq, le, and ge)."
  type        = string
  default     = null
}

variable "additional_info" {
  description = "Additional information associated with the risk detection."
  type        = string
  default     = null
}

variable "agent_display_name" {
  description = "Name of the agent. Deprecated. Use displayName instead. This property will be removed after 2027-04-28.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "agent_id" {
  description = "The unique identifier for the agent. Deprecated. Use identityId instead. This property will be removed after 2027-04-28. See riskyAgentIdentity, riskyAgentIdentityBlueprintPrincipal, and riskyAgentUser.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "blueprint_id" {
  description = "The identifier of the blueprint associated with the agent. Nullable."
  type        = string
  default     = null
}

variable "client_session_id" {
  description = "Microsoft Graph clientSessionId property."
  type        = string
  default     = null
}

variable "detected_date_time" {
  description = "Date and time that the risk was detected. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.  Supports $filter (eq, le, and ge)."
  type        = string
  default     = null
}

variable "detection_timing_type" {
  description = "Microsoft Graph detectionTimingType property."
  type        = string
  default     = null

  validation {
    condition     = var.detection_timing_type == null ? true : contains(["notDefined", "realtime", "nearRealtime", "offline", "unknownFutureValue"], var.detection_timing_type)
    error_message = "detection_timing_type must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "Human-readable name of the identity associated with this risk detection.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "The source system that generated the risk detection. Nullable."
  type        = string
  default     = null
}

variable "identity_id" {
  description = "Unique identifier of the identity associated with this risk detection.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "identity_type" {
  description = "Microsoft Graph identityType property."
  type        = string
  default     = null

  validation {
    condition     = var.identity_type == null ? true : contains(["agentIdentity", "agentUser", "unknownFutureValue", "agentIdentityBlueprintPrincipal", "user", "discoveredAgentIdentity"], var.identity_type)
    error_message = "identity_type must be one of the documented enum values."
  }
}

variable "last_modified_date_time" {
  description = "Date and time that the risk detection was last updated.  Supports $filter (eq, le, and ge)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agentRiskDetection"
  nullable    = false
}

variable "risk_detail" {
  description = "Microsoft Graph riskDetail property."
  type        = string
  default     = null

  validation {
    condition     = var.risk_detail == null ? true : contains(["none", "adminGeneratedTemporaryPassword", "userPerformedSecuredPasswordChange", "userPerformedSecuredPasswordReset", "adminConfirmedSigninSafe", "aiConfirmedSigninSafe", "userPassedMFADrivenByRiskBasedPolicy", "adminDismissedAllRiskForUser", "adminConfirmedSigninCompromised", "hidden", "adminConfirmedUserCompromised", "unknownFutureValue", "adminConfirmedServicePrincipalCompromised", "adminDismissedAllRiskForServicePrincipal", "m365DAdminDismissedDetection", "userChangedPasswordOnPremises", "adminDismissedRiskForSignIn", "adminConfirmedAccountSafe", "adminConfirmedAgentSafe", "adminConfirmedAgentCompromised", "adminDismissedRiskForAgent", "microsoftRevokedSessions"], var.risk_detail)
    error_message = "risk_detail must be one of the documented enum values."
  }
}

variable "risk_event_type" {
  description = "The type of risk event detected.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "risk_evidence" {
  description = "Evidence on the risky activity occurred.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "risk_level" {
  description = "Microsoft Graph riskLevel property."
  type        = string
  default     = null

  validation {
    condition     = var.risk_level == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level)
    error_message = "risk_level must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "Microsoft Graph riskState property."
  type        = string
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "sign_in_client_display_name" {
  description = "Microsoft Graph signInClientDisplayName property."
  type        = string
  default     = null
}

variable "sign_in_correlation_id" {
  description = "Microsoft Graph signInCorrelationId property."
  type        = string
  default     = null
}

variable "sign_in_request_id" {
  description = "Microsoft Graph signInRequestId property."
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
