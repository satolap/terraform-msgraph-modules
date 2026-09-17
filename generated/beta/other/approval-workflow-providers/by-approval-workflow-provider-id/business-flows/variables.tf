variable "approval_workflow_provider_id" {
  description = "The unique identifier of approvalWorkflowProvider"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.approval_workflow_provider_id)) > 0
    error_message = "approval_workflow_provider_id must not be empty."
  }
}

variable "custom_data" {
  description = "Microsoft Graph customData property."
  type        = string
  default     = null
}

variable "de_duplication_id" {
  description = "Microsoft Graph deDuplicationId property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.businessFlow"
  nullable    = false
}

variable "policy" {
  description = "Microsoft Graph policy property."
  type        = any
  default     = null
}

variable "policy_template_id" {
  description = "Microsoft Graph policyTemplateId property."
  type        = string
  default     = null
}

variable "record_version" {
  description = "Microsoft Graph recordVersion property."
  type        = string
  default     = null
}

variable "schema_id" {
  description = "Microsoft Graph schemaId property."
  type        = string
  default     = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
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
