variable "access_package_custom_workflow_extensions" {
  description = "The attributes of a logic app, which can be called at various stages of an access package request and assignment cycle."
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

variable "access_package_resource_scopes" {
  description = "Microsoft Graph accessPackageResourceScopes property."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.accessPackageResourceScope")
    accessPackageResource = optional(any)
    description           = optional(string)
    displayName           = optional(string)
    isRootScope           = optional(bool)
    originId              = optional(string)
    originSystem          = optional(string)
    roleOriginId          = optional(string)
    url                   = optional(string)
  }))
  default = null
}

variable "access_package_resources" {
  description = "Microsoft Graph accessPackageResources property."
  type = list(object({
    odata_type                       = optional(string, "#microsoft.graph.accessPackageResource")
    accessPackageResourceEnvironment = optional(any)
    attributes = optional(list(object({
      odata_type                     = optional(string, "#microsoft.graph.accessPackageResourceAttribute")
      attributeDestination           = optional(any)
      attributeName                  = optional(string)
      attributeSource                = optional(any)
      isEditable                     = optional(bool)
      isPersistedOnAssignmentRemoval = optional(bool)
    })))
    description  = optional(string)
    displayName  = optional(string)
    originId     = optional(string)
    originSystem = optional(string)
    resourceType = optional(string)
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
    url = optional(string)
  }))
  default = null
}

variable "catalog_status" {
  description = "Has the value Published if the access packages are available for management."
  type        = string
  default     = null
}

variable "catalog_type" {
  description = "One of UserManaged or ServiceDefault."
  type        = string
  default     = null
}

variable "custom_access_package_workflow_extensions" {
  description = "Microsoft Graph customAccessPackageWorkflowExtensions property."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.customAccessPackageWorkflowExtension")
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
  description = "The display name of the access package catalog. Supports $filter (eq, contains)."
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

variable "privilege_level" {
  description = "Microsoft Graph privilegeLevel property."
  type        = string
  default     = null

  validation {
    condition     = var.privilege_level == null ? true : contains(["standard", "privileged", "unknownFutureValue"], var.privilege_level)
    error_message = "privilege_level must be one of the documented enum values."
  }
}

variable "unique_name" {
  description = "Microsoft Graph uniqueName property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackageResourceRoles", "accessPackages", "createdBy", "createdDateTime", "id", "modifiedBy", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
