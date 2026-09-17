variable "agent_display_name" {
  description = "Name of the agent.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "blueprint_id" {
  description = "The identifier of the blueprint associated with the agent. Nullable."
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

variable "is_deleted" {
  description = "Indicates whether the agent is deleted."
  type        = bool
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the agent is enabled."
  type        = bool
  default     = null
}

variable "is_processing" {
  description = "Indicates whether an agent's risky state is processing in the backend."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.riskyAgent"
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

variable "risk_last_modified_date_time" {
  description = "The date and time that the risky agent was last updated. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.  Supports $filter (eq, le, and ge)."
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
