variable "accepted_for" {
  description = "Microsoft Graph acceptedFor property."
  type        = any
  default     = null
}

variable "content_markdown" {
  description = "Microsoft Graph contentMarkdown property."
  type        = string
  default     = null
}

variable "created_by_user_id" {
  description = "Microsoft Graph createdByUserId property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "deployments" {
  description = "Microsoft Graph deployments property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepDeployment")
    createdByUserId    = optional(string)
    createdDateTime    = optional(string)
    error              = optional(any)
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    status             = optional(string)
    templateStepVersion = optional(object({
      odata_type         = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepVersion")
      acceptedFor        = optional(any)
      contentMarkdown    = optional(string)
      createdByUserId    = optional(string)
      createdDateTime    = optional(string)
      deployments        = optional(any)
      lastActionByUserId = optional(string)
      lastActionDateTime = optional(string)
      name               = optional(string)
      templateStep       = optional(any)
      version            = optional(number)
      versionInformation = optional(string)
    }))
    tenantId = optional(string)
  }))
  default = null
}

variable "graph_version" {
  description = "Microsoft Graph version property."
  type        = number
  default     = null
}

variable "last_action_by_user_id" {
  description = "Microsoft Graph lastActionByUserId property."
  type        = string
  default     = null
}

variable "last_action_date_time" {
  description = "Microsoft Graph lastActionDateTime property."
  type        = string
  default     = null
}

variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplateStepVersion"
  nullable    = false
}

variable "template_step" {
  description = "Microsoft Graph templateStep property."
  type        = any
  default     = null
}

variable "version_information" {
  description = "Microsoft Graph versionInformation property."
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
