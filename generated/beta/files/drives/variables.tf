variable "activities" {
  description = "The list of recent activities that took place under this drive."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
    action     = optional(any)
    actor      = optional(any)
    driveItem  = optional(any)
    listItem   = optional(any)
    times      = optional(any)
  }))
  default = null
}

variable "bundles" {
  description = "Collection of bundles (albums and multi-select-shared sets of items). Only in personal OneDrive."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.driveItem")
    activities = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
      action     = optional(any)
      actor      = optional(any)
      driveItem  = optional(any)
      listItem   = optional(any)
      times      = optional(any)
    })))
    analytics     = optional(any)
    content       = optional(string)
    contentStream = optional(string)
    createdByUser = optional(any)
    description   = optional(string)
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    fileSystemInfo     = optional(any)
    lastModifiedByUser = optional(any)
    media              = optional(any)
    name               = optional(string)
    parentReference    = optional(any)
    retentionLabel     = optional(any)
    root               = optional(any)
    subscriptions = optional(list(object({
      odata_type                       = optional(string, "#microsoft.graph.subscription")
      changeType                       = optional(string)
      clientState                      = optional(string)
      encryptionCertificate            = optional(string)
      encryptionCertificateId          = optional(string)
      expirationDateTime               = optional(string)
      includeResourceData              = optional(bool)
      latestSupportedTlsVersion        = optional(string)
      lifecycleNotificationUrl         = optional(string)
      notificationContentType          = optional(string)
      notificationQueryOptions         = optional(string)
      notificationUrl                  = optional(string)
      notificationUrlAppId             = optional(string)
      resource                         = optional(string)
      vapidPublicKey                   = optional(string)
      webPushEncryptionP256dhPublicKey = optional(string)
      webPushEncryptionSecret          = optional(string)
    })))
    webDavUrl = optional(string)
    workbook  = optional(any)
  }))
  default   = null
  sensitive = true
}

variable "created_by_user" {
  description = "Microsoft Graph createdByUser property."
  type        = any
  default     = null
}

variable "description" {
  description = "The description of the item."
  type        = string
  default     = null
}

variable "following" {
  description = "The list of items the user is following. Only in OneDrive for Business."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.driveItem")
    activities = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.itemActivityOLD")
      action     = optional(any)
      actor      = optional(any)
      driveItem  = optional(any)
      listItem   = optional(any)
      times      = optional(any)
    })))
    analytics     = optional(any)
    content       = optional(string)
    contentStream = optional(string)
    createdByUser = optional(any)
    description   = optional(string)
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    fileSystemInfo     = optional(any)
    lastModifiedByUser = optional(any)
    media              = optional(any)
    name               = optional(string)
    parentReference    = optional(any)
    retentionLabel     = optional(any)
    root               = optional(any)
    subscriptions = optional(list(object({
      odata_type                       = optional(string, "#microsoft.graph.subscription")
      changeType                       = optional(string)
      clientState                      = optional(string)
      encryptionCertificate            = optional(string)
      encryptionCertificateId          = optional(string)
      expirationDateTime               = optional(string)
      includeResourceData              = optional(bool)
      latestSupportedTlsVersion        = optional(string)
      lifecycleNotificationUrl         = optional(string)
      notificationContentType          = optional(string)
      notificationQueryOptions         = optional(string)
      notificationUrl                  = optional(string)
      notificationUrlAppId             = optional(string)
      resource                         = optional(string)
      vapidPublicKey                   = optional(string)
      webPushEncryptionP256dhPublicKey = optional(string)
      webPushEncryptionSecret          = optional(string)
    })))
    webDavUrl = optional(string)
    workbook  = optional(any)
  }))
  default   = null
  sensitive = true
}

variable "last_modified_by_user" {
  description = "Microsoft Graph lastModifiedByUser property."
  type        = any
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "driveType", "eTag", "id", "items", "lastModifiedBy", "lastModifiedDateTime", "list", "owner", "quota", "root", "settings", "special", "system", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
