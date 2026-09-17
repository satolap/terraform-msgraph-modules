variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "activities" {
  description = "The list of recent activities that took place on this item."
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

variable "analytics" {
  description = "Analytics about the view activities that took place on this item."
  type        = any
  default     = null
}

variable "content" {
  description = "The content stream, if the item represents a file. The content property will have a potentially breaking change in behavior in the future. It will stream content directly instead of redirecting. To proactively opt in to the new behavior ahead of time, use the contentStream property instead."
  type        = string
  default     = null
}

variable "content_stream" {
  description = "The content stream, if the item represents a file."
  type        = string
  default     = null
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

variable "extensions" {
  description = "The collection of open extensions defined for this item. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "file_system_info" {
  description = "File system information on client. Read-write."
  type        = any
  default     = null
}

variable "last_modified_by_user" {
  description = "Microsoft Graph lastModifiedByUser property."
  type        = any
  default     = null
}

variable "media" {
  description = "Information about the media (audio or video) item. Read-write. Only on OneDrive for Business and SharePoint."
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
  }))
  default   = null
  sensitive = true
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["audio", "bundle", "cTag", "children", "createdBy", "createdDateTime", "deleted", "eTag", "file", "folder", "id", "image", "lastModifiedBy", "lastModifiedDateTime", "listItem", "location", "lockInfo", "malware", "package", "pendingOperations", "permissions", "photo", "publication", "remoteItem", "searchResult", "shared", "sharepointIds", "size", "source", "specialFolder", "thumbnails", "versions", "video", "viewpoint", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
