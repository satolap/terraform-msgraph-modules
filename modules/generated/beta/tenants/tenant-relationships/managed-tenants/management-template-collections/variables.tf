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

variable "management_templates" {
  description = "Microsoft Graph managementTemplates property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.managedTenants.managementTemplate")
    createdByUserId = optional(string)
    createdDateTime = optional(string)
    informationLinks = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.actionUrl")
      displayName = optional(string)
      url         = optional(string)
    })))
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    managementTemplateCollections = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.managedTenants.managementTemplateCollection")
      createdByUserId     = optional(string)
      createdDateTime     = optional(string)
      description         = optional(string)
      displayName         = optional(string)
      lastActionByUserId  = optional(string)
      lastActionDateTime  = optional(string)
      managementTemplates = optional(any)
    })))
    managementTemplateSteps = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.managedTenants.managementTemplateStep")
      acceptedVersion    = optional(any)
      category           = optional(any)
      createdByUserId    = optional(string)
      createdDateTime    = optional(string)
      description        = optional(string)
      displayName        = optional(string)
      informationLinks   = optional(any)
      lastActionByUserId = optional(string)
      lastActionDateTime = optional(string)
      managementTemplate = optional(any)
      portalLink         = optional(any)
      priority           = optional(number)
      userImpact         = optional(string)
      versions           = optional(any)
    })))
    priority   = optional(number)
    provider   = optional(string)
    userImpact = optional(string)
    version    = optional(number)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementTemplateCollection"
  nullable    = false
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
