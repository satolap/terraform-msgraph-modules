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

variable "drive_item" {
  description = "Used to access the underlying driveItem"
  type        = any
  default     = null
}

variable "items" {
  description = "All driveItems contained in the sharing root. This collection cannot be enumerated."
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

variable "list" {
  description = "Used to access the underlying list"
  type        = any
  default     = null
}

variable "list_item" {
  description = "Used to access the underlying listItem"
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
  default     = "#microsoft.graph.sharedDriveItem"
  nullable    = false
}

variable "owner" {
  description = "Information about the owner of the shared item being referenced."
  type        = any
  default     = null
}

variable "parent_reference" {
  description = "Parent information, if the item has a parent. Read-write."
  type        = any
  default     = null
}

variable "permission" {
  description = "Used to access the permission representing the underlying sharing link"
  type        = any
  default     = null
}

variable "root" {
  description = "Microsoft Graph root property."
  type        = any
  default     = null
}

variable "site" {
  description = "Used to access the underlying site"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "eTag", "id", "lastModifiedBy", "lastModifiedDateTime", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
