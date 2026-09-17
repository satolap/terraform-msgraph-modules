variable "catalog_type" {
  description = "Whether the catalog is created by a user or entitlement management. The possible values are: userManaged, serviceDefault, serviceManaged, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.catalog_type == null ? true : contains(["userManaged", "serviceDefault", "serviceManaged", "unknownFutureValue"], var.catalog_type)
    error_message = "catalog_type must be one of the documented enum values."
  }
}

variable "custom_workflow_extensions" {
  description = "Microsoft Graph customWorkflowExtensions property."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.customCalloutExtension")
    authenticationConfiguration = optional(any)
    clientConfiguration         = optional(any)
    description                 = optional(string)
    displayName                 = optional(string)
    endpointConfiguration       = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The description of the access package catalog."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the access package catalog."
  type        = string
  default     = null
}

variable "is_externally_visible" {
  description = "Whether the access packages in this catalog can be requested by users outside of the tenant."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageCatalog"
  nullable    = false
}

variable "resource_roles" {
  description = "Microsoft Graph resourceRoles property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.accessPackageResourceRole")
    description  = optional(string)
    displayName  = optional(string)
    originId     = optional(string)
    originSystem = optional(string)
    resource     = optional(any)
    type         = optional(any)
  }))
  default = null
}

variable "resource_scopes" {
  description = "Microsoft Graph resourceScopes property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.accessPackageResourceScope")
    description  = optional(string)
    displayName  = optional(string)
    isRootScope  = optional(bool)
    originId     = optional(string)
    originSystem = optional(string)
    resource     = optional(any)
  }))
  default = null
}

variable "resources" {
  description = "Access package resources in this catalog."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessPackageResource")
    attributes = optional(list(object({
      odata_type                     = optional(string, "#microsoft.graph.accessPackageResourceAttribute")
      destination                    = optional(any)
      isEditable                     = optional(bool)
      isPersistedOnAssignmentRemoval = optional(bool)
      name                           = optional(string)
      source                         = optional(any)
    })))
    description  = optional(string)
    displayName  = optional(string)
    environment  = optional(any)
    originId     = optional(string)
    originSystem = optional(string)
    uploadSessions = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.customDataProvidedResourceUploadSession")
      data         = optional(any)
      files        = optional(any)
      isUploadDone = optional(bool)
      referenceId  = optional(string)
      stats = optional(object({
        odata_type         = optional(string, "#microsoft.graph.customDataProvidedResourceUploadStats")
        filesUploaded      = optional(number)
        totalBytesUploaded = optional(number)
      }))
      status = optional(string)
    })))
  }))
  default = null
}

variable "state" {
  description = "Has the value published if the access packages are available for management. The possible values are: unpublished, published, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unpublished", "published", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackages", "createdDateTime", "id", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
