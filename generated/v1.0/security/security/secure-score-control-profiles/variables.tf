variable "action_type" {
  description = "Control action type (Config, Review, Behavior)."
  type        = string
  default     = null
}

variable "action_url" {
  description = "URL to where the control can be actioned."
  type        = string
  default     = null
}

variable "azure_tenant_id" {
  description = "GUID string for tenant ID."
  type        = string
  default     = null
}

variable "compliance_information" {
  description = "The collection of compliance information associated with secure score control. Not implemented. Currently returns null."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.complianceInformation")
    certificationControls = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.certificationControl")
      name       = optional(string)
      url        = optional(string)
    })))
    certificationName = optional(string)
  }))
  default = null
}

variable "control_category" {
  description = "Control action category (Identity, Data, Device, Apps, Infrastructure)."
  type        = string
  default     = null
}

variable "control_state_updates" {
  description = "Flag to indicate where the tenant has marked a control (ignored, thirdParty, reviewed) (supports update)."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.secureScoreControlStateUpdate")
    assignedTo      = optional(string)
    comment         = optional(string)
    state           = optional(string)
    updatedBy       = optional(string)
    updatedDateTime = optional(string)
  }))
  default = null
}

variable "deprecated" {
  description = "Flag to indicate if a control is depreciated."
  type        = bool
  default     = null
}

variable "implementation_cost" {
  description = "Resource cost of implemmentating control (low, moderate, high)."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Time at which the control profile entity was last modified. The Timestamp type represents date and time"
  type        = string
  default     = null
}

variable "max_score" {
  description = "max attainable score for the control."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.secureScoreControlProfile"
  nullable    = false
}

variable "rank" {
  description = "Microsoft's stack ranking of control."
  type        = number
  default     = null
}

variable "remediation" {
  description = "Description of what the control will help remediate."
  type        = string
  default     = null
}

variable "remediation_impact" {
  description = "Description of the impact on users of the remediation."
  type        = string
  default     = null
}

variable "service" {
  description = "Service that owns the control (Exchange, Sharepoint, Microsoft Entra ID)."
  type        = string
  default     = null
}

variable "threats" {
  description = "List of threats the control mitigates (accountBreach, dataDeletion, dataExfiltration, dataSpillage, elevationOfPrivilege, maliciousInsider, passwordCracking, phishingOrWhaling, spoofing)."
  type        = list(string)
  default     = null
}

variable "tier" {
  description = "Control tier (Core, Defense in Depth, Advanced.)"
  type        = string
  default     = null
}

variable "title" {
  description = "Title of the control."
  type        = string
  default     = null
}

variable "user_impact" {
  description = "User impact of implementing control (low, moderate, high)."
  type        = string
  default     = null
}

variable "vendor_information" {
  description = "Complex type containing details about the security product/service vendor, provider, and subprovider (for example, vendor=Microsoft; provider=SecureScore). Required."
  type        = any
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
