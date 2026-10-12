variable "action_url" {
  description = "The link to the site where the admin can take action on the requirement."
  type        = string
  default     = null
}

variable "compliance_status" {
  description = "Microsoft Graph complianceStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.compliance_status == null ? true : contains(["compliant", "noncomplaint", "unknownFutureValue"], var.compliance_status)
    error_message = "compliance_status must be one of the documented enum values."
  }
}

variable "help_url" {
  description = "The link to documentation for the requirement."
  type        = string
  default     = null
}

variable "max_score" {
  description = "The maximum score possible for the requirement."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.partner.security.securityRequirement"
  nullable    = false
}

variable "requirement_type" {
  description = "Microsoft Graph requirementType property."
  type        = string
  default     = null

  validation {
    condition     = var.requirement_type == null ? true : contains(["mfaEnforcedForAdmins", "mfaEnforcedForAdminsOfCustomers", "securityAlertsPromptlyResolved", "securityContactProvided", "spendingBudgetSetForCustomerAzureSubscriptions", "unknownFutureValue"], var.requirement_type)
    error_message = "requirement_type must be one of the documented enum values."
  }
}

variable "score" {
  description = "The score received for this requirement."
  type        = number
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["active", "preview", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "updated_date_time" {
  description = "The date the requirement properties were last updated."
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
