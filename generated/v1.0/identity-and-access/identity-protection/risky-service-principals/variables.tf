variable "app_id" {
  description = "The globally unique identifier for the associated application (its appId property), if any."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the service principal."
  type        = string
  default     = null
}

variable "history" {
  description = "Represents the risk history of Microsoft Entra service principals."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.riskyServicePrincipalHistoryItem")
    activity                = optional(any)
    appId                   = optional(string)
    displayName             = optional(string)
    history                 = optional(any)
    initiatedBy             = optional(string)
    isEnabled               = optional(bool)
    isProcessing            = optional(bool)
    riskDetail              = optional(any)
    riskLastUpdatedDateTime = optional(string)
    riskLevel               = optional(any)
    riskState               = optional(any)
    servicePrincipalType    = optional(string)
  }))
  default = null
}

variable "is_enabled" {
  description = "true if the service principal account is enabled; otherwise, false."
  type        = bool
  default     = null
}

variable "is_processing" {
  description = "Indicates whether Microsoft Entra ID is currently processing the service principal's risky state."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.riskyServicePrincipal"
  nullable    = false
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

variable "risk_last_updated_date_time" {
  description = "The date and time that the risk state was last updated. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2021 is 2021-01-01T00:00:00Z. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "risk_level" {
  description = "Level of the detected risky workload identity. The possible values are: low, medium, high, hidden, none, unknownFutureValue. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.risk_level == null ? true : contains(["low", "medium", "high", "hidden", "none", "unknownFutureValue"], var.risk_level)
    error_message = "risk_level must be one of the documented enum values."
  }
}

variable "risk_state" {
  description = "State of the service principal's risk. The possible values are: none, confirmedSafe, remediated, dismissed, atRisk, confirmedCompromised, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.risk_state == null ? true : contains(["none", "confirmedSafe", "remediated", "dismissed", "atRisk", "confirmedCompromised", "unknownFutureValue"], var.risk_state)
    error_message = "risk_state must be one of the documented enum values."
  }
}

variable "service_principal_type" {
  description = "Identifies whether the service principal represents an Application, a ManagedIdentity, or a legacy application (socialIdp). This is set by Microsoft Entra ID internally and is inherited from servicePrincipal."
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
