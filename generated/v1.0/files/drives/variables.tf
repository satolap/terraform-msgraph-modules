variable "bundles" {
  description = "Collection of bundles (albums and multi-select-shared sets of items). Only in personal OneDrive."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.driveItem")
    analytics       = optional(any)
    content         = optional(string)
    description     = optional(string)
    fileSystemInfo  = optional(any)
    name            = optional(string)
    parentReference = optional(any)
    retentionLabel  = optional(any)
    root            = optional(any)
    subscriptions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.subscription")
      changeType                = optional(string)
      clientState               = optional(string)
      encryptionCertificate     = optional(string)
      encryptionCertificateId   = optional(string)
      expirationDateTime        = optional(string)
      includeResourceData       = optional(bool)
      latestSupportedTlsVersion = optional(string)
      lifecycleNotificationUrl  = optional(string)
      notificationQueryOptions  = optional(string)
      notificationUrl           = optional(string)
      notificationUrlAppId      = optional(string)
      resource                  = optional(string)
    })))
    webDavUrl = optional(string)
    workbook  = optional(any)
  }))
  default = null
}

variable "description" {
  description = "Provides a user-visible description of the item. Optional."
  type        = string
  default     = null
}

variable "following" {
  description = "The list of items the user is following. Only in OneDrive for Business."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.driveItem")
    analytics       = optional(any)
    content         = optional(string)
    description     = optional(string)
    fileSystemInfo  = optional(any)
    name            = optional(string)
    parentReference = optional(any)
    retentionLabel  = optional(any)
    root            = optional(any)
    subscriptions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.subscription")
      changeType                = optional(string)
      clientState               = optional(string)
      encryptionCertificate     = optional(string)
      encryptionCertificateId   = optional(string)
      expirationDateTime        = optional(string)
      includeResourceData       = optional(bool)
      latestSupportedTlsVersion = optional(string)
      lifecycleNotificationUrl  = optional(string)
      notificationQueryOptions  = optional(string)
      notificationUrl           = optional(string)
      notificationUrlAppId      = optional(string)
      resource                  = optional(string)
    })))
    webDavUrl = optional(string)
    workbook  = optional(any)
  }))
  default = null
}

variable "name" {
  description = "The name of the item. Read-write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.drive"
  nullable    = false
}

variable "parent_reference" {
  description = "Parent information, if the item has a parent. Read-write."
  type        = any
  default     = null
}

variable "share_point_ids" {
  description = "Microsoft Graph sharePointIds property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdByUser", "createdDateTime", "driveType", "eTag", "id", "items", "lastModifiedBy", "lastModifiedByUser", "lastModifiedDateTime", "list", "owner", "quota", "root", "special", "system", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
