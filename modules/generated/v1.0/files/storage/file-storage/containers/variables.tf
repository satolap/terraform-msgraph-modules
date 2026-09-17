variable "assigned_sensitivity_label" {
  description = "Sensitivity label assigned to the fileStorageContainer. Read-write."
  type        = any
  default     = null
}

variable "columns" {
  description = "The set of custom structured metadata supported by the fileStorageContainer. Read-write."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.columnDefinition")
    boolean               = optional(any)
    calculated            = optional(any)
    choice                = optional(any)
    columnGroup           = optional(string)
    contentApprovalStatus = optional(any)
    currency              = optional(any)
    dateTime              = optional(any)
    defaultValue          = optional(any)
    description           = optional(string)
    displayName           = optional(string)
    enforceUniqueValues   = optional(bool)
    geolocation           = optional(any)
    hidden                = optional(bool)
    hyperlinkOrPicture    = optional(any)
    indexed               = optional(bool)
    isDeletable           = optional(bool)
    isSealed              = optional(bool)
    lookup                = optional(any)
    name                  = optional(string)
    number                = optional(any)
    personOrGroup         = optional(any)
    propagateChanges      = optional(bool)
    readOnly              = optional(bool)
    required              = optional(bool)
    sourceColumn          = optional(any)
    term                  = optional(any)
    text                  = optional(any)
    thumbnail             = optional(any)
    validation            = optional(any)
  }))
  default = null
}

variable "custom_properties" {
  description = "Custom property collection for the fileStorageContainer. Read-write."
  type        = any
  default     = null
}

variable "description" {
  description = "Provides a user-visible description of the fileStorageContainer. Read-write."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the fileStorageContainer. Read-write."
  type        = string
  default     = null
}

variable "migration_jobs" {
  description = "The collection of sharePointMigrationJob objects local to the container. Read-write."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.sharePointMigrationJob")
    containerInfo = optional(object({
      odata_type = optional(string, "#microsoft.graph.sharePointMigrationContainerInfo")
    }))
    progressEvents = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.sharePointMigrationEvent")
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.fileStorageContainer"
  nullable    = false
}

variable "permissions" {
  description = "The set of permissions for users in the fileStorageContainer. Permission for each user is set by the roles property. The possible values are: reader, writer, manager, and owner. Read-write."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.permission")
    expirationDateTime = optional(string)
  }))
  default = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.fileStorageContainerSettings")
    isItemVersioningEnabled = optional(bool)
    isOcrEnabled            = optional(bool)
    itemMajorVersionLimit   = optional(number)
  })
  default = null
}

variable "share_point_groups" {
  description = "The collection of sharePointGroup objects local to the container. Read-write."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.sharePointGroup")
    description = optional(string)
    members = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.sharePointGroupMember")
      identity   = optional(any)
    })))
    title = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["containerTypeId", "createdDateTime", "drive", "id", "lockState", "recycleBin", "status", "viewpoint"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
