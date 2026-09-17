variable "children" {
  description = "The children categories"
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.groupPolicyCategory")
    children       = optional(any)
    definitionFile = optional(any)
    definitions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.groupPolicyDefinition")
      category                  = optional(any)
      categoryPath              = optional(string)
      classType                 = optional(string)
      definitionFile            = optional(any)
      displayName               = optional(string)
      explainText               = optional(string)
      groupPolicyCategoryId     = optional(string)
      hasRelatedDefinitions     = optional(bool)
      lastModifiedDateTime      = optional(string)
      minDeviceCspVersion       = optional(string)
      minUserCspVersion         = optional(string)
      nextVersionDefinition     = optional(any)
      policyType                = optional(string)
      presentations             = optional(any)
      previousVersionDefinition = optional(any)
      supportedOn               = optional(string)
      version                   = optional(string)
    })))
    displayName          = optional(string)
    ingestionSource      = optional(string)
    isRoot               = optional(bool)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
  }))
  default = null
}

variable "definition_file" {
  description = "The id of the definition file the category came from"
  type        = any
  default     = null
}

variable "definitions" {
  description = "The immediate GroupPolicyDefinition children of the category"
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.groupPolicyDefinition")
    category              = optional(any)
    categoryPath          = optional(string)
    classType             = optional(string)
    definitionFile        = optional(any)
    displayName           = optional(string)
    explainText           = optional(string)
    groupPolicyCategoryId = optional(string)
    hasRelatedDefinitions = optional(bool)
    lastModifiedDateTime  = optional(string)
    minDeviceCspVersion   = optional(string)
    minUserCspVersion     = optional(string)
    nextVersionDefinition = optional(any)
    policyType            = optional(string)
    presentations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.groupPolicyPresentation")
      definition           = optional(any)
      label                = optional(string)
      lastModifiedDateTime = optional(string)
    })))
    previousVersionDefinition = optional(any)
    supportedOn               = optional(string)
    version                   = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The string id of the category's display name"
  type        = string
  default     = null
}

variable "ingestion_source" {
  description = "Category Ingestion source"
  type        = string
  default     = null

  validation {
    condition     = var.ingestion_source == null ? true : contains(["unknown", "custom", "builtIn", "unknownFutureValue"], var.ingestion_source)
    error_message = "ingestion_source must be one of the documented enum values."
  }
}

variable "is_root" {
  description = "Defines if the category is a root category"
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyCategory"
  nullable    = false
}

variable "parent" {
  description = "The parent category"
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
