variable "approver_group_ids" {
  description = "The Microsoft Entra ID (Azure AD) security group IDs for the approvers for the policy. This property is required when the policy is created, and is defined by the IT Admins to define the possible approvers for the policy."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Indicates the description of the policy. Maximum length of the description is 1024 characters. This property is not required, but can be used by the IT Admin to describe the policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Indicates the display name of the policy. Maximum length of the display name is 128 characters. This property is required when the policy is created, and is defined by the IT Admins to identify the policy."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.operationApprovalPolicy"
  nullable    = false
}

variable "policy_platform" {
  description = "The set of available platforms for the OperationApprovalPolicy. Allows configuration of a policy to specific platform(s) for approval. If no specific platform is required or applicable, the platform is `notApplicable`."
  type        = string
  default     = null

  validation {
    condition     = var.policy_platform == null ? true : contains(["notApplicable", "androidDeviceAdministrator", "androidEnterprise", "iOSiPadOS", "macOS", "windows10AndLater", "windows81AndLater", "windows10X", "unknownFutureValue"], var.policy_platform)
    error_message = "policy_platform must be one of the documented enum values."
  }
}

variable "policy_set" {
  description = "Indicates areas of the Intune UX that could support MAA UX for the current logged in IT Admin. This property is required, and is defined by the IT Admins in order to correctly show the expected experience."
  type        = any
  default     = null
}

variable "policy_type" {
  description = "The set of available policy types that can be configured for approval. The policy type must always be defined in an OperationApprovalRequest."
  type        = string
  default     = null

  validation {
    condition     = var.policy_type == null ? true : contains(["unknown", "deviceWipe", "deviceRetire", "deviceDelete", "app", "script", "role", "unknownFutureValue", "tenantConfiguration"], var.policy_type)
    error_message = "policy_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
