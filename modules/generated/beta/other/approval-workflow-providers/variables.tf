variable "business_flows" {
  description = "Microsoft Graph businessFlows property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.businessFlow")
    customData       = optional(string)
    deDuplicationId  = optional(string)
    description      = optional(string)
    displayName      = optional(string)
    policy           = optional(any)
    policyTemplateId = optional(string)
    recordVersion    = optional(string)
    schemaId         = optional(string)
    settings         = optional(any)
  }))
  default = null
}

variable "business_flows_with_requests_awaiting_my_decision" {
  description = "Microsoft Graph businessFlowsWithRequestsAwaitingMyDecision property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.businessFlow")
    customData       = optional(string)
    deDuplicationId  = optional(string)
    description      = optional(string)
    displayName      = optional(string)
    policy           = optional(any)
    policyTemplateId = optional(string)
    recordVersion    = optional(string)
    schemaId         = optional(string)
    settings         = optional(any)
  }))
  default = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.approvalWorkflowProvider"
  nullable    = false
}

variable "policy_templates" {
  description = "Microsoft Graph policyTemplates property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.governancePolicyTemplate")
    displayName = optional(string)
    policy      = optional(any)
    settings    = optional(any)
  }))
  default = null
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
