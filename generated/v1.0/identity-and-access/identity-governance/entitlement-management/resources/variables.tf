variable "attributes" {
  description = "Contains information about the attributes to be collected from the requestor and sent to the resource application."
  type = list(object({
    odata_type                     = optional(string, "#microsoft.graph.accessPackageResourceAttribute")
    destination                    = optional(any)
    isEditable                     = optional(bool)
    isPersistedOnAssignmentRemoval = optional(bool)
    name                           = optional(string)
    source                         = optional(any)
  }))
  default = null
}

variable "description" {
  description = "A description for the resource."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the resource, such as the application name, group name or site name."
  type        = string
  default     = null
}

variable "environment" {
  description = "Contains the environment information for the resource. This can be set using either the @odata.bind annotation or the environment's originId.Supports $expand."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResource"
  nullable    = false
}

variable "origin_id" {
  description = "The unique identifier of the resource in the origin system. For a Microsoft Entra group, this is the identifier of the group."
  type        = string
  default     = null
}

variable "origin_system" {
  description = "The type of the resource in the origin system, such as SharePointOnline, AadApplication or AadGroup."
  type        = string
  default     = null
}

variable "upload_sessions" {
  description = "The upload sessions for uploading external access data to this resource through the Bring Your Own Data (BYOD) flow."
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

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "externalOriginResourceConnector", "id", "modifiedDateTime", "roles", "scopes"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
