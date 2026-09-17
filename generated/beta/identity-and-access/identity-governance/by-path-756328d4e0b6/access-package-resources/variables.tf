variable "access_package_catalog_id" {
  description = "The unique identifier of accessPackageCatalog"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_catalog_id)) > 0
    error_message = "access_package_catalog_id must not be empty."
  }
}

variable "access_package_resource_environment" {
  description = "Contains the environment information for the resource. This environment can be set using either the @odata.bind annotation or the environment's originId. Supports $expand."
  type        = any
  default     = null
}

variable "attributes" {
  description = "Contains information about the attributes to be collected from the requestor and sent to the resource application."
  type = list(object({
    odata_type                     = optional(string, "#microsoft.graph.accessPackageResourceAttribute")
    attributeDestination           = optional(any)
    attributeName                  = optional(string)
    attributeSource                = optional(any)
    isEditable                     = optional(bool)
    isPersistedOnAssignmentRemoval = optional(bool)
  }))
  default = null
}

variable "description" {
  description = "A description for the resource."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the resource, such as the application name, group name, or site name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResource"
  nullable    = false
}

variable "origin_id" {
  description = "The unique identifier of the resource in the origin system. In the case of a Microsoft Entra group, originId is the identifier of the group. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "origin_system" {
  description = "The type of the resource in the origin system, such as SharePointOnline, AadApplication, AadGroup or CustomDataProvidedResource. Supports $filter and $expand (eq)."
  type        = string
  default     = null
}

variable "resource_type" {
  description = "The type of the resource, such as Application if it is a Microsoft Entra connected application, or SharePoint Online Site for a SharePoint Online site."
  type        = string
  default     = null
}

variable "upload_sessions" {
  description = "Microsoft Graph uploadSessions property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceUploadSession")
    data       = optional(any)
    files = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceFile")
      name       = optional(string)
    })))
    isUploadDone = optional(bool)
    referenceId  = optional(string)
    stats = optional(object({
      odata_type         = optional(string, "#microsoft.graph.customDataProvidedResourceUploadStats")
      filesUploaded      = optional(number)
      totalBytesUploaded = optional(number)
    }))
    status = optional(string)
  }))
  default = null
}

variable "url" {
  description = "A unique resource locator for the resource, such as the URL for signing a user into an application."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackageResourceRoles", "accessPackageResourceScopes", "addedBy", "addedOn", "externalOriginResourceConnector", "id", "isPendingOnboarding"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
