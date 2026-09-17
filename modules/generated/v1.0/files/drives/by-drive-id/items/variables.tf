variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "analytics" {
  description = "Analytics about the view activities that took place on this item."
  type        = any
  default     = null
}

variable "content" {
  description = "The content stream, if the item represents a file."
  type        = string
  default     = null
}

variable "description" {
  description = "Provides a user-visible description of the item. Optional."
  type        = string
  default     = null
}

variable "file_system_info" {
  description = "File system information on client. Read-write."
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
  default     = "#microsoft.graph.driveItem"
  nullable    = false
}

variable "parent_reference" {
  description = "Parent information, if the item has a parent. Read-write."
  type        = any
  default     = null
}

variable "retention_label" {
  description = "Information about retention label and settings enforced on the driveItem. Read-write."
  type        = any
  default     = null
}

variable "root" {
  description = "If this property is non-null, it indicates that the driveItem is the top-most driveItem in the drive."
  type        = any
  default     = null
}

variable "subscriptions" {
  description = "The set of subscriptions on the item. Only supported on the root of a drive."
  type = list(object({
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
  }))
  default = null
}

variable "web_dav_url" {
  description = "WebDAV compatible URL for the item."
  type        = string
  default     = null
}

variable "workbook" {
  description = "For files that are Excel spreadsheets, access to the workbook API to work with the spreadsheet's contents. Nullable."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["audio", "bundle", "cTag", "children", "createdBy", "createdByUser", "createdDateTime", "deleted", "eTag", "file", "folder", "id", "image", "lastModifiedBy", "lastModifiedByUser", "lastModifiedDateTime", "listItem", "location", "malware", "package", "pendingOperations", "permissions", "photo", "publication", "remoteItem", "searchResult", "shared", "sharepointIds", "size", "specialFolder", "thumbnails", "versions", "video", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
