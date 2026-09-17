variable "management_template_step_version_id" {
  description = "The unique identifier of managementTemplateStepVersion"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.management_template_step_version_id)) > 0
    error_message = "management_template_step_version_id must not be empty."
  }
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

variable "error" {
  description = "Microsoft Graph error property."
  type        = any
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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplateStepDeployment"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "inProgress", "completed", "failed", "ineligible", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "template_step_version" {
  description = "Microsoft Graph templateStepVersion property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepVersion")
    acceptedFor     = optional(any)
    contentMarkdown = optional(string)
    createdByUserId = optional(string)
    createdDateTime = optional(string)
    deployments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.managedTenants.managementTemplateStepDeployment")
      createdByUserId     = optional(string)
      createdDateTime     = optional(string)
      error               = optional(any)
      lastActionByUserId  = optional(string)
      lastActionDateTime  = optional(string)
      status              = optional(string)
      templateStepVersion = optional(any)
      tenantId            = optional(string)
    })))
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    name               = optional(string)
    templateStep       = optional(any)
    version            = optional(number)
    versionInformation = optional(string)
  })
  default = null
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
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
