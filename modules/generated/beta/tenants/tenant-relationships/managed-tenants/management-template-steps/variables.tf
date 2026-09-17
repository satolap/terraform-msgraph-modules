variable "accepted_version" {
  description = "Microsoft Graph acceptedVersion property."
  type        = any
  default     = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = any
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["custom", "devices", "identity", "data", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
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

variable "management_template" {
  description = "Microsoft Graph managementTemplate property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplateStep"
  nullable    = false
}

variable "portal_link" {
  description = "Microsoft Graph portalLink property."
  type        = any
  default     = null
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

variable "versions" {
  description = "Microsoft Graph versions property."
  type = list(object({
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
