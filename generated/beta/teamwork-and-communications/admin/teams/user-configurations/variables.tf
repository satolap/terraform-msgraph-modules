variable "account_type" {
  description = "Microsoft Graph accountType property."
  type        = string
  default     = null

  validation {
    condition     = var.account_type == null ? true : contains(["user", "resourceAccount", "guest", "sfbOnPremUser", "unknown", "unknownFutureValue", "ineligibleUser"], var.account_type)
    error_message = "account_type must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "The date and time when the user was created. The timestamp represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "effective_policy_assignments" {
  description = "Contains the user's effective policy assignments, with each assignment including policyType and policyAssignment details."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsAdministration.effectivePolicyAssignment")
    policyAssignment = optional(object({
      odata_type     = optional(string, "#microsoft.graph.teamsAdministration.policyAssignment")
      assignmentType = optional(string)
      displayName    = optional(string)
      groupId        = optional(string)
      policyId       = optional(string)
    }))
    policyType = optional(string)
  }))
  default = null
}

variable "feature_types" {
  description = "The Teams features enabled for a given user based on licensing or service plan."
  type        = list(string)
  default     = null
}

variable "is_enterprise_voice_enabled" {
  description = "Indicates whether voice capability is enabled."
  type        = bool
  default     = null
}

variable "modified_date_time" {
  description = "The date and time when the user's details were last modified. The system updates this value each time the user's details are changed. The timestamp represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAdministration.teamsUserConfiguration"
  nullable    = false
}

variable "telephone_numbers" {
  description = "Includes both the phone number and its corresponding assignment category. The assignment category can include values such as primary, private, and alternate."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.teamsAdministration.assignedTelephoneNumber")
    assignmentCategory = optional(string)
    telephoneNumber    = optional(string)
  }))
  default = null
}

variable "tenant_id" {
  description = "The unique identifier of the tenant in Entra to which this user is assigned."
  type        = string
  default     = null
}

variable "user" {
  description = "Represents an Entra user account."
  type        = any
  default     = null
}

variable "user_principal_name" {
  description = "The sign-in address of the user."
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
