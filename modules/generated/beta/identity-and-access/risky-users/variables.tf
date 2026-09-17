variable "history" {
  description = "Microsoft Graph history property."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.riskyUserHistoryItem")
    activity                = optional(any)
    history                 = optional(any)
    initiatedBy             = optional(string)
    isDeleted               = optional(bool)
    isProcessing            = optional(bool)
    riskDetail              = optional(any)
    riskLastUpdatedDateTime = optional(string)
    riskLevel               = optional(any)
    riskState               = optional(any)
    userDisplayName         = optional(string)
    userId                  = optional(string)
    userPrincipalName       = optional(string)
  }))
  default = null
}

variable "is_deleted" {
  description = "Indicates whether the user is deleted. The possible values are: true, false."
  type        = bool
  default     = null
}

variable "is_processing" {
  description = "Indicates whether a user's risky state is being processed by the backend."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.riskyUser"
  nullable    = false
}

variable "risk_detail" {
  description = "Details of the detected risk. Note: Details for this property are only available for Microsoft Entra ID P2 customers. All other customers are returned hidden."
  type        = any
  default     = null

  validation {
    condition     = var.risk_detail == null ? true : contains(["none", "adminGeneratedTemporaryPassword", "userPerformedSecuredPasswordChange", "userPerformedSecuredPasswordReset", "adminConfirmedSigninSafe", "aiConfirmedSigninSafe", "userPassedMFADrivenByRiskBasedPolicy", "adminDismissedAllRiskForUser", "adminConfirmedSigninCompromised", "hidden", "adminConfirmedUserCompromised", "unknownFutureValue", "adminConfirmedServicePrincipalCompromised", "adminDismissedAllRiskForServicePrincipal", "m365DAdminDismissedDetection", "userChangedPasswordOnPremises", "adminDismissedRiskForSignIn", "adminConfirmedAccountSafe", "adminConfirmedAgentSafe", "adminConfirmedAgentCompromised", "adminDismissedRiskForAgent", "microsoftRevokedSessions"], var.risk_detail)
    error_message = "risk_detail must be one of the documented enum values."
  }
}

variable "risk_last_updated_date_time" {
  description = "The date and time that the risky user was last updated.  The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "risk_level" {
  description = "Level of the detected risky user. The possible values are low, medium, high, hidden, none, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level)
    error_message = "risk_level must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "State of the user's risk. The possible values are: none, confirmedSafe, remediated, dismissed, atRisk, confirmedCompromised, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "user_display_name" {
  description = "Risky user display name."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "Risky user principal name."
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
