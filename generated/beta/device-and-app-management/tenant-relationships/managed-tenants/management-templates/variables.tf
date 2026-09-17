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

variable "graph_provider" {
  description = "Microsoft Graph provider property."
  type        = string
  default     = null

  validation {
    condition     = var.graph_provider == null ? true : contains(["microsoft", "community", "indirectProvider", "self", "unknownFutureValue"], var.graph_provider)
    error_message = "graph_provider must be one of the documented enum values."
  }
}

variable "graph_version" {
  description = "Microsoft Graph version property."
  type        = number
  default     = null
}

variable "information_links" {
  description = "Microsoft Graph informationLinks property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.actionUrl")
    displayName = optional(string)
    url         = optional(string)
  }))
  default = null
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

variable "management_template_collections" {
  description = "Microsoft Graph managementTemplateCollections property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.managedTenants.managementTemplateCollection")
    createdByUserId    = optional(string)
    createdDateTime    = optional(string)
    description        = optional(string)
    displayName        = optional(string)
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    managementTemplates = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.managedTenants.managementTemplate")
      createdByUserId               = optional(string)
      createdDateTime               = optional(string)
      informationLinks              = optional(any)
      lastActionByUserId            = optional(string)
      lastActionDateTime            = optional(string)
      managementTemplateCollections = optional(any)
      managementTemplateSteps       = optional(any)
      priority                      = optional(number)
      provider                      = optional(string)
      userImpact                    = optional(string)
      version                       = optional(number)
    })))
  }))
  default = null
}

variable "management_template_steps" {
  description = "Microsoft Graph managementTemplateSteps property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.managedTenants.managementTemplateStep")
    acceptedVersion = optional(any)
    category        = optional(any)
    createdByUserId = optional(string)
    createdDateTime = optional(string)
    description     = optional(string)
    displayName     = optional(string)
    informationLinks = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.actionUrl")
      displayName = optional(string)
      url         = optional(string)
    })))
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    managementTemplate = optional(any)
    portalLink         = optional(any)
    priority           = optional(number)
    userImpact         = optional(string)
    versions = optional(list(object({
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
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplate"
  nullable    = false
}

variable "priority" {
  description = "Microsoft Graph priority property."
  type        = number
  default     = null
}

variable "user_impact" {
  description = "Microsoft Graph userImpact property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["category", "description", "displayName", "id", "parameters", "workloadActions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
